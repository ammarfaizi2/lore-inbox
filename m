Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289865AbSAKETz>; Thu, 10 Jan 2002 23:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289866AbSAKETk>; Thu, 10 Jan 2002 23:19:40 -0500
Received: from pilot05.cl.msu.edu ([35.9.5.25]:30957 "EHLO pilot05.cl.msu.edu")
	by vger.kernel.org with ESMTP id <S289865AbSAKETS>;
	Thu, 10 Jan 2002 23:19:18 -0500
From: "Pei Zheng" <zhengpei@msu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: strange kernel message when hacking the NIC driver
Date: Thu, 10 Jan 2002 23:19:20 -0500
Message-ID: <LIECKFOKGFCHAPOBKPECEEGCCNAA.zhengpei@msu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I've done some simple hackings to the network device driver. Basically
i want to connect two NICs as a point-to-point link,ie, packets sending
out from one NIC will be redirected to another NIC, sort of direct-link
cable between these two NICs.
So in the drivers of these two NICs, before hart_start_xmit(), the skb's 
header will be forcibly set to its peer's MAC address, thus each packey
sending out from one NIC will be directly diverted to its peer NIC. This 
works fine most of the case since tcpdump shows that packets traverse in
this way. However, i found errors in system log:

Jan 10 18:02:40 em2 kernel: 1130: 09 => cb
Jan 10 18:02:40 em2 kernel: 388: f4 => 45
Jan 10 18:02:40 em2 kernel: 26: c0 => 7d
Jan 10 18:02:40 em2 kernel: 149: 1f => 98
Jan 10 18:02:40 em2 kernel: After error applied:
Jan 10 18:02:40 em2 kernel: 00 80 c8 b9 6b b6 00 80 c8 b9 6b b6 08 00
45 00
Jan 10 18:02:40 em2 kernel: 05 dc 73 cd 20 b9 3f 11 44 26 7d a8 0c 0a
c0 a8
Jan 10 18:02:40 em2 kernel: 10 0a e3 c1 4c 1f 6f 83 61 dc fc 5e 5c f4
66 17
Jan 10 18:02:40 em2 kernel: 2c 73 19 ce cc 2d 69 69 bd 43 33 6d 82 de
4a 87
Jan 10 18:02:40 em2 kernel: 8d 9d 81 f6 2e b2 8c 6a d5 e4 f2 e6 bc ab
5a 01
Jan 10 18:02:40 em2 kernel: 34 d5 39 f8 d9 5b 16 bc dc 95 bd b4 08 a9
5e 11
Jan 10 18:02:40 em2 kernel: df 38 80 8a ca d8 1c 53 65 97 91 4c 84 5a
a1 0e
Jan 10 18:02:40 em2 kernel: c2 5f d4 02 a1 9e 1c 35 d4 95 08 44 81 16
a3 e0

there are many this kind of messages. Don't understand what it is. the
beginning part of the data seems to be an icmp packet(00 80 c8 b9 6b
b6 is the MAC of one NIC). For some reason kernel thinks that this
packet is not correct. Any idea about this? If i want to modify a
packet's header before it goes to hard_strat_xmit(), what else should
i do except setting the skb header to the MAC of the NIC's peer only? 
checksum stuff?

Any helps will be highly appreciated.

-Pei

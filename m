Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTIPSvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTIPSvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 14:51:08 -0400
Received: from [207.175.35.50] ([207.175.35.50]:11862 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S262008AbTIPSvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 14:51:06 -0400
Message-ID: <3F675B68.8000109@eternal-systems.com>
Date: Tue, 16 Sep 2003 11:50:16 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Incremental update of TCP Checksum
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a very simple question, which a lot of you would have solved. I 
am intercepting a TCP packet, which I would like to change slightly.

Let's say, I change the doff field of the tcp-header (for eg: increase 
it by 1). I know it is wrong just to change the doff field without 
increasing the packet length, but lets say I do it just as a test. Since 
I changed a portion of the tcp header, I have to update the tcp checksum 
too right!!! If so, what is the best way to do so, without having to 
recalculate the entire tcp checksum (I know how to recalculate the 
checksum from scratch).

Can anyone out there tell me the algorithm to update the checksum 
without having to recalculate it.

I tried the following algorithm but it didnt work. The packet got 
rejected as a packet with bad cksum.

void changePacket(struct sk_buff* skb)
{
     struct tcphdr *tcpHdr = skb->h.th;
     // Verifying the tcp checksum works here...
     tcpHeader->doff += 1;
     long cksum = (~(tcpHdr->check))&0xffff;
     cksum += 1;
     while (cksum >> 16)
     {
         cksum = (cksum & 0xffff) + (cksum >> 16);
     }
     tcpHeader->check = ~cksum;
     // Verifying tcp checksum here fails with bad cksum
}

Any pointers/help in this regard will be highly appreciated...

Thanks,

-Vishwas.


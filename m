Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278587AbRKHVcJ>; Thu, 8 Nov 2001 16:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278579AbRKHVcB>; Thu, 8 Nov 2001 16:32:01 -0500
Received: from mail02.zonnet.nl ([62.58.50.112]:65456 "HELO mail02.zonnet.nl")
	by vger.kernel.org with SMTP id <S278591AbRKHVbs>;
	Thu, 8 Nov 2001 16:31:48 -0500
Message-ID: <002001c1689c$3e7dc020$3975a63e@berg>
Reply-To: "Gorny" <gorny0@zonnet.nl>
From: "Gorny" <gorny0@zonnet.nl>
To: <linux-kernel@vger.kernel.org>
Subject: little TCP checksum bug?
Date: Thu, 8 Nov 2001 22:25:38 +0100
Organization: -
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After playing with malicious TCP-packet I found out
that in certain cases the kernel will reply with a wrong
TCP-checksum set. This has only been tested against 2.2.19
and 2.4.5!

root@krondor:/home/gorny/btk# tcpdump -vXi lo >> dump
root@krondor:/home/gorny/btk# cat dump
18:56:29.316097 128.0.0.1.4000 > localhost.8012: S [tcp sum ok]
1732610923:1732610928(5) win 65535 (ttl 40, id 29204, len 45)
0x0000   4500 002d 7214 0000 2806 21b5 8000 0001        E..-r...(.!.....
0x0010   7f00 0001 0fa0 1f4c 6745 8b6b 0000 0000        .......LgE.k....
0x0020   5002 ffff 3466 0000 7768 6f6f 74               P...4f..whoot
18:56:29.316169 localhost.8012 > localhost.4000: R [bad tcp cksum 1!] 0:0(0)
ack 1732610924 win 0 (ttl 255, id 72, len 40)
0x0000   4500 0028 0048 0000 ff06 bd85 7f00 0001        E..(.H..........
0x0010   7f00 0001 1f4c 0fa0 0000 0000 6745 8b6c        .....L......gE.l
0x0020   5014 0000 8f30 0000                            P....0..
[...]

I don't think this will become a big problem, while most
people are running ipchains/iptables and/or some sort of
IDS's so those packets won't come through.
(Note that this has been tested on a standalone pc, while (of course)
128.0.0.1 didn't exist and no firewall)

If one want to test this behaviour you can download a little
c-file (4 kB) from here: http://gorny.ath.cx/archive/strange/strange.c

Gorny

"When I was a little kid, I had this dream where a snake would rule and
dominate the entire world (actually, I guess that a penguin was also part of
the dream... but never mind)" -- Python Develper's Handbook, Andre Lessa
http://gorny.ath.cx


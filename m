Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262949AbRE1Drr>; Sun, 27 May 2001 23:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262954AbRE1Drh>; Sun, 27 May 2001 23:47:37 -0400
Received: from f4.law3.hotmail.com ([209.185.241.4]:9484 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262949AbRE1Drc>;
	Sun, 27 May 2001 23:47:32 -0400
X-Originating-IP: [65.25.173.87]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Abysmal RECV network performance
Date: Mon, 28 May 2001 03:47:22 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F4YIkTQ81VSaoSJ0vYW0001c0ff@hotmail.com>
X-OriginalArrivalTime: 28 May 2001 03:47:22.0600 (UTC) FILETIME=[E6F68E80:01C0E728]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please help me troubleshoot this problem - I am getting abysmal 
(see numbers below) network performance on my system, but the poor 
performance seems limited to receiving data. Transmission is OK.

The computer in question is a dual Pentium 90 machine. The machine has 
RedHat 7.0 (kernel 2.2.16-22 from RedHat). I have compiled 2.2.19 (stock) 
and 2.4.3 (stock) for the machine and used those for testing. I had a 
NetGear FA310TX card that I used with the "tulip" driver and a 3Com 3CSOHO 
card (Hurricane chipset) that I used with the "3c59x" driver. I used the 
netperf package to test performance (latest version, but I don't have the 
version number off-hand). The numbers netperf is giving me seem to correlate 
well to FTP statistics I see to the box.

I have a second machine (P2-350) with a NetGear FA311 (running 2.4.3 and the 
"natsemi" driver) that I used to talk with the Pentium 90 machine. The two 
machines are connected through a NetGear FS105 10/100 switch. I also tried 
using a 10BT hub (see below).

When connected, the switch indicated 100 Mbps, full duplex connections to 
both cards. This matches the speed indicator lights on both cards. I have 
run the miidiag program in the past to verify that the cards are actually 
set to full duplex, but I didn't run it again this time (this isn't the 
first time I have tried to chase this problem down).

For the purposes of this message, call the P2-350 machine "A" and the dual 
P-90 machine "B". I ran the following tests:

Machine "A" to localhost	754.74	Mbps

Kernel 2.2.19SMP
Machine "B" to localhost	80.63	Mbps
Machine "B" to "A" (tulip)	55.38	Mbps
Machine "A" to "B" (tulip)	10.60	Mbps
Machine "A" to "B" (3c95x)	12.10	Mbps

Kernel 2.4.3 SMP
Machine "B" to localhost	83.87	Mbps
Machine "B" to "A" (tulip)	68.07	Mbps
Machine "A" to "B" (tulip)	1.62	Mbps
Machine "A" to "B" (3c95x)	2.37	Mbps

Kernel 2.2.16-22 (RedHat kernel)
Machine "B" to localhost	92.29	Mbps
Machine "B" to "A" (tulip)	57.34	Mbps
Machine "A" to "B" (tulip)	9.98	Mbps
Machine "A" to "B" (3c95x)	9.05	Mbps

Now, with both "A" and "B" plugged into a 10BT hub:

Kernel 2.2.19SMP
Machine "B" to "A" (tulip)	6.96	Mbps
Machine "A" to "B" (tulip)	6.89	Mbps

At the end of the runs, I do not see any messages in syslog that would 
indicate a problem. Using the switch, there were no collisions but looking 
at /sbin/ifconfig there were a lot of "Frame:" errors on receive. "A lot" 
means ~30% of the total packets received. This happened with both cards and 
all kernels.

The conclusions I draw from this data are:

1) Both machines connecting to localhost (data not going out over the wire) 
give reasonable numbers and are considerably above what I actually see going 
over the network (as would be expected).
2) The P-90 machine seems to have good transmit speed over both cards and 
all kernels. Transmit performance is close to the localhost numbers, so I 
can believe them. In the past, I have compared the performance of the FA310 
to the 3ComSOHO card and there did not seem to be any measurable performance 
difference between the two.
3) Both the FA310 and the 3ComSOHO card have similar receive speeds, leading 
me to believe that the problem lies with either the machine or the kernel 
and not the individual cards or drivers.
4) Booting the machine as a uni-processor machine (with a non-SMP 2.2.16 
kernel) did not change anything, so it does not appear to be a problem with 
SMP.
5) Kernel 2.4.3 receive performance is significantly lower than either 2.2.x 
kernel, so that tends to point to some fundamental problem in the kernel.
6) As I understand it, the 3Com card has some hardware acceleration for 
checksumming, and this is a slow machine, so why is the performance almost 
identical to the FA310?

So, my questions are:

What kind of performance should I be seeing with a P-90 on a 100Mbps 
connection? I was expecting something in the range of 40-70 Mbps - certainly 
not 1-2 Mbps.

What can I do to track this problem down? Has anyone else had problems like 
this?

Thanks in advance for any help you can offer.

- John

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com


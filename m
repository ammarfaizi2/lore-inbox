Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTBDVOt>; Tue, 4 Feb 2003 16:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTBDVOt>; Tue, 4 Feb 2003 16:14:49 -0500
Received: from smtp1.utdallas.edu ([129.110.10.12]:42971 "EHLO
	smtp1.utdallas.edu") by vger.kernel.org with ESMTP
	id <S267374AbTBDVOs>; Tue, 4 Feb 2003 16:14:48 -0500
Message-ID: <4280608.1044393822565.JavaMail.jelucas@utdallas.edu>
Date: Tue, 4 Feb 2003 15:23:42 -0600 (CST)
From: James E Lucas <jelucas@utdallas.edu>
To: linux-kernel@vger.kernel.org
Subject: natsemi.c: Oversized(?) ethernet frame message w/ card hang
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is my first post to the list, so please go easy on me ;)  I've 
been having problems off and on with the natsemi driver for a good 
number of kernel versions.  I've wrestled with the problem off and on, 
but I've finally decided that it's out of my league, so I'm going to 
ask people smarter than I.

The card works fine most of the time, but under heavy load (and even 
occasionally seemingly at random) the card simply locks up.  ifconfig 
eth0 down; ifconfig eth0 up brings it back into a working state, but 
this is understandably still a problem.  ifconfig output after a few 
errors and resets looks like this:

eth0      Link encap:Ethernet  HWaddr 00:02:E3:04:D5:0B
          inet addr:192.168.0.3  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:19883349 errors:1 dropped:778 overruns:3930 frame:4
          TX packets:288019 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:3507882433 (3345.3 Mb)  TX bytes:336382589 (320.7 Mb)
          Interrupt:11 Base address:0xd000

And, my kernel ring buffer (dmesg) is showing messages like this:

eth0: Oversized(?) Ethernet frame spanned multiple buffers, entry 
0x00ba8b status 0xe0000bd5.


kernel messagelog and syslog are both clear (no apparently related 
messages).  You may note the extremely high number of received packets 
on the ifconfig.  I wrote a program (for Windows) that hurls massive 
numbers of large UDP packets at the card to reproduce the breakage.  If 
anyone's interested in it I could post it up somewhere, though it's not 
very pretty ;)

A perusal of the source of natsemi.c along with the spec for the chip 
from National Semiconductor *seems* to indicate to me that this message 
results from a packet spanning multiple descriptors in the hardware.  
This *is* legal for the chip according to National's docs, but I can't 
find anything in the driver that seems to acknowledge this beyond the 
warning message.  My current working theory is that this doesn't happen 
very often, but when it does, the driver's not handling it properly.  
What I'm not so sure on is why that hangs the card.  Perhaps it's 
throwing the driver into an infinite loop or something.  Not really 
sure... I don't have the facilities needed to run debugging on kernel 
drivers.

At any rate, any input would be appreciated.  I've never coded hardware 
driver stuff before, so I may be misinterpreting things.

Additional info:
Kernel version: 2.4.19 (stock, no patches)
CPU: AMD K6-2 400
Motherboard: FIC (can't remember model number offhand)
Chipset is Via MVP3
128 megs of RAM

The card in question is a Netgear FA-311

Again, any help would be most appreciated.

Sincerely,
Jim Lucas

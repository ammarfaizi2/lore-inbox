Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbTCTOrM>; Thu, 20 Mar 2003 09:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbTCTOrM>; Thu, 20 Mar 2003 09:47:12 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:29904 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261490AbTCTOrL> convert rfc822-to-8bit; Thu, 20 Mar 2003 09:47:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Bottleneck on /dev/null
Date: Fri, 21 Mar 2003 01:57:10 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303210157.10494.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-2.4.latest
PACKET_MMAP
PCAP_FRAMES=max for tcpdump-3.8/libpcap-0.8 (from http://public.lanl.gov/cpw/)
e1000 driver

2 * Xeon 2800 MHz, 512 KB L2
1 GB RAM
70 GB HW RAID-0 on SmartArray 5i
2 * 2 port Intel GigE cards (only using 1 per card for the testing purposes)

Capturing all packets and writting to /dev/null causes more packet drops than 
writting to hard drives (approx 40,000 packets/sec of 70 bytes for couple of 
minutes). I will have a comparision between those figures in a day or two, 
but /dev/null was well over SCSI hard drives. I thought writting (even 
multiple of them simultaneously) to /dev/null should be faster than fastest 
SCSI drives out there :) Interesting.

(And yes I see plenty of "errors", "dropped", and "overruns" in ifconfig stats 
on those interfaces. %system is over 80%, and tcpdump goes to "D" state many 
times. Simon Kirby suggested to use irq-smp_affinity to see if that helps for 
reducing %system time. A well optimised e1000 would definitely help as tg3 
does it very well.)

I mean to test this /dev/null behavior on 2 tg3 driver configuration perhaps 
in couple of days time. (But the 2 tg3 cards with out-of-the-box NAPI support 
on 2.4.latest is able to not to loose a single packet even while writting to 
hard drives, then I didn't care to test it on /dev/null)

BTW I found 2.5.51 backport of e1000 NAPI support at  
http://havoc.gtf.org/lunz/linux/net/
Anyone knows of a recent backport or improved one for 2.4.latest (including 
2.4.21-pre5 or -pre6). Patches for testing or URL is welcome.

Thanks
-- 
Hari
harisri@bigpond.com



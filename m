Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbTAFLZp>; Mon, 6 Jan 2003 06:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbTAFLZp>; Mon, 6 Jan 2003 06:25:45 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:1540 "EHLO falcon.vispa.com")
	by vger.kernel.org with ESMTP id <S266584AbTAFLZn>;
	Mon, 6 Jan 2003 06:25:43 -0500
Message-ID: <3E19694D.8030306@walrond.org>
Date: Mon, 06 Jan 2003 11:32:29 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       grundler@cup.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <1041848998.666.4.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My (as yet unresolved) problem seems related to this stuff.
I've applied this patch on the off-chance it might fix my problems, to 
no avail. As you guys know about this stuff, perhaps you could glance 
over my problem description - attached. I be much obliged, as I can't 
use nptl *without* 2.5.x, and I can't use my e1000 *with* 2.5.x


2.5.53 and 2.5.54 do not seem to find everything on the pci bus on this 
asus pr-dls dual p4 xeon m/b

With 2.4.20+ I see

hal3 root # cat /proc/pci
PCI devices found:
...

   Bus  0, device   0, function  0:
     Host bridge: PCI device 1166:0012 (ServerWorks) (rev 19).
   Bus  0, device   0, function  1:
     Host bridge: PCI device 1166:0012 (ServerWorks) (rev 0).
   Bus  0, device   0, function  2:
     Host bridge: PCI device 1166:0000 (ServerWorks) (rev 0).
   Bus  0, device   2, function  0:
     Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 16).
       IRQ 18.
       Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
       Non-prefetchable 32 bit memory at 0xfd800000 [0xfd800fff].
       I/O at 0xd800 [0xd83f].
       Non-prefetchable 32 bit memory at 0xfd000000 [0xfd01ffff].
   Bus  0, device   3, function  0:
     VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
       IRQ 46.
       Master Capable.  Latency=32.  Min Gnt=8.
       Non-prefetchable 32 bit memory at 0xfc000000 [0xfcffffff].
       I/O at 0xd400 [0xd4ff].
       Non-prefetchable 32 bit memory at 0xfb800000 [0xfb800fff].
   Bus  0, device  15, function  0:
     ISA bridge: ServerWorks CSB5 South Bridge (rev 147).
       Master Capable.  Latency=32.
   Bus  0, device  15, function  3:
     Host bridge: ServerWorks GCLE Host Bridge (rev 0).
   Bus  0, device  16, function  0:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.
   Bus  0, device  16, function  2:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.
   Bus  0, device  17, function  0:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.
   Bus  0, device  17, function  2:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.
   Bus 14, device   4, function  0:
     SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 
53c1030 (rev 7).
       IRQ 22.
       Master Capable.  Latency=32.  Min Gnt=17.Max Lat=18.
       I/O at 0xa000 [0xa0ff].
       Non-prefetchable 64 bit memory at 0xfa000000 [0xfa00ffff].
       Non-prefetchable 64 bit memory at 0xf9800000 [0xf980ffff].
   Bus 14, device   4, function  1:
     SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 
53c1030 (#2) (rev 7).
       IRQ 23.
       Master Capable.  Latency=32.  Min Gnt=17.Max Lat=18.
       I/O at 0x9800 [0x98ff].
       Non-prefetchable 64 bit memory at 0xf9000000 [0xf900ffff].
       Non-prefetchable 64 bit memory at 0xf8800000 [0xf880ffff].
   Bus 18, device   2, function  0:
     Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet 
Controller (rev 2).
       IRQ 19.
       Master Capable.  Latency=32.  Min Gnt=255.
       Non-prefetchable 64 bit memory at 0xf8000000 [0xf801ffff].
       Non-prefetchable 64 bit memory at 0xf7800000 [0xf781ffff].
       I/O at 0x9400 [0x941f].


But with 2.5.53/2.5.54 bus 14 and bus 18 are missing:

hal3 root # cat /proc/pci
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: PCI device 1166:0012 (ServerWorks) (rev 19).
   Bus  0, device   0, function  1:
     Host bridge: PCI device 1166:0012 (ServerWorks) (rev 0).
   Bus  0, device   0, function  2:
     Host bridge: PCI device 1166:0000 (ServerWorks) (rev 0).
   Bus  0, device   2, function  0:
     Ethernet controller: Intel Corp. 82557/8/9 [Ethernet  (rev 16).
       IRQ 18.
       Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
       Non-prefetchable 32 bit memory at 0xfd800000 [0xfd800fff].
       I/O at 0xd800 [0xd83f].
       Non-prefetchable 32 bit memory at 0xfd000000 [0xfd01ffff].
   Bus  0, device   3, function  0:
     VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
       IRQ 46.
       Master Capable.  Latency=32.  Min Gnt=8.
       Non-prefetchable 32 bit memory at 0xfc000000 [0xfcffffff].
       I/O at 0xd400 [0xd4ff].
       Non-prefetchable 32 bit memory at 0xfb800000 [0xfb800fff].
   Bus  0, device  15, function  0:
     ISA bridge: ServerWorks CSB5 South Bridge (rev 147).
       Master Capable.  Latency=32.
   Bus  0, device  15, function  3:
     Host bridge: PCI device 1166:0225 (ServerWorks) (rev 0).
   Bus  0, device  16, function  0:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.
   Bus  0, device  16, function  2:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.
   Bus  0, device  17, function  0:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.
   Bus  0, device  17, function  2:
     Host bridge: PCI device 1166:0101 (ServerWorks) (rev 3).
       Master Capable.  Latency=64.


ACPI is enabled in both cases (Won't boot with pci=noacpi)


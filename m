Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262769AbTC0Bea>; Wed, 26 Mar 2003 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262767AbTC0Bea>; Wed, 26 Mar 2003 20:34:30 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:45036 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S262771AbTC0Be1>; Wed, 26 Mar 2003 20:34:27 -0500
Message-ID: <3E825942.8070706@seme.com.au>
Date: Thu, 27 Mar 2003 09:52:02 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE problem in 2.4.21-pre1 --> pre6
References: <3E8252A2.3080501@seme.com.au>
In-Reply-To: <3E8252A2.3080501@seme.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> G'day all,
> 
> Just upgraded a system I am developing from 2.4.20 to 2.4.21-preX and 
> noticed this 20 second hang with ide on bootup.
> 
Problem still exists in -pre6 (released about an hour before my previous 
E-mail)
I also tried ide0=reset to reset the ide bus in case the 2.4.19 kernel 
had left it in some strange state.
Tried with the VIA driver compiled in also.. No joy..

Included hdparm -i /dev/hda ; hdparm -I /dev/hda and /proc/pci below.

/home/service # hdparm -i /dev/hda

/dev/hda:

  Model=APACER_CF_32MB, FwRev=verB.65, SerialNo=02-86912507
  Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }
  RawCHS=123/16/32, TrkSize=16384, SectSize=512, ECCbytes=4
  BuffType=DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=off
  CurCHS=123/16/32, CurSects=62976, LBA=yes, LBAsects=62976
  IORDY=no
  PIO modes:  pio0 pio1 pio2
  AdvancedPM=no

/home/service # hdparm -I /dev/hda

/dev/hda:

CompactFlash ATA device, with removable media
         Model Number:       APACER_CF_32MB
         Serial Number:      02-86912507
         Firmware Revision:  verB.65
Standards:
         Likely used: 4
Configuration:
         Logical         max     current
         cylinders       123     123
         heads           16      16
         sectors/track   32      32
         --
         bytes/track: 16384      bytes/sector: 512
         CHS current addressable sectors:      62976
         LBA    user addressable sectors:      62976
         device size with M = 1024*1024:          30 MBytes
         device size with M = 1000*1000:          32 MBytes
Capabilities:
         LBA, IORDY(may be)(cannot be disabled)
         Buffer size: 1.0kB      bytes avail on r/w long: 4      Queue 
depth: 1
         Standby timer values: spec'd by Vendor
         R/W multiple sector transfer: Max = 1   Current = 0
         DMA: not supported
         PIO: pio0 pio1 pio2

/home/service # cat /proc/pci

PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 5).
       Master Capable.  Latency=8.
       Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP] 
(rev 0).
       Master Capable.  No bursts.  Min Gnt=12.
   Bus  0, device  17, function  0:
     ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 16).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 6).
       Master Capable.  Latency=32.
       I/O at 0xd000 [0xd00f].
   Bus  0, device  17, function  2:
     USB Controller: VIA Technologies, Inc. USB (rev 30).
       IRQ 3.
       Master Capable.  Latency=32.
       I/O at 0xd400 [0xd41f].
   Bus  0, device  17, function  3:
     USB Controller: VIA Technologies, Inc. USB (#2) (rev 30).
       IRQ 3.
       Master Capable.  Latency=32.
       I/O at 0xd800 [0xd81f].
   Bus  0, device  17, function  4:
     Bridge: VIA Technologies, Inc. VT8235 ACPI (rev 16).
   Bus  0, device  17, function  5:
     Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 64).
       IRQ 10.
       I/O at 0xdc00 [0xdcff].
       I/O at 0xe000 [0xe003].
       I/O at 0xe400 [0xe403].
   Bus  0, device  18, function  0:
     Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 81).
       IRQ 11.
       Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
       I/O at 0xe800 [0xe8ff].
       Non-prefetchable 32 bit memory at 0xe3000000 [0xe30000ff].
   Bus  0, device  20, function  0:
     Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 
UART) (rev 1).
       IRQ 5.
       I/O at 0xec00 [0xec1f].
   Bus  1, device   0, function  0:
     VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 
106).
       IRQ 11.
       Master Capable.  Latency=32.
       Non-prefetchable 32 bit memory at 0xe1800000 [0xe1ffffff].
       Non-prefetchable 32 bit memory at 0xe2000000 [0xe201ffff].
       Non-prefetchable 32 bit memory at 0xe1000000 [0xe17fffff].


-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292284AbSBOXt0>; Fri, 15 Feb 2002 18:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292286AbSBOXtR>; Fri, 15 Feb 2002 18:49:17 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:2688 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S292284AbSBOXtB>; Fri, 15 Feb 2002 18:49:01 -0500
Date: Fri, 15 Feb 2002 23:48:41 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Ville Herva <vherva@viasys.com>
cc: vojtech@suse.cz, <linux-kernel@vger.kernel.org>, <jfr@viasys.com>
Subject: Re: Quick question on Software RAID support.
In-Reply-To: <20020214001242.A14015@viasys.com>
Message-ID: <Pine.LNX.4.44.0202152325020.11081-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Ville Herva wrote:

> I run it on /dev/md0 (which consists of one hd on each HPT370 channel).  
> You can also do it for /dev/hd{e,g} in parallel - the effects are pretty
> much the same. To make it trigger easier, try "ping -f -s 64000" on
> background and stress scsi system if you have one. I think any pci load
> affects it, but I found 3c905b network load by far the easiest way to
> trigger the bug (I even got OOPSes if 3c905b was in certain slot while
> doing that.)

Hi Ville,

I've just been trying this here, with the following setup, and it's 
(so far) been reliable.... Just doing a 3rd pass..

hdc: seagate 80G, 1Gb partition (r5 parity)
hde: seagate 40G, 1Gb partition (r5 data)
hdg: seagate 40G, 1Gv partition (r5 data)

AGP currently disabled (NvAgp=0 in the Xserver config).

Running: ./w /dev/md2 2000 8 50
         mplayer divx playback
         gears (for accel gl stressing)
         ping -f s 64000
         xawtv running for more traffic
         xmms playing back mp3s

System's running pretty decently still (it's on pass 5 of the
partition blasting).  Note however, that I currently have all the disk
interfaces reset to only udma 3 as part of the startup scripts.  I'll
pull out the exact pci-tweaking bios settings when I next restart.

As and when I get confidence in the system (and a bigger case fan) at
the current settings, I'll push up the transfer rates - though with
just a single disk on each chain, there's not that much to be gained
by it (though udma 3 is supposedly just shy of the maximum xfer rate 
the barracuda IV's can produce).

At least a large portion of my trouble appears to have gone since I
stopped using md2(raid5) for a swap partition and I'd just setup 3
independant swap areas instead.  While doing this stress testing, I
currently have no swapfile setup at all.  Kernel's 2.4.18pre9-ac4 
now, and the via tweaking in there might be a factor too.

Hardware in machine/irq setup:

# cat /proc/interrupts 
           CPU0       
  0:    5995487          XT-PIC  timer
  1:     100561          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:    8509758          XT-PIC  rtc
  9:    1475133          XT-PIC  usb-uhci, usb-uhci, eth0, eth1
 10:    5322285          XT-PIC  bttv, nvidia
 11:    1117995          XT-PIC  ide2, ide3
 12:     793060          XT-PIC  Trident Audio
 14:       1407          XT-PIC  ide0
 15:     577645          XT-PIC  ide1

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:0f.0 Multimedia audio controller: Trident Microsystems 4DWave DX (rev 02)
00:11.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
00:13.0 Unknown mass storage controller: HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Controller (rev 04)
01:00.0 VGA compatible controller: nVidia Corporation NV11 DDR (rev b2)


Cheers,

Mark

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+


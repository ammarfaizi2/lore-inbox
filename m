Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbVBFIPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbVBFIPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 03:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267016AbVBFIPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 03:15:06 -0500
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:21937 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S266149AbVBFIOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 03:14:42 -0500
From: Kimmo Sundqvist <kimmo.sundqvist@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: Disabled shared IRQs with eth0 and uhci-hcd
Date: Sun, 6 Feb 2005 10:14:33 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502061014.33703.kimmo.sundqvist@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

(I'd like to have all replies CC'ed to me)

This is a dual Pentium 3 box with an Abit VP6 motherboard.

The USB controller has a LaCie CD-RW drive connected to it, and nothing else.  
eth0 is working at 100Mbps, connected to a switch.

I tried moving a 500MB file from the HD of this machine to a smbfs share on 
another machine.  At the same time I tried copying the contents of a CD in 
the USB CD-RW to the HD of this machine.

While I was doing it, IRQ11 for CPU0 increased by about 5000 per second, and 
so did IRQ19 for CPU1.

As soon as the copy to the smbfs share was finished, the IRQ19 stopped 
increasing, and IRQ11 (since the copy from USB CD-RW to HD was still going 
on) increased by 50 or maybe 100 per second. 

I stopped the CD to HD copy, and restarted the network copy.  Soon the kernel 
disabled IRQ11, and IRQ19 was evenly distributed for both CPUs.

The network keeps functioning after that, but the USB is lost.  I don't know 
if there is any way to get it back, short of rebooting.  A couple of times 
the kernel has disabled IRQ19 soon (maybe 1 to 2 minutes) after disabling 
IRQ11.

uname -a is:

Linux miau 2.6.10-gentoo-r2 #1 SMP Thu Jan 6 18:37:45 EET 2005 i686 Pentium 
III (Coppermine) GenuineIntel GNU/Linux

I can try this out with vanilla 2.6.10 if necessary.  My guess is that the IRQ 
sharing between USB and eth0 is not working, but is the problem with some 
kernel setting or with hardware?  The thing works at full throttle for many 
minutes until the problem appears.

I guess/hope I could solve this by moving the ethernet controller to a PCI 
slot that doesn't share an IRQ with anything, but decided to report this just 
in case the problem could/should be handled/solved by the kernel.

           CPU0       CPU1       
  0:    2219593       4298    IO-APIC-edge  timer
  1:       2898          3    IO-APIC-edge  i8042
  4:          0          0    IO-APIC-edge  serial
  7:          0          0    IO-APIC-edge  parport0
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 11:    1099999          1   IO-APIC-level  uhci_hcd, uhci_hcd
 12:      12058         60    IO-APIC-edge  i8042
 14:      12364          9    IO-APIC-edge  ide0
 15:          1         19    IO-APIC-edge  ide1
 16:      20135          0   IO-APIC-level  mga@pci:0000:01:00.0
 17:      21595          1   IO-APIC-level  Ensoniq AudioPCI
 19:     316160    1467875   IO-APIC-level  eth0
NMI:          0          0 
LOC:    2223818    2223756 
ERR:          0
MIS:          0

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 
196).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xc0000000 [0xcfffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] 
(rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C 
PIPC Bus Master IDE (rev 6).
      Master Capable.  Latency=16.  
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(rev 22).
      IRQ 11.
      Master Capable.  Latency=16.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(#2) (rev 22).
      IRQ 11.
      Master Capable.  Latency=16.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 9.
  Bus  0, device  11, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 17.
      Master Capable.  Latency=16.  Min Gnt=12.Max Lat=128.
      I/O at 0xdc00 [0xdc3f].
  Bus  0, device  12, function  0:
    Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S 100/10M 
Ethernet PCI Adapter (rev 0).
      IRQ 19.
      Master Capable.  Latency=16.  Min Gnt=32.Max Lat=64.
      I/O at 0xe000 [0xe0ff].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd60003ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 4).
      IRQ 16.
      Master Capable.  Latency=16.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd0000000 [0xd1ffffff].
      Non-prefetchable 32 bit memory at 0xd2000000 [0xd2003fff].
      Non-prefetchable 32 bit memory at 0xd3000000 [0xd37fffff].

-Kimmo S.

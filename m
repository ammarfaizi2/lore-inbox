Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTJHRVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 13:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbTJHRVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 13:21:42 -0400
Received: from postman2.arcor-online.net ([151.189.0.188]:54676 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261344AbTJHRVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 13:21:35 -0400
From: Christian.Fertig@gmx.de (Christian Fertig)
Subject: Problem: 2.4.22[-ac4] Hangup with SB AWE32 (isa-pnp)
Organization: FuF
User-Agent: tin/1.5.16-20030125 ("Bubbles") (UNIX) (Linux/2.4.21 (i686))
Message-ID: <rqld51-js9.ln1@fertig-50273.user.cis.dfn.de>
Date: Wed, 08 Oct 2003 15:07:41 -0000
Apparently-To: <fertig@fufnet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)

Hi,

I've got a reproducable kernel hangup (no oops, no sysrq-key etc.
anymore) with 2.4.22 and 2.4.22-ac4 on my NMC-7vax (Athlon, [Slot]).
The sb-Modules uses a wrong Interrupt (7 instead of 5). The problem
doesn't arise with earlier versions of the kernel. I'm using the kernel
oss module.

Hardware before 'modprobe sb'

metropolis:/ # cat /proc/interrupts 
           CPU0       
  0:      29838          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          2          XT-PIC  serial
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       7806          XT-PIC  usb-uhci, eth0
 14:      10907          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0 
LOC:      29799 
ERR:        107
MIS:          0

metropolis:/ # lspci 
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 21)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:09.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

metropolis:/ # lsmod
Module                  Size  Used by    Not tainted
nfsd                   72848   8  (autoclean)
autofs                 10996   2  (autoclean)
usb-uhci               23280   0  (unused)
usbcore                63148   0  [usb-uhci]
ide-scsi               10544   0 
parport_pc             27624   0  (autoclean) (unused)
lp                      6752   0  (autoclean)
parport                25992   0  (autoclean) [parport_pc lp]
binfmt_misc             5960   1  (autoclean)
nls_iso8859-15          3388   1  (autoclean)
nls_cp850               3612   1  (autoclean)
i2c-matroxfb            2612   0  (unused)
i2c-algo-bit            7464   3  [i2c-matroxfb]
i2c-core               13508   0  [i2c-algo-bit]
matroxfb_proc           1784   0  (unused)
mga                    95100   0  (unused)
e100                   48232   1 

metropolis:/ # modprobe isa-pnp
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: 1 Plug & Play card detected total


metropolis:/proc # cat isapnp 
Card 1 'CTL0044:Creative SB32 PnP' PnP version 1.0 Product version 1.0
  Logical device 0 'CTL0031:Audio'
    Device is not active
    Resources 0
      Priority preferred
      Port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
      Port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
      Port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
      IRQ 5 High-Edge
      DMA 1 8-bit byte-count compatible
      DMA 5 16-bit word-count compatible
      Alternate resources 0:1
      [..]
      [allways suggests IRQ 5,7,10 High-Edge]
      [..]

The above settings are right (irq 5, low dma 1, high dma 5, port 0x220 etc.). 

If I now type 'modprobe sb', or even 'insmod sb irq=5', the machine dies.

Soundblaster audio driver CR (c) Hannu Savolainen
sb: Creative SB32 PnP detected
sb: ISAPnP reports 'Creative SB32 PnP' at i/o 0x220, irq 7, dma 1, 5
SB 4.13 detected OK (220).

I've even tried the "old method" with /etc/isapnp.conf, no chance.

I think this is a bug in >2.4.22 isa-pnp-Management. Any suggestions?

Christian

-- 
The feature you'd like to have is probably already installed on your
Linux system.

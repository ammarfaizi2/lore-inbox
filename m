Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281568AbRLEVwG>; Wed, 5 Dec 2001 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284451AbRLEVv5>; Wed, 5 Dec 2001 16:51:57 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:28934 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281568AbRLEVvs>; Wed, 5 Dec 2001 16:51:48 -0500
Date: Wed, 5 Dec 2001 21:14:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: mj@ucw.cz
Subject: pci=biosirq... Is the machien having fun with me?
Message-ID: <20011205211410.A117@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On hp omnibook xe3, Sound is working poorly. Its maestro3 *plays*, but
repeats portions.... No wonder.... It probably did not receive correct
irq (while playing music!):

root@amd:~# cat /proc/interrupts
           CPU0
  0:      14014          XT-PIC  timer
  1:       1134          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  Allegro
  9:          1          XT-PIC  acpi
 10:        111          XT-PIC  pcnet_cs
 11:          8          XT-PIC  Texas Instruments PCI1420, Texas Instruments PCI1420 (#2)
 12:        420          XT-PIC  PS/2 Mouse
 14:      28392          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0
ERR:          0
root@amd:~#

So I did as adviced, appended pci=biosirq to commandline:

Kernel command line: auto BOOT_IMAGE=pavel ro root=304
BOOT_FILE=/boot/bvmlinuz enableapic vga=0x0317 hdc=ide-scsi pci=biosirq
ide_setup: hdc=ide-scsi
...
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 5 for device 00:08.0
PCI: Sharing IRQ 5 with 00:08.1
Initializing RT netlink socket
DMI 2.2 present.
...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
									  ~~~~~~~~~~~
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device:  DMA disabled
...
Uniform CD-ROM driver Revision: 3.12
maestro3: version 1.22 built at 21:18:22 Nov 29 2001
PCI: Found IRQ 5 for device 00:08.0
PCI: Sharing IRQ 5 with 00:08.1
maestro3: Configuring ESS Allegro found at IO 0x1400 IRQ 5
maestro3:  subvendor id: 0x0018103c
ac97_codec: AC97 Audio codec, id: 0x4583:0x8308 (ESS Allegro ES1988)
Creative EMU10K1 PCI Audio Driver, version 0.16, 21:18:05 Nov 29 2001
Linux Kernel Card Services 3.1.22


I did specify pci=biosirq, and it *still* suggests me using
pci=biosirq. Smells like bug. Linux-2.4.14. 

								Pavel


-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky

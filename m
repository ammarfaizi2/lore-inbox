Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUH1PEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUH1PEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUH1PEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:04:24 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:25334 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S266786AbUH1PEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:04:14 -0400
From: Al <wizard@slacky.it>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Logitech optical usb mouse and vfat partition passing from 2.6.7 to 2.6.8.1 kernel
Date: Sat, 28 Aug 2004 17:04:26 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408281704.27031.wizard@slacky.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi at all,

as first i want to thank you for your precious job.
I'm sorry for my bad english and i hope don't make you lose your time. I'm 
sending you this mail not to have an anwser as i don't need the newer kernel 
(i work with the previous anyway), but only hopping to give you  some 
"advise" on the possible bugs of the newer kernel.
So i'm passing to explain my problems.

I'm using a Slackware 9.1 with gcc 3.2.3 on a MITAC's laptop.
I tried to compile the newer kernel 2.6.8.1 in this way:
I copied the ".config" file from kernel2.6.7 to the newer 2.6.8.1, and then i 
controlled if alway was right with "make menuconfig".
At the end i compiled the kernel and i saw that my mouse and vfat "dosn't 
work" (a bad sentense...i know).

I controlled then the difference between the ".config" files of the two kernel 
versions but they are nearly equal.
To be more precise the following are my .config files and my dmesg messagges 
(only the part i thought would interesting)

First: Mouse: i have a Logitech optical usb mouse. 

the following are the .config file of kernel 2.6.7 followed from the dmesg:

[...]
#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=y
[...]

#Logitech optical usb mouse
usb 2-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:02.3-1
usb 2-2: new full speed USB device using address 3

#Touchpad //but it function on both kernel version. I insert this information 
#because it could probably help you.
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.1
 180 degree mounted touchpad
 Sensor: 15
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1


And this is the .config file of kernel 2.6.8.1 followed from the dmesg: 

[...]
#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=y
[...]

#Logitech optical usb mouse
there are't messagges for logitech mouse!

#Touchpad //but it function on both kernel version.
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.1
 180 degree mounted touchpad
 Sensor: 15
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1


Second: i cannot mount my vfat partition.

This is my dmesg log:

[...]
Unable to load NLS charset cp437
FAT: codepage cp437 not found
[...]

this is the error message when i try to mount the partition with my hands:


mount: wrong fs type, bad option, bad superblock on /dev/hda7,
       or too many mounted file systems

the command that i used was: mount -t vfat /dev/hda7 /win

but in this case the config file is a bit different.
kernel 2.6.7:

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y


kernel 2.6.8.1:

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

and the different fields cannot be canged manually....(i mean with menuconfig)

And finally a good news!
With the newer kernel i can use my sis video card...even if theese are my last 
messages of dmesg:

sisfb: Deprecated ioctl call received - update your application!
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
trying access hardware directly.

the following are the lspci -v messages for the video card:

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Mitac: Unknown device 8575
        Flags: 66Mhz, medium devsel, IRQ 5
        BIST result: 00
        Memory at 90000000 (32-bit, prefetchable) [size=128M]
        Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at c000 [size=128]
        Capabilities: [40] Power Management version 1
        Capabilities: [50] AGP version 2.0


this is my dmessages for kernel 2.6.7 (where my sis video card was not 
detected. With this kernel i'm using the generic VESA card instead of sis 
card, because with the sis video card, when i boot the machine i cannot see 
anything. I put this messages too because probably can help you.)

vesafb: framebuffer at 0x90000000, mapped to 0xce809000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at cb6b:0004
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device

and this is my dmessages for kernel 2.6.8.1 

sisfb: Using vga mode 1024x768x16 pre-set by kernel as default
sisfb: Video ROM found and mapped to 0xc00c0000
sisfb: Framebuffer at 0x90000000, mapped to 0xce809000, size 32768k
sisfb: MMIO at 0xe0000000, mapped to 0xd080a000, size 128k
sisfb: Memory heap starting at 32160K, size 32K
sisfb: Detected SiS301LV video bridge
sisfb: Detected secondary VGA connection
sisfb: Detected 1024x768 flat panel
sisfb: Detected LCD PDC 0x02 (for LCD=CRT2)
sisfb: Detected LCD PDC1 0x04 (for LCD=CRT1)
sisfb: Default mode is 1024x768x16 (60Hz)
sisfb: Initial vbflags 0x400002a
sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
fb0: SiS 650 frame buffer device, Version 1.7.12


I hope to do not post at the wrong address or wrote wrong things. 
I post this mail because i'm suspicious because the nearly equal .config file 
has produced a kernel so..."unstable".
I want to remember you that your work is really important for more 
people...both just students like me, or theachers, firms....and so on.
Thanks for all.

Alberto

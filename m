Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUJDT0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUJDT0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUJDTZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:25:07 -0400
Received: from smtp30.hccnet.nl ([62.251.0.40]:61329 "EHLO smtp30.hccnet.nl")
	by vger.kernel.org with ESMTP id S268446AbUJDTVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:21:38 -0400
Message-ID: <4161A2C1.8000901@hccnet.nl>
Date: Mon, 04 Oct 2004 21:21:37 +0200
From: Ronald Moesbergen <r.moesbergen@hccnet.nl>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041003)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 2.6.9-rc3, i8042.c: Can't read CTR while initializing i8042
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.6.9-rc3 (I tested rc3-bk3 also) on 3 out of 10 boots my PS/2 
keyboard is dead and 'i8042.c: Can't read CTR while initializing i8042' 
shows up in my logfile. Google found this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109463125415432&w=2

which suggests to add i8042.noacpi=1 to my boot parameters, but 
unfortunately that doesn't help, the kernel doesn't even recognize this 
option. Reverting back to 2.6.9-rc2 fixes it. The machine is a P4 3Ghz 
HT, E7205 chipset, ASUS P4P8X board.

lspci output:
0000:00:00.0 Host bridge: Intel Corp. E7205 Memory Controller Hub (rev 03)
0000:00:00.1 Class ff00: Intel Corp. E7505/E7205 Series RAS Controller 
(rev 03)
0000:00:01.0 PCI bridge: Intel Corp. E7505/E7205 PCI-to-AGP Bridge (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 
EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC 
Interface Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) IDE Controller 
(rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
SMBus Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV38 [GeForce 
FX 5950 Ultra] (rev a1)
0000:02:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
0000:02:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
0000:02:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game 
port (rev 03)
0000:02:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port

Relevant (i hope) config options:

CONFIG_X86=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_SMP=y
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_REGPARM=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_RTC=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

Any help on resolving this issue is greatly appreciated. Please let me 
know if any more information and/or testing is needed. Please CC me, i'm 
not on the list.

Thanks,
Ronald.





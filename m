Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272452AbRH3UzP>; Thu, 30 Aug 2001 16:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272451AbRH3Uyk>; Thu, 30 Aug 2001 16:54:40 -0400
Received: from mout0.freenet.de ([194.97.50.131]:62938 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S272450AbRH3UyD>;
	Thu, 30 Aug 2001 16:54:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Messages "ACPI attempting to access kernel owned memory"?
Date: Thu, 30 Aug 2001 22:54:29 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01083022542904.00841@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

since a few releases of 2.4.x-ac? I get the following error message before 
ACPI is initialized:

	ACPI attempting to access kernel owned memory at 040FDC09.
	ACPI attempting to access kernel owned memory at 040FDC09.
	ACPI attempting to access kernel owned memory at 040FF78C.
	ACPI attempting to access kernel owned memory at 040FF78C.
	ACPI attempting to access kernel owned memory at 040FFBC0.
	ACPI attempting to access kernel owned memory at 040FDC31.
	ACPI attempting to access kernel owned memory at 040FDC31.
	ACPI: Core Subsystem version [20010615]
	ACPI: Subsystem enabled
	ACPI: System firmware supports S0 S1 S5
	Processor[0]: C0 C1 C2
	Power Button: found

My mainboard is an Intel AL440LX with (440LX Chipset), a bit old, but ACPI 
works (at least, it cleanly shutd down my computer when I push the power 
button, which seems the only thing it really does, so far).

Apart from this messages showing up at boot time, everything works normal.

What puzzles me is that the memory adresses should not be owned by the 
kernel, the ranges are reserved for ACPI in the BIOS-e820 printout:

	Linux version 2.4.9-ac3 (root@dg1kfa) (gcc version 2.95.2 19991024
		(release)) #1 Wed Aug 29 23:09:32 CEST 2001
	BIOS-provided physical RAM map:
	 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
	 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
	 BIOS-e820: 00000000000e7400 - 0000000000100000 (reserved)
	 BIOS-e820: 0000000000100000 - 00000000040fdc00 (usable)
	 BIOS-e820: 00000000040fdc00 - 00000000040ff800 (ACPI data)
	 BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)
	 BIOS-e820: 00000000040ffc00 - 0000000020000000 (usable)
	 BIOS-e820: 00000000fffe7400 - 0000000100000000 (reserved)
	On node 0 totalpages: 131072
	zone(0): 4096 pages.
	zone(1): 126976 pages.
	zone(2): 0 pages.
	Local APIC disabled by BIOS -- reenabling.
	Found and enabled local APIC!
	Kernel command line: root=/dev/hdc2 apm=off video=matrox:vesa:280,fv:76
		hdb=ide-scsi mem=524288K

In the .config, I have enabled the following options for kernel debugging (to 
help you all to fix my problems :-):

	#
	# Kernel hacking
	#
	CONFIG_DEBUG_KERNEL=y
	CONFIG_DEBUG_SLAB=y
	CONFIG_DEBUG_IOVIRT=y
	CONFIG_MAGIC_SYSRQ=y
	CONFIG_DEBUG_SPINLOCK=y
	CONFIG_DEBUG_BUGVERBOSE=y

The PM/ACPI configuration looks as following:

	CONFIG_PM=y
	CONFIG_ACPI=y
	CONFIG_ACPI_DEBUG=y
	CONFIG_ACPI_BUSMGR=y
	CONFIG_ACPI_SYS=y
	CONFIG_ACPI_CPU=y
	CONFIG_ACPI_BUTTON=y
	CONFIG_ACPI_AC=y
	CONFIG_ACPI_EC=y
	CONFIG_ACPI_CMBATT=y
	CONFIG_ACPI_THERMAL=y
	# CONFIG_APM is not set

I hope this report was useful, I'm willing to test any suggestions or patches 
here.

Greetings,
Andreas

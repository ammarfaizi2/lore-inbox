Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163193AbWLGS5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163193AbWLGS5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163195AbWLGS5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:57:45 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:49819 "EHLO
	laptopd505.fenrus.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163193AbWLGS5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:57:45 -0500
Subject: Announce: New release of the Linux-ready Firmware Developer Kit
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Dec 2006 19:57:37 +0100
Message-Id: <1165517857.27217.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux-ready Firmware Developer Kit team is pleased to announce the
release R1 of the kit. In this release many bugs have been fixed and several
key enhancements have been done to help the ease of use of the kit, and
several new tests have been added.

The Linux-ready Firmware Developer Kit is a tool to test how well Linux
works together with the firmware (BIOS or EFI) of your machine, and is
designed for use by both firmware development teams and Linux kernel
hackers to prevent and diagnose firmware bugs.

Summary
=======

Enhancements
* Inclusion of the Linux 2.6.19 kernel for the latest hardware support
* Include several Linux distribution kernels for testing
* Many bugfixes
* The Serial-console mode now detects speed automatically
* Prototype IA64 support
* Automatic mode

New Tests
=========
* Suspend-Resume 
* basic HPET test
* P-state coordination
* Thermal Trip Points
* 32/64 FADT test
* SSDT AML test
* Microcode version test
* DMI table test
* VMX enabled test
* OS/2 gap test
* APIC edge/level test
* PCI Express maxreadreq test
* _SUN test


You can download this latest release of the kit from

    http://www.linuxfirmwarekit.org


The Linux-ready Firmware Developer Kit team
	Jacob Pan
	Rolla Selbak
	Arjan van de Ven





Changes in R1 of the Linux-ready Firmware Developer Kit
-------------------------------------------------------

Features
--------
Linux distribution kernels
	Several people have asked us to make it easy to also test vendor
	kernels with the BIOS, and not just the vanilla kernel.org kernel.
	The standard ISO image contains 3 such kernels now, and the build
	system allows adding your own very easily.

General improvements
--------------------
Infrastructure
	The mini-OS on the CD has been upgraded to the Fedora Core 6 rpms.
	This allows us to leverage the suspend/resume infrastructure in FC6.
Kernel
	The kernel on the CD image has been updated to version 2.6.19
Serial console
	Thomas Renninger from Novell/SuSE contributed code that detects the
	selected serial console speed automatically, rather than using a
	fixed speed as R0 did.
Prototype IA64 support
	The firmware kit runs on IA64 now; however no ISO image is available
	yet.
Automatic mode
	The firmware kit can now run in "auto pilot" mode, where the entire
	kit is non-interactive and just saves the results before exiting.
Build system
	The build process has been changed to link against the libraries
	that will be on the final CD image, rather than the ones on the
	system. This should make the build process a lot more portable
	than it was in R0.

New tests
---------
Suspend-Resume 
	This manual test allows you to test if Suspend (to ram), and 
	more importantly, Resume works on the machine

basic HPET test
	This test verifies if the kernel detects the HPET component of
	the chipset properly. Firmware writers are strongly encouraged
	to default-enable HPET to allow Linux to do fast and accurate
	timekeeping.

P-state coordination
	Current dual core processors have a behavior that the effective
	frequency of both cores in a package is the maximum of the set
	frequencies of the cores. This is called "Hardware coordination".
	However some firmware does not get this right and uses "software
	coordination" where both cores run at the speed that was programmed
	into either of the cores. 

Thermal Trip Points
	Frank Seidel from Novell/SuSE has contributed a test for the thermal
	trip points in a system.

32/64 FADT test
	The FADT ACPI table is sometimes available in a 32 bit and a 64 bit
	version. This test verifies that the common fields in these tables 
	are identical; they need to be since they describe the same properties.

SSDT AML test
	In addition to the DSDT, some firmware has SSDT tables which are
	supplemental AML tables to the DSDT. The firmware kit now performs
	the same checks on the SSDT tables as it does on the DSDT.

Microcode version test
	Intel CPUs have a feature called "microcode update", which makes it
	possible to field update some non-performance critical behaviors of
	the processor. The firmware is responsible to load a recent enough
	version of this microcode into the processor; this test checks if
	a more recent version exists.

DMI table test
	The DMI table is used by Linux in several places, for example for
	model specific workarounds. This test checks the DMI table against
	a set of common mistakes, such as out-of-range values and reference
	values that are copied but not adjusted from a reference
	implementation.

VMX enabled test
	Some firmware disables the VMX Virtualization extensions entirely;
	this is unfortunate since Xen and KVM cannot use these extensions on
	the machine. This test checks for this.

OS/2 gap test
	For old versions of the OS/2* operating system, the firmware needed 
	to leave a gap in memory between 15Mb and 16Mb. However this gap
	breaks various bootloaders that are used by Linux distributions,
	and should never be enabled by default.

APIC edge/level test
	When using apics, the legacy interrupts on a system should be 
	edge-triggered, while non-legacy interrupts should be level-triggered.
	If this is not done correctly, interrupts get either lost or cause
	an interrupt storm, both can hang the Linux kernel.

PCI Express maxreadreq test
	PCI Express cards have a tunable buffer size with a default size of
	128. The firmware is responsible for programming this buffer size to
	a higher value during POST for optimal performance. This test
	verifies that all PCI Express cards in a system have a higher tuned
	setting. This test was suggested by Roland Dreier from Cisco after
	a major Infiniband performance issue was diagnosed to be a non-tuned 
	maxreadreq.

_SUN test
	PCI slots may have numbers (this is needed to tell the user "the
	card in slot 4 can now be hot-unplugged safely). Some firmware
	has assigned duplicate numbers to some slots, and this prevents
	PCI/PCI-E hotplug from working reliably.




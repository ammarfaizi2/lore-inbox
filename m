Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUJSIzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUJSIzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268083AbUJSIzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:55:22 -0400
Received: from cobra.mcnabbs.org ([64.62.190.91]:45326 "EHLO mcnabbs.org")
	by vger.kernel.org with ESMTP id S268074AbUJSIyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:54:45 -0400
Date: Tue, 19 Oct 2004 02:54:43 -0600
From: "Evan N. McNabb" <evan@mcnabbs.org>
To: linux-kernel@vger.kernel.org
Subject: ACPI and orinoco_pci (2.6.9)
Message-ID: <20041019085443.GC9189@mcnabbs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

First of all, a thanks to those who have worked on ACPI. Suspend to RAM
works for the first time on my laptop with the 2.6.9 kernel! (Sony
v505BX)

There is a problem, however, with the wireless card after the system
resumes. It's a built in PCI wireless card with a Prism 2.5 chipset that
uses the orinoco_pci driver. Once the resume occurs I can't seem to get
the wireless card to work again (i.e. removing the modules, etc).

Here's some info below. Any ideas? Thanks!

-Evan

0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
0000:02:02.0 Network controller: Intersil Corporation: Unknown device 3872 (rev 01)
0000:02:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev b8)
0000:02:05.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C551 IEEE 1394 Controller
0000:02:07.0 USB Controller: NEC Corporation USB (rev 43)
0000:02:07.1 USB Controller: NEC Corporation USB (rev 43)
0000:02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
0000:02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)

0000:02:02.0 Network controller: Intersil Corporation: Unknown device 3872 (rev 01)
        Subsystem: AMBIT Microsystem Corp.: Unknown device 0202
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f8000000 (32-bit, prefetchable)
        Capabilities: <available only to root>

* dmesg from the suspend:
-------------------------------------------------------------------------
PM: Entering state.
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2052
in_atomic():0, irqs_disabled():1
 [<c0105ea4>] dump_stack+0x1e/0x22
 [<c01188b4>] __might_sleep+0xb2/0xd3
 [<c013d308>] __kmalloc+0x93/0x9a
 [<c023d9c3>] acpi_os_allocate+0x10/0x14
 [<c02608a9>] acpi_ut_allocate+0x5e/0xa5
 [<c02609d6>] acpi_ut_allocate_and_track+0x1c/0x61
 [<c0260806>] acpi_ut_initialize_buffer+0x46/0x8b
 [<c025ae7b>] acpi_rs_create_byte_stream+0x94/0xfd
 [<c025d9c3>] acpi_rs_set_srs_method_data+0x42/0xf3
 [<c025bd91>] acpi_set_current_resources+0x69/0x81
 [<c02683c8>] acpi_pci_link_set+0x181/0x2a1
 [<c02689ae>] acpi_pci_link_resume+0x49/0x81
 [<c0268a2d>] irqrouter_resume+0x47/0x71
 [<c02a05f7>] sysdev_resume+0xe7/0xec
 [<c02a3bbf>] device_power_up+0x8/0xe
 [<c01329cb>] suspend_enter+0x35/0x46
 [<c0132a7d>] enter_state+0x68/0x9d
 [<c0265237>] acpi_suspend+0x3f/0x4c
 [<c026567f>] acpi_system_write_sleep+0x6a/0x7f
 [<c0150fc4>] vfs_write+0xa1/0x10c
 [<c01510ef>] sys_write+0x4b/0x75
 [<c010504f>] syscall_call+0x7/0xb
orinoco_lock() called with hw_unavailable (dev=df5ec000)
orinoco_lock() called with hw_unavailable (dev=df5ec000)
PM: Finishing up.
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
radeonfb: resumed !
eth1: Orinoco-PCI waking up
eth1: Error -19 re-initializing firmware on orinoco_pci_resume()
ACPI: PCI interrupt 0000:02:05.1[B] -> GSI 9 (level, low) -> IRQ 9
orinoco_lock() called with hw_unavailable (dev=df5ec000)
orinoco_lock() called with hw_unavailable (dev=df5ec000)
orinoco_lock() called with hw_unavailable (dev=df5ec000)
orinoco_lock() called with hw_unavailable (dev=df5ec000)
orinoco_lock() called with hw_unavailable (dev=df5ec000)
orinoco_lock() called with hw_unavailable (dev=df5ec000)
orinoco_lock() called with hw_unavailable (dev=df5ec000)
Restarting tasks... done
-------------------------------------------------------------------------

* dmesg when trying to reload the orinoco_pci driver:

orinoco 0.13e (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_pci 0.13e (Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourril
hes <jt@hpl.hp.com>)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 9 (level, low) -> IRQ 9
orinoco_pci: Detected Orinoco/Prism2 PCI device at 0000:02:02.0, mem:0xF8000000 to 0xF8000FFF -> 0xe0838000,
 irq:9
Reset done..................................................................................................
............................................................................................................
............................................;
Clear Reset.................................................................................................
............................................................................................................
............................................................................................................
............................................................................................................
...............................................................................;
orinoco_pci: Busy timeout
eth%d: Failed to start the card
orinoco_pci: probe of 0000:02:02.0 failed with error -110
-------------------------------------------------------------------------

/********************************************************************\
       Evan McNabb: <evan@mcnabbs.org> <emcnabb@gurulabs.com>
                      Instructor, Guru Labs
		     http://evan.mcnabbs.org
 GnuPG Fingerprint: 53B5 EDCA 5543 A27A E0E1 2B2F 6776 8F9C 6A35 6EA5
\********************************************************************/

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBdNZTZ3aPnGo1bqURAvd3AJ48P5/VTu9Fa0qyNuh7lBLy2jAE8gCeO25e
JEx3GNp+uLQvM+ufousdR5M=
=EAMD
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

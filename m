Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVB1Ts4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVB1Ts4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVB1Tsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:48:55 -0500
Received: from h80ad25cd.async.vt.edu ([128.173.37.205]:523 "EHLO
	h80ad25cd.async.vt.edu") by vger.kernel.org with ESMTP
	id S261598AbVB1Ts1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:48:27 -0500
Message-Id: <200502281948.j1SJmKdV006528@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc4-mm1 - pcmcia weirdness/breakage
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109620099_3594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Feb 2005 14:48:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109620099_3594P
Content-Type: text/plain; charset=us-ascii

Symptoms:  Running '/etc/init.d/pcmcia start' bombs - cardmgr goes into
a loop spewing repeated 'Common memory region at 0x0: Generic or SRAM'
messages.  In the dmesg, we find:

[4294764.989000]  <6>cs: IO port probe 0xc00-0xcff: clean.
[4294859.195000] cs: IO port probe 0xc00-0xcff: clean.
[4294859.195000] cs: IO port probe 0xc00-0xcff: clean.
[4294859.199000] cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x37f
[4294859.202000] cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x37f
[4294859.205000] cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x37f
[4294859.207000] cs: IO port probe 0xa00-0xaff: clean.
[4294859.208000] cs: IO port probe 0xa00-0xaff: clean.
[4294859.209000] cs: IO port probe 0xa00-0xaff: clean.
[4294859.369000] cs: unable to map card memory!
[4294859.369000] cs: unable to map card memory!

Now the odd part:

2.6.11-rc4 works, doesn't show the last 2 'unable to map' messages.
2.6.11-rc4 + linus.patch from -rc4-mm1 works as well - so it's a -mm patch doing it.

A full -rc4-mm1 fails, *as does* a -rc4-mm1 with all the following patches -R'ed:

broken-out/fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
broken-out/pcmcia-add-pcmcia-devices-autonomously.patch
broken-out/pcmcia-bridge-resource-management-fix.patch
broken-out/pcmcia-determine-some-useful-information-about-devices.patch
broken-out/pcmcia-mark-resource-setup-as-done.patch
broken-out/pcmcia-pcmcia_device_add.patch
broken-out/pcmcia-pcmcia_device_probe.patch
broken-out/pcmcia-pcmcia_device_remove.patch
broken-out/pcmcia-pd6729-convert-to-pci_register_driver.patch
broken-out/pcmcia-per-device-sysfs-output.patch
broken-out/pcmcia-rsrc_nonstatic-sysfs-input.patch
broken-out/pcmcia-rsrc_nonstatic-sysfs-output.patch
broken-out/pcmcia-update-vrc4171_card.patch
broken-out/pcmcia-use-bus_rescan_devices.patch
broken-out/pcmcia-yenta_socket-ti4150-support.patch

So the breakage is in *some other* -rc4-mm1 patch.  Any hints to speed up
the binary search?

--==_Exmh_1109620099_3594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCI3WDcC3lWbTT17ARAqhPAJ9LEbJjKh/J/CQ3mGdy0e9hKqlE+QCfX5ll
8m2Viht8DyIlBPhM4o2Q1tk=
=wiFv
-----END PGP SIGNATURE-----

--==_Exmh_1109620099_3594P--

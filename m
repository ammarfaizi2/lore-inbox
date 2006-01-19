Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161405AbWASVuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161405AbWASVuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWASVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:50:05 -0500
Received: from smtp06.auna.com ([62.81.186.16]:47508 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1161405AbWASVuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:50:03 -0500
Date: Thu, 19 Jan 2006 22:53:45 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: 3c59x went nuts between .15-mm3 and .15-mm4
Message-ID: <20060119225345.18a570ae@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs172 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_T4RfQKPjnJ0c8P3Q8e0jViQ;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.216.29] Login:jamagallon@able.es Fecha:Thu, 19 Jan 2006 22:49:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_T4RfQKPjnJ0c8P3Q8e0jViQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all...

I can't use 2.6.15-mm4 on one of my boxes because it renders the 3Com NIC
broken. No network connection. This is a 3c905C-TX/TX-M [Tornado] (rev 74).
On one other box, I have a 3c980-C 10/100baseTX NIC [Python-T] (rev 78),
driven also with 3c59x, that goes also deafmute.
I have seen the changes between -mm3 and -mm4, and looks like a rewrite
to use mii instead of homebrew code (btw, should not this increase the
driver version number ?). But something there broke (or, as usual, some
change in ACPI...).

This is relevant dmesg diff between both kernels:

 process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
 ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 18 (level, low) -> IRQ 169
 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
-0000:04:02.0: 3Com PCI 3c905C Tornado at f0946000. Vers LK1.1.19
+0000:04:02.0: 3Com PCI 3c905C Tornado at f099c000. Vers LK1.1.19
                                          ^^^^^^^^ Uh ?
 PCI: Setting latency timer of device 0000:04:02.0 to 64
 ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 18 (level, low) -> IRQ 169
 e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
 e100: Copyright(c) 1999-2005 Intel Corporation
-ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 16 (level, low) -> IRQ 209
+ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 16 (level, low) -> IRQ 201
 PCI: Setting latency timer of device 0000:04:04.0 to 64
-e100: eth1: e100_probe: addr 0xe1100000, irq 209, MAC addr 00:30:48:22:B6:=
57
+e100: eth1: e100_probe: addr 0xe1100000, irq 201, MAC addr 00:30:48:22:B6:=
57
 e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
 Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
 Copyright (c) 1999-2005 Intel Corporation.
...
+NETDEV WATCHDOG: eth0: transmit timed out
+eth0: transmit timed out, tx_status 00 status 8000.
+  diagnostics: net 0cfa media 8880 dma 000000a0 fifo 8800
+  Flags; bus-master 1, dirty 83(3) current 99(3)
+  Transmit list 3eb1f3e0 vs. eeb1f3e0.
+  0: @eeb1f200  length 8000002a status 0000002a
+  1: @eeb1f2a0  length 8000002a status 8000002a
+  2: @eeb1f340  length 8000002a status 8000002a
+  3: @eeb1f3e0  length 8000002a status 0000002a
+  4: @eeb1f480  length 8000002a status 0000002a
+  5: @eeb1f520  length 8000002a status 0000002a
+  6: @eeb1f5c0  length 8000002a status 0000002a
+  7: @eeb1f660  length 8000002a status 0000002a
+  8: @eeb1f700  length 8000002a status 0000002a
+  9: @eeb1f7a0  length 8000002a status 0000002a
+  10: @eeb1f840  length 8000002a status 0000002a
+  11: @eeb1f8e0  length 8000002a status 0000002a
+  12: @eeb1f980  length 8000002a status 0000002a
+  13: @eeb1fa20  length 8000002a status 0000002a
+  14: @eeb1fac0  length 8000002a status 0000002a
+  15: @eeb1fb60  length 8000002a status 0000002a
+eth0: Resetting the Tx ring pointer.

Any idea ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam4 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_T4RfQKPjnJ0c8P3Q8e0jViQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0AppRlIHNEGnKMMRAivJAJ9cjLs6xONXIq7basCXbnWRIZ6w5ACfXCGW
0fcs37BU4PJ1m7gEKZ7EKO4=
=1PiO
-----END PGP SIGNATURE-----

--Sig_T4RfQKPjnJ0c8P3Q8e0jViQ--

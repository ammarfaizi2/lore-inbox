Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTI3JI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbTI3JI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:08:56 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:34448 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261232AbTI3JIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:08:53 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: irq 12: nobody cared! (2.6.0-test6)
Date: Tue, 30 Sep 2003 11:04:49 +0200
User-Agent: KMail/1.5.9
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0309290947230.9442-100000@math.ut.ee> <1064830579.1389.0.camel@teapot.felipe-alfaro.com> <200309300935.18997.arekm@pld-linux.org>
In-Reply-To: <200309300935.18997.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_0cUe/zS/lIOQ84X";
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200309301104.52810.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_0cUe/zS/lIOQ84X
Content-Type: multipart/mixed;
  boundary="Boundary-01=_xcUe/6Tfwe6E6Nj"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_xcUe/6Tfwe6E6Nj
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 30 September 2003 09:35, Arkadiusz Miskiewicz wrote:
> On Monday 29 of September 2003 12:16, Felipe Alfaro Solana wrote:
> > Have you tried with 2.6.0-test6-mm1? It includes a fix for ACPI PCI
> > routing which may help in your case.
>
> I've tried 2.6.0test6+cset patch 20030929_1907+ all *acpi* patches from
> test6-mm1 and:

  ~~ snip ~~

> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver
> v2.1
> uhci-hcd 0000:00:11.2: UHCI Host Controller
> irq 10: nobody cared!
> Call Trace:
>  [<c010cc1b>] __report_bad_irq+0x2b/0x90
>  [<c010cd14>] note_interrupt+0x64/0xa0
>  [<c010cfae>] do_IRQ+0x12e/0x140
>  [<c010b4dc>] common_interrupt+0x18/0x20
>  [<c0125484>] do_softirq+0x44/0xa0
>  [<c010cf88>] do_IRQ+0x108/0x140
>  [<c010b4dc>] common_interrupt+0x18/0x20
>  [<c01b364c>] pci_bus_write_config_word+0x5c/0x80
>  [<cf9b0480>] uhci_reset+0x40/0x50 [uhci_hcd]
>  [<cf89ba32>] usb_hcd_pci_probe+0x192/0x480 [usbcore]
>  [<c01b72fb>] pci_device_probe_static+0x4b/0x60
>  [<c01b734c>] __pci_device_probe+0x3c/0x50
>  [<c01b738c>] pci_device_probe+0x2c/0x50
>  [<c01fb4ed>] bus_match+0x3d/0x70
>  [<c01fb640>] driver_attach+0x70/0xb0
>  [<c01fb941>] bus_add_driver+0xa1/0xc0
>  [<c01fbd91>] driver_register+0x31/0x40
>  [<c01b756e>] pci_register_driver+0x5e/0x90
>  [<cf9240c7>] uhci_hcd_init+0xc7/0x143 [uhci_hcd]
>  [<c01381c3>] sys_init_module+0x123/0x270
>  [<c010b36f>] syscall_call+0x7/0xb

Seems like the attached patch from Wim Van Sebroeck could help you...

   Thomas Schlichter

--Boundary-01=_xcUe/6Tfwe6E6Nj
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="fix_uhci-hcd.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix_uhci-hcd.diff"

=2D-- linux-2.6.0-test6/drivers/usb/host/uhci-hcd.c	2003-09-28 02:50:56.000=
000000 +0200
+++ linux-2.6.0-test6/drivers/usb/host/uhci-hcd.c	2003-09-28 23:21:30.00000=
0000 +0200
@@ -2185,8 +2185,8 @@
 	/* Maybe kick BIOS off this hardware.  Then reset, so we won't get
 	 * interrupts from any previous setup.
 	 */
=2D	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
 	reset_hc(uhci);
+	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
 	return 0;
 }
=20

--Boundary-01=_xcUe/6Tfwe6E6Nj--

--Boundary-03=_0cUe/zS/lIOQ84X
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/eUc0YAiN+WRIZzQRAjriAKDj+PT/BuDLL1tD6Z20jVYxmnVNOACdHuki
zqcvybay6PlBbdF79xkjtvA=
=VlGy
-----END PGP SIGNATURE-----

--Boundary-03=_0cUe/zS/lIOQ84X--

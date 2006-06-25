Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWFYJZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWFYJZR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWFYJZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:25:17 -0400
Received: from master.altlinux.org ([62.118.250.235]:58126 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932163AbWFYJZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:25:15 -0400
Date: Sun, 25 Jun 2006 13:24:57 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: "Scott J. Harmon" <harmon@ksu.edu>
Cc: linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: acpi gets wrong interrupt for via sata in 2.6.16.17
Message-Id: <20060625132457.4b0922b4.vsu@altlinux.ru>
In-Reply-To: <449DE6BA.2050206@ksu.edu>
References: <449DE6BA.2050206@ksu.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__25_Jun_2006_13_24_57_+0400_h/X0YWfFy5v7LBom"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__25_Jun_2006_13_24_57_+0400_h/X0YWfFy5v7LBom
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Jun 2006 20:28:26 -0500 Scott J. Harmon wrote:

> The short: something that came in 2.6.16.17 has caused my sata to no
> longer work correctly (by work correctly, I mean actually be able to
> detect any drives).  I'm no expert, but it seems that it is getting the
> wrong interrupt.  In 2.6.16.16 it works fine with the exact same config.
>  It also works fine if I append 'pci=3Dnoacpi'.  This has still happens in
> 2.6.17.

I assume that your root filesystem is on a SATA disk, and therefore you
don't have an easy way to extract dmesg from a broken kernel?

> Here is the output of lspci:
>=20
> scott@amdg:~$ /sbin/lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
> Host Bridge (rev 80)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> 00:07.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705
> Gigabit Ethernet (rev 03)
> 00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> Controller (rev 46)
> 00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev =
10)
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
> Controller (rev 80)
> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
> [KT600/K8T800/K8T890 South]
> 01:00.0 VGA compatible controller: nVidia Corporation NV15DDR [GeForce2
> Ti] (rev a4)

Try to revert these patches:

http://kernel.org/git/?p=3Dlinux/kernel/git/stable/linux-2.6.16.y.git;a=3Dc=
ommitdiff_plain;h=3Ddc0f369552b491d1578e8a8c6f6512e17246241c

http://kernel.org/git/?p=3Dlinux/kernel/git/stable/linux-2.6.16.y.git;a=3Dc=
ommitdiff_plain;h=3Dc72493379d4aaac49ad3366987db1e118bb4f5ba

(revert in the above order - these are two patches which depend on each
other, you need to revert both).  You can try it both with 2.6.16.17
and 2.6.17.

Chris: seems that the SATA subdevice (1106:3149) also needs the quirk,
like EHCI, sound and builtin network.

--Signature=_Sun__25_Jun_2006_13_24_57_+0400_h/X0YWfFy5v7LBom
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEnlZpW82GfkQfsqIRAk6tAJ900/ScS7LBRpI6R6I6dmbJjqSMXgCgk2mR
Gn5a7a/jOEYXIr1Y85iy0fg=
=Mu5V
-----END PGP SIGNATURE-----

--Signature=_Sun__25_Jun_2006_13_24_57_+0400_h/X0YWfFy5v7LBom--

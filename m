Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753455AbWKCTAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbWKCTAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbWKCTAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:00:43 -0500
Received: from master.altlinux.org ([62.118.250.235]:50192 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1753455AbWKCTAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:00:42 -0500
Date: Fri, 3 Nov 2006 22:00:18 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Alberto Alonso <alberto@ggsys.net>
Cc: mlord@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
Message-Id: <20061103220018.577ded43.vsu@altlinux.ru>
In-Reply-To: <1162576973.3967.10.camel@w100>
References: <1162576973.3967.10.camel@w100>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Nov_2006_22_00_18_+0300_vuR+bjWGw_9MOph+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__3_Nov_2006_22_00_18_+0300_vuR+bjWGw_9MOph+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 03 Nov 2006 12:02:53 -0600 Alberto Alonso wrote:

> I have a Pacific Digital qstor card on irq 193. I am using kernel
> 2.6.17.13 SMP
>=20
> The error happens every now and then. I have not been able to
> figure out any triggers and I can not reproduce it on demand. Today
> it happened 3 times within a 40 minutes period.=20
>=20
> All disks connected to the card are disabled and I can't do anything
> other than a reboot to get them back.
>=20
> It is reported as follows:
>=20
> irq 193: nobody cared (try booting with the "irqpoll" option)

Did you try this option?  It may decrease performance, but in some cases
IRQ routing is so screwed that only irqpoll helps.

[...]
> handlers:
> [<c0301300>] (qs_intr+0x0/0x220)
> Disabling IRQ #193
[..]
> If there is any other info that I should provide to help=20
> troubleshoot please let me know.

The "nobody cared" error is often caused by some other device which
shares the same interrupt, but Linux does not know about it (either due
to broken IRQ routing tables in BIOS, or because the driver for that
device is not loaded, but the device really is active and asserts its
IRQ line - sometimes this also happens due to a broken BIOS).

Please post complete /proc/interrupts and lspci -v output, and also
information about the motherboard model and BIOS version.

If your motherboard has a VIA chipset, you may also try the patch from
http://lkml.org/lkml/2006/9/7/235 which attempts to fix IRQ routing on
these chipsets.

--Signature=_Fri__3_Nov_2006_22_00_18_+0300_vuR+bjWGw_9MOph+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFS5HFW82GfkQfsqIRAkRjAJ43M4LTzwHfRKiERdnu+YGuwxj7LQCgjt3x
24h59ZuXvrF1X4Rq8kfRJwU=
=4ORO
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Nov_2006_22_00_18_+0300_vuR+bjWGw_9MOph+--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423317AbWF1Mdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423317AbWF1Mdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423318AbWF1Mdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:33:45 -0400
Received: from mivlgu.ru ([81.18.140.87]:23769 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1423317AbWF1Mdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:33:44 -0400
Date: Wed, 28 Jun 2006 16:33:39 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Rodrigo Amestica <ramestic@nrao.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc kernel parameter
Message-Id: <20060628163339.d2110437.vsu@altlinux.ru>
In-Reply-To: <44A272CA.5000209@nrao.edu>
References: <44A272CA.5000209@nrao.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__28_Jun_2006_16_33_39_+0400_XT0ZjPDMKll9RJ5s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__28_Jun_2006_16_33_39_+0400_XT0ZjPDMKll9RJ5s
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jun 2006 08:15:06 -0400 Rodrigo Amestica wrote:

> Hi, I'm having troubles when using the vmalloc kernel parameter.
>=20
> My grub config looks as shown below. If I set vmalloc to anything
> bigger than 128M (the default) then the kernel will not boot and it
> will log the following on the console:
>=20
> VFS: Cannot open root device "LABEL=3D/" or unknown-block(0,0)
> Please append a correct "root=3D" boot option
> Kernel Panic - not syncing: VFS Unable to mount root fs on
> unknown-block(0,0)
>=20
> If I specify 128M or less then the kernel will boot just fine and
> /proc/meminfo will show the effect in VmallocTotal.
>=20
> Any hint on what I'm crashing with?

This is a known problem with GRUB: it tries to put initrd at the highest
possible address in memory, and assumes the standard vmalloc area size.
You need to trick GRUB into thinking that your machine has less memory
by using "uppermem 524288" (512M) or even lower - then the initrd data
will still be accessible for the kernel even with larger vmalloc area.

http://lkml.org/lkml/2005/4/4/283
http://lists.linbit.com/pipermail/drbd-user/2005-April/002890.html

> ps: my kernel version is 2.6.15.2, and my machine is a dual opteron
> with 2GB of ram
>=20
> title with vmalloc
>          root (hd0,0)

Add "uppermem 524288" here.

>          kernel /boot/vmlinuz ro root=3DLABEL=3D/ vmalloc=3D256M
>          initrd /boot/initrd.img

--Signature=_Wed__28_Jun_2006_16_33_39_+0400_XT0ZjPDMKll9RJ5s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEoncmW82GfkQfsqIRAhuvAJwKLcC0+lxClgiJnu73sqYQ4yTO9QCcCKLH
jWoZaHiEUBTXlZXhCXgAyXc=
=fFCI
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Jun_2006_16_33_39_+0400_XT0ZjPDMKll9RJ5s--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVCaLZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVCaLZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCaLZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:25:34 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:24535 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261313AbVCaLZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:25:25 -0500
Date: Thu, 31 Mar 2005 21:25:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, blaisorblade@yahoo.it, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] x86_64: remove duplicated sys_time64
Message-Id: <20050331212516.64506156.sfr@canb.auug.org.au>
In-Reply-To: <20050331111235.GL1623@wotan.suse.de>
References: <20050330173216.426CFEFECF@zion>
	<20050331103834.GC1623@wotan.suse.de>
	<20050331211059.0ddc078c.sfr@canb.auug.org.au>
	<20050331111235.GL1623@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__31_Mar_2005_21_25_16_+1000_ISH88l4Sh=HrLR1h"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__31_Mar_2005_21_25_16_+1000_ISH88l4Sh=HrLR1h
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Mar 2005 13:12:35 +0200 Andi Kleen <ak@suse.de> wrote:
>
> On Thu, Mar 31, 2005 at 09:10:59PM +1000, Stephen Rothwell wrote:
> > On Thu, 31 Mar 2005 12:38:34 +0200 Andi Kleen <ak@suse.de> wrote:
> > >
> > > Nack. The generic sys_time still writes to int, not long.
> > > That is why x86-64 has a private one. Please keep that.
> >=20
> > It writes to a time_t which is a __kernel_time_t which is a long on
> > x86-64, isn't it?
>=20
> At least in 2.6.10 it writes to int.

I was looking at current bk where it looks like this:

asmlinkage long sys_time(time_t __user * tloc)
{
        time_t i;
        struct timeval tv;

        do_gettimeofday(&tv);
        i =3D tv.tv_sec;

        if (tloc) {
                if (put_user(i,tloc))
                        i =3D -EFAULT;
        }
        return i;
}

I have no idea when it changed.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__31_Mar_2005_21_25_16_+1000_ISH88l4Sh=HrLR1h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCS94h4CJfqux9a+8RAiASAKCAxyBIJ2CsX70EKQ025acQNwZDrwCgiZPR
1B/fuz19rjU1HP41DXH6V+M=
=8qe4
-----END PGP SIGNATURE-----

--Signature=_Thu__31_Mar_2005_21_25_16_+1000_ISH88l4Sh=HrLR1h--

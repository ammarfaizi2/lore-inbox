Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbUCCJ2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbUCCJ2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:28:21 -0500
Received: from mx1.actcom.net.il ([192.114.47.13]:63635 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S261730AbUCCJ2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:28:19 -0500
Date: Wed, 3 Mar 2004 11:22:39 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: modules registering as sysctl handlers
Message-ID: <20040303092239.GA31820@mulix.org>
References: <20040302122909.GG24260@mulix.org> <20040302124106.GQ16357@parcelfarce.linux.theplanet.co.uk> <1078272339.15766.5.camel@bach>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <1078272339.15766.5.camel@bach>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2004 at 11:05:39AM +1100, Rusty Russell wrote:

> Al is referring to the fact that there's no protection for a dynamically
> allocated ctl_table.
>=20
> However, an owner field and standard module_get() would solve the case
> of statically declared ctl_table.

That's what I had in mind.=20
=20
> I don't know that there's a current user who requires it though?

Yes, there are. Using the attached scriptlet on a 2.6.1 tree I had
lying around:=20

[root@hydra kernel]# /tmp/find-register-sysctl=20
/lib/modules/2.6.1/kernel/drivers/cdrom/cdrom.ko uses register_sysctl
/lib/modules/2.6.1/kernel/drivers/parport/parport.ko uses register_sysctl
/lib/modules/2.6.1/kernel/net/appletalk/appletalk.ko uses register_sysctl
/lib/modules/2.6.1/kernel/net/ipx/ipx.ko uses register_sysctl
/lib/modules/2.6.1/kernel/net/irda/irda.ko uses register_sysctl
/lib/modules/2.6.1/kernel/net/sctp/sctp.ko uses register_sysctl

I'm building 2.6.3-bk with allmodconfig now. Once it's done, I'll post
the resulting list.=20

#!/bin/sh

KERNEL_VER=3D2.6.1
for f in `find /lib/modules/${KERNEL_VER} -name "*.ko"`; do=20
    nm $f | grep register_sysctl 2>&1 > /dev/null
    if [ "x$?" =3D=3D "x0" ]; then
        echo "$f uses register_sysctl"
    fi
done

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARaPeKRs727/VN8sRAkflAJ9roRlf+kk69ZxUBqgJ03fxBPIIkQCgp6ia
0gkHlhQZKRM7sdRNTOWOIXo=
=mv8q
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

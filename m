Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVBHOYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVBHOYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVBHOYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:24:47 -0500
Received: from smtp07.auna.com ([62.81.186.17]:986 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261535AbVBHOYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:24:38 -0500
Date: Tue, 08 Feb 2005 14:24:37 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] raw1394 : Fix hang on unload
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
References: <1107718875.4378.25.camel@localhost.localdomain>
	<20050207101914.GA16686@hugang.soulinfo.com>
In-Reply-To: <20050207101914.GA16686@hugang.soulinfo.com> (from
	hugang@soulinfo.com on Mon Feb  7 11:19:14 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1107872677l.6054l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-QBHN+J3WVrHN7xWZqoBK"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-QBHN+J3WVrHN7xWZqoBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.02.07, hugang@soulinfo.com wrote:
> On Sun, Feb 06, 2005 at 02:41:15PM -0500, Parag Warudkar wrote:
> > I was seeing rmmod getting stuck consistently in D state while removing
> > raw1394. Looking at raw1394.c:cleanup_raw1394 - the order of doing
> > things seemed incorrect to me after comparing other places in raw1394.c
> > which do the same thing but with a different order.
> >=20
> > bash          R  running task       0  4319   3884                3900
> > (NOTLB)
> > rmmod         D 0000008428792a16     0  4490   3900
> > (NOTLB)
> > ffff81001cff9dd8 0000000000000082 0000000000000000 0000000100000000
> >        0000007400000000 ffff8100211c9070 000000000000097b
> > ffff81002c8a2800
> >        ffffffff80397c97 ffff81002b6f9360
> > Call Trace:<ffffffff80379d25>{__down+421}
> > <ffffffff80133510>{default_wake_function+0}
> >        <ffffffff8037cd8c>{__down_failed+53}
> > <ffffffff801c0e40>{generic_delete_inode+0}
> >        <ffffffff8029e540>{.text.lock.driver+5}
> > <ffffffff885a8260>{:raw1394:cleanup_raw1394+16}
> >        <ffffffff8015eb31>{sys_delete_module+497}
> > <ffffffff8021a692>{__up_write+514}
> >        <ffffffff80183efb>{sys_munmap+107} <ffffffff8010ecda>{system_cal=
l
> > +126}
> >=20
> > Attached patch fixes the rmmod raw1394 hang. Tested.
>=20
> I think sbp2 also need do this, attached patch will fix sbp2 rmmod
> hang, But not tested.
>=20

It happens the same for me with eth1394. Reversing the order of those
calls allows unloading of the module; as they are now, rmmod just hangs
forever...

I looked also at other 1394 drivers and all have the calls in 'bad' order.
Sure this ordering has to be reversed or it is correct and is triggering
other hidden bug ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam8 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-QBHN+J3WVrHN7xWZqoBK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCCMulRlIHNEGnKMMRAvYrAJ9NdL3PR97vVniv5c8AFR8zdVcA2QCfQOKz
FgT7jwwTZkM34DYD5GTTNmw=
=qBhB
-----END PGP SIGNATURE-----

--=-QBHN+J3WVrHN7xWZqoBK--


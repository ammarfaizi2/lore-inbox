Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUIXG1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUIXG1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUIXG1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:27:15 -0400
Received: from dea.vocord.ru ([217.67.177.50]:5782 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S268487AbUIXGY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:24:56 -0400
Subject: Re: [1/1] connector: Kernel connector - userspace <-> kernelspace
	"linker".
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Cc: Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1096006470.17587.37.camel@uganda>
References: <1095331899.18219.58.camel@uganda>
	 <20040921124623.GA6942@uganda.factory.vocord.ru>
	 <20040924000739.112f07dd@zanzibar.2ka.mipt.ru>
	 <20040923215447.GD30131@ruslug.rutgers.edu>
	 <1095997232.17587.8.camel@uganda>
	 <20040924054844.GO30131@ruslug.rutgers.edu>
	 <1096006470.17587.37.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hD0Sf8hCQxFHO3pSu8w1"
Organization: MIPT
Message-Id: <1096007404.17587.49.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 10:30:04 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hD0Sf8hCQxFHO3pSu8w1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-24 at 10:14, Evgeniy Polyakov wrote:
> On Fri, 2004-09-24 at 09:48, Luis R. Rodriguez wrote:
> > On Fri, Sep 24, 2004 at 07:40:32AM +0400, Evgeniy Polyakov wrote:
> > > On Fri, 2004-09-24 at 01:54, Luis R. Rodriguez wrote:
> > > > RFC:=20
> > > >=20
> > > > Can and should we work towards using this as interface for drivers =
that
> > > > need callbacks from an external (closed source) library/HAL?
> > >=20
> > > As I mentioned to Richard Jonson, it can be considered as
> > > ioctl. ioctl-ng!
> > > Unified interface (as ioctl) can be used for any type of modules.
> > > It is just a bit extended ioctl :)
> > >=20
> > > And _yes_, it can be used to turn on/off binary-only callbacks.
> > > Remember pwc - closed part can register callback and open part can
> > > send message, or even closed part can register notification when
> > > open part registers itself and begin to "trash the kernel".
> > >=20
> > > I understand that it is not right way to include it is into the kerne=
l,
> > > but I personally do not understand how it is different=20
> > > from just extended ioctl. It was designed to be usefull and convenien=
t,
> > > and it is.
> > >=20
> > > BTW, any binary-only module can _itself_ create netlink socket
> > > with input callback. And that is all - it will be absolutely
> > > the same as above.
> > >=20
> > > One may consider connector as yet-another-netlink-helper.
> > >=20
> >=20
> > Eh. I'm just wondering if there's any *right* way of using binary
> > callbacks on a linux driver so that it doesn't *taint* and possibly
> > *trash it*, as you said. I was wondering if perhaps through the
> > connector we could somehow protect the kernel of possibly ill-behaved c=
allbacks.
> >=20
> > Comments?
>=20
> Yes, we can.
> Connector itself has quite enough information about it's registrants.
>=20
> For example if it is somehow not good module( for example without GPL in
> it's license string) then connector can be extended to call it's
> callback from thread or in jail. If it is of interest I will think of
> some plugable mechanism for callback environment( probably provide
> ->before_callback() and ->after_callback() methods from external policy
> provider which may check callback data and/or confine callback execution
> ? ).
>=20
> We also may confine closed modules from being able to use event
> notification. In this scenario with worned out pwc-closed/open,
> situation will not differ from what we have now.

BTW, it can also restrict userspace event notification in following way:
when someone sends a message to notify group A of
registering/unregistering of device with id {x,y} then connector can
check if this group A is registered through callback_register_gpl(it is
not exist for now, but can be created as a copy of callback_register() )
or not. If it is GPL - send notify, else - execute=20
"mail -s "shit happens" linux-kernel@vger.kernel.org"=20
in the way /sbin/hotplug is called.
BTW, this decision also can be obtained from external policy module.

As you may think connector in current implementation is quite powerful
interface( if I will not praise it, who will? :) ), and somebody can
make bad things a bit easier with it, but it is also very flexible and
can be tuned to suit your needs.

I'm open for discussion :)

> > 	Luis
--=20
	Evgeniy Polyakov

Crash is better than data corruption. -- Art Grabowski

--=-hD0Sf8hCQxFHO3pSu8w1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBU77rIKTPhE+8wY0RAvVHAJ9xnAMas4iGun5iJVMD0nQbChzA3ACdHeJ2
bFvxAxfjVOSaBO6zO4gy30A=
=v0ZB
-----END PGP SIGNATURE-----

--=-hD0Sf8hCQxFHO3pSu8w1--


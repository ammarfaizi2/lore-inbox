Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUIXGjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUIXGjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268520AbUIXGha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:37:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:16073 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268496AbUIXGcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:32:36 -0400
Date: Fri, 24 Sep 2004 02:32:31 -0400
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/1] connector: Kernel connector - userspace <-> kernelspace "linker".
Message-ID: <20040924063231.GP30131@ruslug.rutgers.edu>
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <1095331899.18219.58.camel@uganda> <20040921124623.GA6942@uganda.factory.vocord.ru> <20040924000739.112f07dd@zanzibar.2ka.mipt.ru> <20040923215447.GD30131@ruslug.rutgers.edu> <1095997232.17587.8.camel@uganda> <20040924054844.GO30131@ruslug.rutgers.edu> <1096006470.17587.37.camel@uganda> <1096007404.17587.49.camel@uganda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Content-Disposition: inline
In-Reply-To: <1096007404.17587.49.camel@uganda>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2004 at 10:30:04AM +0400, Evgeniy Polyakov wrote:
> On Fri, 2004-09-24 at 10:14, Evgeniy Polyakov wrote:
> > On Fri, 2004-09-24 at 09:48, Luis R. Rodriguez wrote:
> > > On Fri, Sep 24, 2004 at 07:40:32AM +0400, Evgeniy Polyakov wrote:
> > > > On Fri, 2004-09-24 at 01:54, Luis R. Rodriguez wrote:
> > > > > RFC:=20
> > > > >=20
> > > > > Can and should we work towards using this as interface for driver=
s that
> > > > > need callbacks from an external (closed source) library/HAL?
> > > >=20
> > > > As I mentioned to Richard Jonson, it can be considered as
> > > > ioctl. ioctl-ng!
> > > > Unified interface (as ioctl) can be used for any type of modules.
> > > > It is just a bit extended ioctl :)
> > > >=20
> > > > And _yes_, it can be used to turn on/off binary-only callbacks.
> > > > Remember pwc - closed part can register callback and open part can
> > > > send message, or even closed part can register notification when
> > > > open part registers itself and begin to "trash the kernel".
> > > >=20
> > > > I understand that it is not right way to include it is into the ker=
nel,
> > > > but I personally do not understand how it is different=20
> > > > from just extended ioctl. It was designed to be usefull and conveni=
ent,
> > > > and it is.
> > > >=20
> > > > BTW, any binary-only module can _itself_ create netlink socket
> > > > with input callback. And that is all - it will be absolutely
> > > > the same as above.
> > > >=20
> > > > One may consider connector as yet-another-netlink-helper.
> > > >=20
> > >=20
> > > Eh. I'm just wondering if there's any *right* way of using binary
> > > callbacks on a linux driver so that it doesn't *taint* and possibly
> > > *trash it*, as you said. I was wondering if perhaps through the
> > > connector we could somehow protect the kernel of possibly ill-behaved=
 callbacks.
> > >=20
> > > Comments?
> >=20
> > Yes, we can.
> > Connector itself has quite enough information about it's registrants.
> >=20
> > For example if it is somehow not good module( for example without GPL in
> > it's license string) then connector can be extended to call it's
> > callback from thread or in jail. If it is of interest I will think of
> > some plugable mechanism for callback environment( probably provide
> > ->before_callback() and ->after_callback() methods from external policy
> > provider which may check callback data and/or confine callback execution
> > ? ).
> >=20
> > We also may confine closed modules from being able to use event
> > notification. In this scenario with worned out pwc-closed/open,
> > situation will not differ from what we have now.
>=20
> BTW, it can also restrict userspace event notification in following way:
> when someone sends a message to notify group A of
> registering/unregistering of device with id {x,y} then connector can
> check if this group A is registered through callback_register_gpl(it is
> not exist for now, but can be created as a copy of callback_register() )
> or not. If it is GPL - send notify, else - execute=20
> "mail -s "shit happens" linux-kernel@vger.kernel.org"=20
> in the way /sbin/hotplug is called.
> BTW, this decision also can be obtained from external policy module.
>=20
> As you may think connector in current implementation is quite powerful
> interface( if I will not praise it, who will? :) ), and somebody can
> make bad things a bit easier with it, but it is also very flexible and
> can be tuned to suit your needs.
>=20
> I'm open for discussion :)

Kernel maintainers:=20

What do you think? Can a driver which requires access to binary
callbacks be included as part of the stock kernel as GPL if Evgeniy's
Connector provides some sort of kernel "jail" for the callback
functionality?=20

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBU79/at1JN+IKUl4RAu3VAKCh2zLdHZbNgo5hh+YBcbX6rFWszwCgjbCY
dMrIA4Oi87HWkzgA3qGDpXY=
=aBD6
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--

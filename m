Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVDAHjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVDAHjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVDAHjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:39:53 -0500
Received: from dea.vocord.ru ([217.67.177.50]:21913 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262656AbVDAHjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:39:01 -0500
Subject: Re: [1/1] CBUS: new very fast (for insert operations) message bus
	based on kenel connector.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, greg@kroah.com
In-Reply-To: <20050331232625.09057712.akpm@osdl.org>
References: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
	 <20050331162758.44aeaf44.akpm@osdl.org> <1112337814.9334.42.camel@uganda>
	 <20050331232625.09057712.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ATHQlPygVqAecxeQzdeL"
Organization: MIPT
Date: Fri, 01 Apr 2005 11:45:14 +0400
Message-Id: <1112341514.9334.103.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 11:38:37 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ATHQlPygVqAecxeQzdeL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 23:26 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > > > +static int cbus_event_thread(void *data)
> >  > > +{
> >  > > +	int i, non_empty =3D 0, empty =3D 0;
> >  > > +	struct cbus_event_container *c;
> >  > > +
> >  > > +	daemonize(cbus_name);
> >  > > +	allow_signal(SIGTERM);
> >  > > +	set_user_nice(current, 19);
> >  >=20
> >  > Please use the kthread api for managing this thread.
> >  >=20
> >  > Is a new kernel thread needed?
> >=20
> >  Logic behind cbus is following:=20
> >  1. make insert operation return as soon as possible,
> >  2. deferring actual message delivering to the safe time
> >=20
> >  That thread does second point.
>=20
> But does it need a new thread rather than using the existing keventd?

Yes, it is much cleaner [especially from performance tuning point]=20
to use own kernel thread than pospone all work to the queued work.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-ATHQlPygVqAecxeQzdeL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTPwKIKTPhE+8wY0RAsE8AJ901QKleo2YDvCK4NwGUjOXPmgzdQCdGV2y
+YDOpK4eg/HSGpvEQRZuhvw=
=CTrk
-----END PGP SIGNATURE-----

--=-ATHQlPygVqAecxeQzdeL--


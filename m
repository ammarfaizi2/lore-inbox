Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVBUIgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVBUIgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVBUIgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:36:36 -0500
Received: from dea.vocord.ru ([217.67.177.50]:44731 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261920AbVBUIga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:36:30 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1108969656.8418.59.camel@frecb000711.frec.bull.fr>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	 <1108655454.14089.105.camel@uganda>
	 <1108969656.8418.59.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TppS0kdnAgGMWIHUXMRx"
Organization: MIPT
Date: Mon, 21 Feb 2005 11:41:32 +0300
Message-Id: <1108975292.6728.13.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 21 Feb 2005 11:35:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TppS0kdnAgGMWIHUXMRx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-02-21 at 08:07 +0100, Guillaume Thouvenin wrote:
> On Thu, 2005-02-17 at 18:50 +0300, Evgeniy Polyakov wrote:
> > On Thu, 2005-02-17 at 15:55 +0100, Guillaume Thouvenin wrote:
> > >     It's a new patch that implements a fork connector in the
> > > kernel/fork.c:do_fork() routine. The connector sends information abou=
t
> > > parent PID and child PID over a netlink interface. It allows to sever=
al
> > > user space applications to be alerted when a fork occurs in the kerne=
l.
> > > The main drawback is that even if nobody listens, a message is send. =
I
> > > don't know how to avoid that. I added an option (FORK_CONNECTOR) to
> > > enable the fork connector (or disable) when compiling the kernel. To
> > > work, connector must be compiled as built-in (CONFIG_CONNECTOR=3Dy). =
It
> > > has been tested on a 2.6.11-rc3-mm2 kernel with two user space
> > > applications connected.=20
> > >=20
> > >     It is used by ELSA to manage group of processes in user space. In
> > > conjunction with a per-process accounting information, like BSD or CS=
A,
> > > ELSA provides a per-group of processes accounting.
> >=20
> > I think people will complain here...
> > ... [cut here] ...
> > I still think that lsm with all calls logging is the best way to
> > achieve this goal.
>=20
> I agree with you. My first implementation was with LSM but Chris Wright
> (I think it was him) notice that it's not the right framework (and it
> seems true). So I looked for another solution. I though about kobject
> but it was too "big" and finally, Greg KH spoke about connectors. It's
> small and efficient.

Your do_fork() change really looks like either audit addon(but it is
really
not the case) or LSM logging facility.
I think adding cn_netlink_send() in every function in security/dummy.c
and renaming it to security/cn_logger.c or something is not such a bad
idea...
Or even wait in each function until userspace replies with the decision
to
allow or not such call.
Although it can create a lock (need to recheck security hooks in
send/recv pathes).

> > from the other side why only fork is monitored in this way?
>=20
> The problem is the following: I have a user space daemon that manages
> group of processes. The main idea is, if a parent belongs to a group
> then its child belongs to the same group. To achieve this I need to know
> when a fork occurs and which processes are involved. I don't see how to
> do this without a hook in the do_fork() routine... Any ideas are
> welcome.

Now I begin to understand Chris Wright - LSM are designed not for
monitoring,=20
but only for initialisation path - i.e. LSM will say only if something
is allowed or not,
but not if it was performed.

So, for exactly your setup there is no any other way then to patch
do_fork().

> Thank you Evgeniy for all your comments about the code, it helps and I
> will modify the patch.
>=20
> Regards,
> Guillaume
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-TppS0kdnAgGMWIHUXMRx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCGZ68IKTPhE+8wY0RAv6wAJ0TD2JkWttRqnstMOfLJZIliyiV4ACfQOGw
pbXm1W2VY2TkIwmNDB/mzSI=
=tIYa
-----END PGP SIGNATURE-----

--=-TppS0kdnAgGMWIHUXMRx--


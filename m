Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVCWEyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVCWEyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVCWEyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:54:25 -0500
Received: from dea.vocord.ru ([217.67.177.50]:35029 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262780AbVCWEyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:54:14 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jay Lan <jlan@engr.sgi.com>
Cc: Ram <linuxram@us.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Erich Focht <efocht@hpce.nec.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <4240AF8B.4000102@engr.sgi.com>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>
	 <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
	 <1111515979.5860.57.camel@localhost>
	 <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
	 <4240AF8B.4000102@engr.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YtnoMlqqwH0KS2+eaPNh"
Organization: MIPT
Date: Wed, 23 Mar 2005 08:01:05 +0300
Message-Id: <1111554065.23532.61.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 23 Mar 2005 07:53:56 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YtnoMlqqwH0KS2+eaPNh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-22 at 15:51 -0800, Jay Lan wrote:

> >>I think a better way is:
> >>
> >>   Providing a different connector channel called the administrator=20
> >>   channel which can be used only by a super-user, and gives you
> >>   the ability to switch on or off any connector channel including the
> >>   fork-connector channel.
> >=20
> >=20
> > Only super-user can bind netlink socket to multicast group.
> >=20
> >=20
> >>   For lack of better term I am using the word 'channel' to mean
> >>   something that carries events of particular type through the
> >>   connector-infrastructure.
> >=20
> >=20
> > I still do not see why it is needed.
> > Super-user can run ip command and turn network interface off
> > not waiting while apache or named exits or unbind.
>=20
> You can turn off a network interface and turn it back on without
> closing a network application and it will continue to work.

And connector's listeners will continue to listen it's events.
But there will not be any event.
Like application will continue to be bound to the IP and listen
for incomming connection, but there will not be any connection.

> >=20
> > In theory I can create some kind of userspace registration mechanism,
> > when userspace application reports it's pid to the connector,=20
> > and then it sends data to the specified pids, but does not=20
> > allow controlling from userspace.
> > But I really do not think it is a good idea to permit
> > non-priviledged userspace processes to know about deep
> > kernel internals through connector's messages.
>=20
> I see this issue less a case of bad guys vs. good guys. I see it
> as various components doing system related work, but there is
> no mechanism of knowing who is on who is off by today's patch. A
> service listening to the fork connector can request to turn off
> cn_fork_enable on exit and inadquately affect other services/daemons
> listening to the same connector. It is not acceptable in my opinion.

It is super-user who only is allowed to turn it off and even listen for
events,
since only super-user is allowed to bind socket to multicast netlink
group.
Super-user should not be allowed to control it's system?

> The idea of implementing fork connector enabling/disabling was so
> that the kernel does not waste time writing to the sockets if no
> application listening. If implementing such a feature costs
> more than it saves, maybe the fork connector should simply always
> send?

With CBUS it costs nothing to always send notifications,
but I still do not see a point of disallowing super-user to stop
fork notifications using arbitrary application.

> Thanks,
> - jay

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-YtnoMlqqwH0KS2+eaPNh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQPgRIKTPhE+8wY0RAlUMAJwNm/E/1PJt/rpv+toGnhvSEp4SXACfToId
9njmsc1kXsln3+yABjLS5Ps=
=0m5S
-----END PGP SIGNATURE-----

--=-YtnoMlqqwH0KS2+eaPNh--


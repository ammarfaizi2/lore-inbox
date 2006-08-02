Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWHBWwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWHBWwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWHBWwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:52:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44476 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932321AbWHBWwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:52:41 -0400
Subject: Re: [PATCH 005 of 9] md: Replace magic numbers in sb_dirty with
	well defined bit flags
From: Doug Ledford <dledford@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, NeilBrown <neilb@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44CF8B94.8030506@tmr.com>
References: <20060731172842.24323.patches@notabene>
	 <1060731073218.24482@suse.de> <200607311733.12848.ioe-lkml@rameria.de>
	 <44CF8B94.8030506@tmr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QSMC2eoEJd2hjdiC+0rK"
Organization: Red Hat, Inc.
Date: Wed, 02 Aug 2006 18:52:23 -0400
Message-Id: <1154559143.2725.418.camel@fc5.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QSMC2eoEJd2hjdiC+0rK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-01 at 13:12 -0400, Bill Davidsen wrote:
> Ingo Oeser wrote:
>=20
> >Hi Neil,
> >
> >I think the names in this patch don't match the description at all.
> >May I suggest different ones?
> >
> >On Monday, 31. July 2006 09:32, NeilBrown wrote:
> > =20
> >
> >>Instead of magic numbers (0,1,2,3) in sb_dirty, we have
> >>some flags instead:
> >>MD_CHANGE_DEVS
> >>   Some device state has changed requiring superblock update
> >>   on all devices.
> >>   =20
> >>
> >
> >MD_SB_STALE or MD_SB_NEED_UPDATE
> > =20
> >
> I think STALE is better, it is unambigous.
> > =20
> >
> >>MD_CHANGE_CLEAN
> >>   The array has transitions from 'clean' to 'dirty' or back,
> >>   requiring a superblock update on active devices, but possibly
> >>   not on spares
> >>   =20
> >>
> >
> >Maybe split this into MD_SB_DIRTY and MD_SB_CLEAN ?
> > =20
> >
> I don't think the split is beneficial, but I don't care for the name=20
> much. Some name like SB_UPDATE_NEEDED or the like might be better.

Yeah, no split.  The absence of a dirty flag denotes clean.

> > =20
> >
> >>MD_CHANGE_PENDING
> >>   A superblock update is underway. =20
> >>   =20
> >>
> >
> >MD_SB_PENDING_UPDATE
> >
> > =20
> >
> I would have said UPDATE_PENDING, but either is more descriptive than=20
> the original.
>=20
> Neil - the logic in this code is pretty complex, all the help you can=20
> give the occasional reader, by using very descriptive names for things,=20
> is helpful to the reader and reduces your "question due to=20
> misunderstanding" load.

Well, if you don't mind the length you could do:

MD_SB_WRITEOUT_ALL	/* we need to flush all superblocks due
                         * to a device change. */
MD_SB_WRITEOUT_SOME	/* we need to flush the active devices
                         * superblocks due to normal write operations */
MD_SB_WRITEOUT_PENDING	/* the flush is underway */

In trying to come up with descriptive names for this, it really points
out how having both the "I need something" and "I'm handling something"
flags in the same name space sucks.

Anyway, I don't think Neil's original names were that bad, just
obviously the names describe the condition that precipitated the state,
not the current state, implying that a reader of that code should
probably be thinking about what caused the state more than the state
when determining the appropriate course of action.  It may be preferable
to leave them that way to push readers towards that sort of analysis,
whatever Neil thinks is best on that.

--=20
Doug Ledford <dledford@redhat.com>
              GPG KeyID: CFBFF194
              http://people.redhat.com/dledford

Infiniband specific RPMs available at
              http://people.redhat.com/dledford/Infiniband

--=-QSMC2eoEJd2hjdiC+0rK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBE0Syng6WylM+/8ZQRAuiLAJ4zjwAhgTlgdkJgJrVenJxHKGlhxQCaAx5G
6SPEWMbnqP/ZpsWtaASvWdw=
=5GYo
-----END PGP SIGNATURE-----

--=-QSMC2eoEJd2hjdiC+0rK--


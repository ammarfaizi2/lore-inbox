Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTKQXqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTKQXqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:46:55 -0500
Received: from smtp05.web.de ([217.72.192.209]:2587 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262115AbTKQXqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:46:53 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: john stultz <johnstul@us.ibm.com>,
       "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Date: Tue, 18 Nov 2003 00:46:07 +0100
User-Agent: KMail/1.5.9
Cc: "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr
References: <1069071092.3238.5.camel@localhost.localdomain> <1069109719.11424.1994.camel@cog.beaverton.ibm.com> <1069110272.11438.2000.camel@cog.beaverton.ibm.com>
In-Reply-To: <1069110272.11438.2000.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_G3Vu/8rqBGruXy7";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200311180046.14787.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_G3Vu/8rqBGruXy7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 18 November 2003 00:04, john stultz wrote:
> On Mon, 2003-11-17 at 14:55, john stultz wrote:
> > On Mon, 2003-11-17 at 14:51, Prakash K. Cheemplavam wrote:
> > > john stultz wrote:
> > > > You're correct, I forgot to initialize cpu_khz in the ACPI PM
> > > > timesource init code. This patch fixes that.
> > >
> > > Well I applied your patch without the ones from Thomas Schlichter. Was
> > > is intended like that or should it be on top of Thomas patches?
> >
> > It was to go along side of Thomas' patch. Thomas caught the real issue
> > (sched_clock() needs to be switched on use_tsc), but cpu_khz is also
> > used in the scheduler, so I just wanted to make sure it was properly set
> > as well.
>
> After sending out multiple patches I should have been more clear. Just
> to avoid confusion:
>
> * the init_cpu_khz patch goes along side Thomas' patch.
>
> * the more experimental sched_clock() -> monotonic_clock() patch I just
> sent out for testing replaces Thomas' patch.
>
> thanks
> -john

OK, now I was testing both your patches instead of mine.
The init_cpu_khz patch works as expected... THX!

Well, but the sched_clock() -> monotonic_clock() patch seems to have a=20
problem...
=46irst, everything works smoothly if the PIT or the TSC clock are selected=
=2E (It=20
seems I cannot test the HPET timer due to missing hardware support)

But when booting with the PMTMR clock selected, my Interactivity test fails=
=20
again. :-( Maybe there is a problem in the PMTMR's monotonic clock part...?!

  Thomas

--Boundary-02=_G3Vu/8rqBGruXy7
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/uV3GYAiN+WRIZzQRAhC6AJ9NAUI7e5fh36lZ4WpZ1AFDH7poGwCfe0OM
0LCeH3KRFC1LkObqs+wHqRk=
=0E2m
-----END PGP SIGNATURE-----

--Boundary-02=_G3Vu/8rqBGruXy7--

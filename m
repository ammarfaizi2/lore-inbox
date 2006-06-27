Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWF0XjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWF0XjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWF0XjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:39:06 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21685 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1422732AbWF0XjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:39:05 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend2][ 15/20] [Suspend2] Attempt to freeze processes.
Date: Wed, 28 Jun 2006 09:38:58 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net> <20060626223537.4050.72340.stgit@nigel.suspend2.net> <20060627134514.GC3019@elf.ucw.cz>
In-Reply-To: <20060627134514.GC3019@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart35985744.lrZS0SbcxS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606280939.02044.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart35985744.lrZS0SbcxS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 23:45, Pavel Machek wrote:
> Hi!
>
> > Call the freezer code to get processes frozen, and abort suspending if
> > that fails. May be called multiple times as we thaw kernel space (only)
> > if we need to free memory to meet constraints.
>
> Current code seems to free memory without need to thaw/re-freeze
> kernel threads. Have you found bugs in that, or is this unneccessary?

Did you read my other email? Try it with a swap file on a journalled=20
filesystem, in a situation where freeing memory will force the swap file to=
=20
be used.

Regards,

Nigel

> > +static int attempt_to_freeze(void)
> > +{
> > +	int result;
> > +
> > +	/* Stop processes before checking again */
> > +	thaw_processes(FREEZER_ALL_THREADS);
> > +	suspend_prepare_status(CLEAR_BAR, "Freezing processes");
> > +	result =3D freeze_processes();
> > +
> > +	if (result) {
> > +		set_result_state(SUSPEND_ABORTED);
> > +		set_result_state(SUSPEND_FREEZING_FAILED);
> > +	} else
> > +		are_frozen =3D 1;
> > +
> > +	return result;
> > +}
> > +

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart35985744.lrZS0SbcxS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEocGWN0y+n1M3mo0RAvuNAJ93kqhZd2jYju51YSujWdB2fDqx6wCg2wms
UlhpwZ/QBjkxhQSwRsivfRk=
=NOsL
-----END PGP SIGNATURE-----

--nextPart35985744.lrZS0SbcxS--

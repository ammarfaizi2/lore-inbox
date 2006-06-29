Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933046AbWF2WPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWF2WPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933054AbWF2WP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:15:29 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:388 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S933050AbWF2WPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:15:25 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
Date: Fri, 30 Jun 2006 08:15:17 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net> <200606271634.43662.nigel@suspend2.net> <44A3FE3B.6070103@yahoo.com.au>
In-Reply-To: <44A3FE3B.6070103@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1820088.1RgZixBAdq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606300815.21724.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1820088.1RgZixBAdq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Nick.

On Friday 30 June 2006 02:22, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > Hi.
> >
> > On Tuesday 27 June 2006 16:11, Nick Piggin wrote:
> >>Nigel Cunningham wrote:
> >>>Add paranoia to the page_alloc code to ensure we don't start page
> >>> reclaim during suspending.
> >>
> >>Nack. Set PF_MEMALLOC if you must.
> >
> > That would work for the thread doing the suspending. What about other
> > kernel threads that might run and allocate memory during the cycle
> > because of $RANDOM_EVENT? We don't want them triggering memory freeing
> > either.
>
> Haven't you suspended the other threads at this point?

Userspace is frozen, but kernel threads are still running. I'm therefore=20
thinking of allocation of memory by drivers while we're writing the first=20
part of the image (prior to the atomic copy).

> What are the consequences of allocating memory?

My concern isn't with them allocating any memory, but with the memory=20
allocation routines trying to enter the vmscan.c routines to free memory.=20
This would almost certainly free some of the LRU pages we're saving=20
separately prior to the atomic copy, resulting in an inconsistent image and=
=20
crashes and/or on disk corruption post resume. I've recently seen Rafael's=
=20
code to take pages off the LRU, and realise that may be a better solution,=
=20
but am not sure what adverse side effects it has.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1820088.1RgZixBAdq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEpFD5N0y+n1M3mo0RAhs4AJ4iMHOFY5MnMg/Br/Xqw4bSpeOdeACgstqC
YGyIxO23o7JJQ/8tYJt0r1w=
=OHXz
-----END PGP SIGNATURE-----

--nextPart1820088.1RgZixBAdq--

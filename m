Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUCPLs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 06:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbUCPLs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 06:48:26 -0500
Received: from ns.suse.de ([195.135.220.2]:1701 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261187AbUCPLsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 06:48:23 -0500
Date: Tue, 16 Mar 2004 12:48:20 +0100
From: Kurt Garloff <garloff@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bonus inheritance
Message-ID: <20040316114820.GM4452@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Nick Piggin <piggin@cyberone.com.au>,
	Con Kolivas <kernel@kolivas.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040315225459.GY4452@tpkurt.garloff.de> <405696A9.3060304@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6JKsAUbrJhuSllgx"
Content-Disposition: inline
In-Reply-To: <405696A9.3060304@cyberone.com.au>
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6JKsAUbrJhuSllgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Tue, Mar 16, 2004 at 04:54:49PM +1100, Nick Piggin wrote:
> Does it help any actual interactivity problem? Unfortunately
> practically any you make to the scheduler is bound to make
> things worse for at least one person, so it is difficult to
> just test things out.

Well, the interactivity problems existed with O(1) in 2.4.
The 50% penalty hurt freshly started processes a lot.

To fix this, the penalty has been set to 95 (5% penalty)
in 2.6.
I believe it's cleaner to draw the bonus towards the average=20
and inherit a percentage, and thus I set a inheritance percentage=20
of 50 in 2.4.

It was successful in 2.4. In a measurable way.

In 2.6, it likely will not make a big difference as with giving=20
95% of the bonus, you don't change much ...

So it's more a question of have the concept in there which is
clearer. More a theoretical thing. Assuming that with 95% chance
your child has the same character w.r.t. to interactiveness is
rather high.

It will be very hard to measure 80% inheritance to 95% penalty=20
as for the most important case (starting a process from a shell),=20
the results are almost the same.

The fact that we are more likely to start new processes towards=20
the center in our bonus scale certainly makes it faster for the
scheduler to put them in the right category, so there should be
some benefit w.r.t. interactiveness. However, those are not easy=20
to measure :-(

I'll see whether we can get some benchmarks anyway.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--6JKsAUbrJhuSllgx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVumExmLh6hyYd04RAmePAJ0StpcH+fcq8FrJvTyCSicAHzrclwCeIxz2
iRH66W03td0RD9xVkrVMBaM=
=WnZr
-----END PGP SIGNATURE-----

--6JKsAUbrJhuSllgx--

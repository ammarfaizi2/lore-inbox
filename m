Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTKNEkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 23:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTKNEkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 23:40:40 -0500
Received: from dialin-212-144-178-115.arcor-ip.net ([212.144.178.115]:384 "EHLO
	dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S262164AbTKNEkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 23:40:39 -0500
Date: Fri, 14 Nov 2003 05:40:38 +0100
From: Thunder Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] VC (keyboard) doesn't clean up its buffers
Message-ID: <20031114044038.GA940@dbintra.dmz.lightweight.ods.org>
References: <20031112225624.GA922@dbintra.dmz.lightweight.ods.org> <Pine.LNX.4.44.0311130033390.20527-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311130033390.20527-100000@gaia.cela.pl>
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
X-Location: Dorndorf-Steudnitz, TH (Germany)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

> tty->filp.char_buf  is filled  correctly by  my typings.  The buffer
> state goes  up, and once I've  typed 255 characters,  of course it's
> full.  *But*  the big  deal  with  the  keyboard buffer  is  usually
> somebody who's reading  out the contents and processing  it, so that
> the  characters  I  typed  are  processed.   This  is  *not*  taking
> place. The buffer just fills up and there we are.

I've explored  the kernel stack a  bit using SysRq hacks,  and I found
out that this misbehavior was in  fact caused by ISDN. It added a work
for  "isac_bh()" into  the CPU  workqueue with  list heads  inited, so
every time the work got executed, execution looped, and since ISDN was
loaded before  I typed the first character,  the flush_to_ldisc() work
was never run. I'm going to fix that bug soon.

				Thunder

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tFzGygQNIN66kP8RAij0AKCsq9c0xH8q5SCjdzMsk9NIjhEKFACfZomu
AqyZM/IGow9ApG5o+kPukUE=
=vDJO
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

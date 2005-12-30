Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVL3BRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVL3BRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 20:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVL3BRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 20:17:17 -0500
Received: from mail.autoweb.net ([198.172.237.26]:37295 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751190AbVL3BRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 20:17:16 -0500
Message-ID: <43B48A8C.8000708@michonline.com>
Date: Thu, 29 Dec 2005 20:17:00 -0500
From: Ryan Anderson <ryan@michonline.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla <alejandro.bonilla@hp.com>
CC: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: git fetching
References: <43B48516.2030701@hp.com> <20051230010151.GC12822@redhat.com>
In-Reply-To: <20051230010151.GC12822@redhat.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF9C9155B788127E8B16E5DF0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9C9155B788127E8B16E5DF0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dave Jones wrote:
> On Thu, Dec 29, 2005 at 06:53:42PM -0600, Alejandro Bonilla wrote:
>  > Why is it that when I git fetch, this particular part takes a long time?
>  > 
>  > pack/pack-2dae6bb81ac4383926b1d6a646e3f73b130ba124.pack
>  > 
>  > Normally, they go pretty fast, but when a new rc or final releases comes 
>  > up, it takes a lot.
> 
> That file is ~100MB. That'll take a while to download compared to the rest,
> even on the fastest net connection :)

If you're carrying around a mostly current tree, you should probably not
use "rsync" (which is probably why you're seeing that pack line)

Run this:
	sed -i.old -e 's/rsync/git/' .git/remotes/origin
and your pulls should go significantly faster.

(The file named "origin" might be in .git/branches/, also.)

You want the file to contain pretty much just this line:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Also, out of curiosity, do:
	du -sh .git/objects/ .git/objects/pack/

You shouldn't see a .git/objects/pack/ much greater than 200 meg, in
fact, on freshly cloned tree it would only be about 100 meg:

http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/

-- 

Ryan Anderson
  sometimes Pug Majere

--------------enigF9C9155B788127E8B16E5DF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDtIqQfhVDhkBuUKURAvsrAKDZ13uyZ+1Wq22mFVzkxteRJLLF9gCfT3Dc
ohYVEqenBz3OPxty+lRirZY=
=MnLm
-----END PGP SIGNATURE-----

--------------enigF9C9155B788127E8B16E5DF0--

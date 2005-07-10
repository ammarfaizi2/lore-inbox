Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVGJUJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVGJUJD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVGJUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 16:08:52 -0400
Received: from smtp2.oregonstate.edu ([128.193.4.8]:3528 "EHLO
	smtp2.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262107AbVGJUGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 16:06:54 -0400
Message-ID: <42D17FCD.20702@engr.orst.edu>
Date: Sun, 10 Jul 2005 13:06:37 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
References: <42C9A69A.5050905@waychison.com> <200507041705.17626.dtor_core@ameritech.net> <42CB63AD.4070208@engr.orst.edu> <200507100136.49735.dtor_core@ameritech.net> <42D0D669.1010706@engr.orst.edu> <20050710122118.GA3174@ucw.cz>
In-Reply-To: <20050710122118.GA3174@ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE7AED98AC6DA223151857845"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE7AED98AC6DA223151857845
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:
> On Sun, Jul 10, 2005 at 01:03:53AM -0700, Micheal Marineau wrote:
> 
> 
>>Yey! fixed it, simple little patch, just updates the alps_model_info
>>struct. Here's a link so my mail client won't mess up the white space:
>>http://dev.gentoo.org/~marineam/files/alps-dell8500-dualpoint.patch
>>
>>(note, this sill requires the alps-suspend-typo fix)
> 
> 
> It's hard to believe your patch
> 
> --- linux-2.6.12-suspend2.orig/drivers/input/mouse/alps.c	2005-07-07 23:50:48.000000000 -0700
> +++ linux-2.6.12-suspend2/drivers/input/mouse/alps.c	2005-07-10 00:51:36.000000000 -0700
> @@ -48,1 +48,1 @@
> -	{ { 0x63, 0x03, 0xc8 }, 0xf8, 0xf8, ALPS_PASS },		/* Dell Latitude D800 */
> +	{ { 0x63, 0x03, 0xc8 }, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D800, Inspiron 8500 */
> 
> can fix it, because the ALPS_DUALPOINT constant doesn't affect the
> initalization behavior at all, only the way how TouchPoint data are
> decoded. 
> 

I don't really understand what's going on with that.  It's not the root
issue for sure, just now after a run of about 15 suspends the mouse
finally capped out. Somehow that made it slightly more reliable? Or it
was just dumb luck that I couldn't reproduce it yesterday, but I managed
to do it once today.

My best guess is that something more needs to be done to priv->dev2 to
make sure it initilizes properly but I don't know what, I'm having some
difficulty understanding the alps driver.

But it could be something independent of resume, I have a gentoo user
with another inspiron 8500 who says even with 2.6.12, the dualpoint
stick doesn't initilize a lot of the time even on boot.

-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enigE7AED98AC6DA223151857845
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC0X/XiP+LossGzjARAnkfAJ43ix38JnQsdTYWqK4dhDs7ZqeseACeJYys
fff8EQ/U8kKtTbpRpeoFrNw=
=lA8o
-----END PGP SIGNATURE-----

--------------enigE7AED98AC6DA223151857845--

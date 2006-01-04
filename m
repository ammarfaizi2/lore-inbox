Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965314AbWADWnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbWADWnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWADWne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:43:34 -0500
Received: from mail.autoweb.net ([198.172.237.26]:29415 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S965311AbWADWnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:43:33 -0500
Message-ID: <43BC4F86.1050401@michonline.com>
Date: Wed, 04 Jan 2006 17:43:18 -0500
From: Ryan Anderson <ryan@michonline.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git in scripts/setlocalversion
References: <20060104194203.GA2359@lsrfire.ath.cx>
In-Reply-To: <20060104194203.GA2359@lsrfire.ath.cx>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig828D01C4FC003D8F6960B38B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig828D01C4FC003D8F6960B38B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Rene Scharfe wrote:
> Currently scripts/setlocalversion is a Perl script that tries to figure
> out the current git commit ID of a repo without using git.  It also
> imports Digest::MD5 without using it and generally is too big for the
> small task it does. :]  And it always reports a git ID, even when the
> HEAD is tagged -- this is a bug.

Yes.  I'm pretty sure I sent Sam a patch for that at one point ages ago,
but I've been distracted and haven't updated it recently.

I think using git-name-rev --tags as this change does is a lot simpler
than what I was trying to do.

So, Sam, if you'd prefer this version, feel free, or let me know and
I'll resend the one or two patches I have hanging around to you.

> This patch replaces it with a Bourne Shell script that uses git
> commands to do the same.  I can't come up with a scenario where someone
> would use a git repo and refuse to install git core at the same time,
> so I think it's reasonable to assume git is available.
> 
> The new script also reports uncommitted changes by adding -git_dirty to
> the version string.  Obviously you can't see from that _what_ has been
> changed from the last commit, so it's more of a reminder that you
> forgot to commit something.

And this is a decent feature, too. I like it.

The only reservation I have about converting from Perl to Bourne shell
is that if adding support for, say, Mercurial (or maybe CVS, etc) wants
to mangle it somehow, via say MD5, that becomes a little bit more
difficult to do, or at worst, introduces an additional dependency on
something like md5sum.

So, I like it:

Signed-off-by: Ryan Anderson <ryan@michonline.com>


--------------enig828D01C4FC003D8F6960B38B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDvE+MfhVDhkBuUKURAqqXAKCRswNubgNO6OqgQe7udl6png0MEACgqoi4
o1SVF22JYMg1mfB8fbmXgug=
=CJOC
-----END PGP SIGNATURE-----

--------------enig828D01C4FC003D8F6960B38B--

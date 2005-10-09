Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVJIHPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVJIHPO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 03:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVJIHPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 03:15:14 -0400
Received: from h80ad2494.async.vt.edu ([128.173.36.148]:46044 "EHLO
	h80ad2494.async.vt.edu") by vger.kernel.org with ESMTP
	id S932228AbVJIHPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 03:15:12 -0400
Message-Id: <200510090714.j997Ek2i032551@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: webmaster@kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, security@kernel.org
Subject: Re: "stable" vs "security stable" 
In-Reply-To: Your message of "Sun, 09 Oct 2005 14:07:19 +0800."
             <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128842085_2743P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Oct 2005 03:14:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128842085_2743P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Oct 2005 14:07:19 +0800, Coywolf Qi Hunt said:
> Hello,
> 
> I find the kernel.org first page inconvenient for some people somehow
> since the security stable came.

Unfortunately, it's a "stable", not "security stable" release.  Although
a large proportion of the fixes are security-related, the aren't *all*
security - there's also the occasional brown-bag bug or unexpected side
effect that simply causes incorrect operation of the kernel.

Having said that, Coywolf *is* right in that it's a bit unclear that
you have to fetch the 'F'(ull) 2.6.13.3, then get the patch, put that
on with patch -R to get a 2.6.13 tree, and then apply the 2.6.14-rc3 patch.
(Although if you realize that 14-rc3 is diffed off 13.0, not 13.3, it's not
that bad at all)...

I admit being torn between encouraging more people to try -rc kernels, and
wanting to enforce a minimum clue level on those trying to do so....

Hmm.. what if we did something like this:

diff -rup linux-2.6.13/dot.release linux-2.6.13.3/dot.release
--- linux-2.6.13/dot.release    2005-10-09 03:09:54.000000000 -0400
+++ linux-2.6.13.3/dot.release  2005-10-09 03:12:02.000000000 -0400
@@ -1,2 +1,2 @@
-This is a base release 2.6.13.  Stable patches, 2.6.14-rc patches,
-and the final 2.6.14 patch should be applied to this.
+This is a dot release. You need to patch -R the .3 patch before
+attempting to apply a .14-rc or .14 patch.

And then build the 14-rc3 patch:

diff -rup linux-2.6.13/dot.release linux-2.6.14-rc3/dot.release
--- linux-2.6.13/dot.release    2005-10-09 03:09:54.000000000 -0400
+++ linux-2.6.14-rc3/dot.release        2005-10-09 03:03:40.000000000 -0400
@@ -1,2 +1,3 @@
-This is a base release 2.6.13.  Stable patches, 2.6.14-rc patches,
-and the final 2.6.14 patch should be applied to this.
+This is a 14-rc3 release.  The patch will bomb out if you try
+to apply it to anything other than a 2.6.13.0 tree.  Did you
+remember to 'patch -R' any 2.6.13.N 'stable' patch first?

Now if we arrange for that to be the first diff in the patchfile, and
they get it wrong, they'll see:

% patch -p1 < 2.6.14-rc3.patch 
patching file dot.release
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file dot.release.rej
% cat dot.release.rej 
***************
*** 1,2 ****
- This is a base release 2.6.13.  Stable patches, 2.6.14-rc patches,
- and the final 2.6.14 patch should be applied to this.
--- 1,3 ----
+ This is a 14-rc3 release.  The patch will bomb out if you try
+ to apply it to anything other than a 2.6.13.0 tree.  Did you
+ remember to 'patch -R' any 2.6.13.N 'stable' patch first?

(OK, it's a silly 3AM idea. ;)

--==_Exmh_1128842085_2743P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDSMNlcC3lWbTT17ARArk3AKDsVtWFhgbQZgoku08Rxft2vR+oWwCeNl69
xTL0yIXbuj+EI2QRNKt9m8Q=
=GulJ
-----END PGP SIGNATURE-----

--==_Exmh_1128842085_2743P--

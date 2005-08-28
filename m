Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVH1HbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVH1HbX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 03:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVH1HbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 03:31:23 -0400
Received: from ns1.osuosl.org ([140.211.166.130]:23956 "EHLO ns1.osuosl.org")
	by vger.kernel.org with ESMTP id S1750792AbVH1HbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 03:31:22 -0400
Message-ID: <43116835.4030108@engr.orst.edu>
Date: Sun, 28 Aug 2005 00:31:01 -0700
From: Michael Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050728)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manuel Lauss <mano@roarinelk.homelinux.net>
CC: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/3] Radeon acpi vgapost only Rv250 (M9)
References: <43111298.80507@engr.orst.edu> <43115FC2.30309@roarinelk.homelinux.net>
In-Reply-To: <43115FC2.30309@roarinelk.homelinux.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA71B1BA70C6B20F953453ECA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA71B1BA70C6B20F953453ECA
Content-Type: multipart/mixed;
 boundary="------------050306060203070703070605"

This is a multi-part message in MIME format.
--------------050306060203070703070605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Manuel Lauss wrote:
> Michael Marineau wrote:
> 
>> Thses patches resume ATI radeon cards from acpi S3 suspend when using
>> radeonfb by reposting the video bios. This is needed to be able to use
>> S3 when the framebuffer is enabled.
> 
> 
> These patches break resume from S3 for me. On a vanilla kernel,
> radeonfb comes back fine, with your patches applied, the backlight
> gets turned on (by BIOS I think) and shortly afterwards its turned off
> for good. (Radeon M11 on Sony Vaio)
> 
Ok, attached is a patch to only attempt a vga post on Rv250 cards (M9)
which I have in my laptop.  I'm guessing cards older than M9 might also
be helped with this patch, but better to be conservative than risk
breaking systems that do work properly.
-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------050306060203070703070605
Content-Type: text/x-patch;
 name="radeonfb-only-post-R250.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb-only-post-R250.patch"

Index: linux-2.6.13-rc7/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-2.6.13-rc7.orig/drivers/video/aty/radeon_pm.c
+++ linux-2.6.13-rc7/drivers/video/aty/radeon_pm.c
@@ -2790,7 +2790,8 @@ void radeonfb_pm_init(struct radeonfb_in
 #endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_X86)
-	if (rinfo->is_mobility && rinfo->pm_reg) {
+	if (rinfo->is_mobility && rinfo->pm_reg &&
+	     rinfo->family == CHIP_FAMILY_RV250) {
 		rinfo->reinit_func = radeon_reinitialize_vgapost;
 		rinfo->pm_mode |= radeon_pm_post;
 	}

--------------050306060203070703070605--

--------------enigA71B1BA70C6B20F953453ECA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDEWg8iP+LossGzjARAs9NAKCQDP7xeFXbQ2cB3onVoSmWOaxBxwCgqvGD
lKdZieF3FezeHiaXgG+puBA=
=9HFS
-----END PGP SIGNATURE-----

--------------enigA71B1BA70C6B20F953453ECA--

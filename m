Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264327AbUD0UTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbUD0UTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUD0UTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:19:04 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:12421 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264327AbUD0UTA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:19:00 -0400
Message-Id: <200404272018.i3RKIgoF020652@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: koke@sindominio.net
Cc: linux-kernel@vger.kernel.org, Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license 
In-Reply-To: Your message of "Tue, 27 Apr 2004 21:41:51 +0200."
             <200404272141.51222.koke_lkml@amedias.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040427165819.GA23961@valve.mbsi.ca> <200404272103.21925.koke_lkml@amedias.org> <Pine.LNX.4.58.0404272113110.9618@alpha.polcom.net>
            <200404272141.51222.koke_lkml@amedias.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1935316254P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Apr 2004 16:18:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1935316254P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Apr 2004 21:41:51 +0200, "Jorge Bernal (Koke)" said:

> 2 ideas:
> 
> Printing if the tainted module is loaded or unloaded

We already have a message when it's loading, and a message on unload is
superfluous - if I insmod the NVidia driver and then unload it, the kernel is
still tainted by it, because it had a chance to mangle memory while it was
loaded.

And yes, sometimes the damage can be hiding for a LONG time - I know I've seen
bug reports on the list that involved "module A dorked a pointer which wasn't
noticed for 3 days until module B  tried to...."

Would the attached strawman patch make people happ(y|ier)?

--- linux-2.6.6-rc2-mm2/kernel/module.c.orig	2004-04-27 09:56:22.000000000 -0400
+++ linux-2.6.6-rc2-mm2/kernel/module.c	2004-04-27 16:16:59.764158885 -0400
@@ -1131,7 +1131,7 @@ static void set_license(struct module *m
 
 	mod->license_gplok = license_is_gpl_compatible(license);
 	if (!mod->license_gplok) {
-		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
+		printk(KERN_NOTICE "%s: module license '%s' taints kernel.\n",
 		       mod->name, license);
 		tainted |= TAINT_PROPRIETARY_MODULE;
 	}



--==_Exmh_-1935316254P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAjsAicC3lWbTT17ARAgMoAKDkJmRN4sLtTOgwN2NzhYddHD9KfQCgoYtH
KL3UbU1m5aPOOWptsar/q4k=
=knhu
-----END PGP SIGNATURE-----

--==_Exmh_-1935316254P--

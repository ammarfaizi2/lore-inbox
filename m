Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUFXHjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUFXHjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 03:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUFXHjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 03:39:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15598 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263984AbUFXHjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 03:39:23 -0400
Date: Thu, 24 Jun 2004 09:38:59 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Allow root to choose vfat policy to UTF8
Message-ID: <20040624073858.GA17435@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Right now the kernel detects the sysadmin trying to set the iocharset of
vfat to UTF8 and prevents this with an error. While I can see that this is
not recommended, enforcing this is policy that probably doesn't belong in
the kernel. The patch below makes this situation a warning and a
recommendation instead of a strong blockage.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=126641

is an example of a sysadmin disliking this policy enforcement.

Greetings,
    Arjan van de Ven

--- linux-2.6.7/fs/fat/inode.c~	2004-06-24 11:20:43.941750760 +0200
+++ linux-2.6.7/fs/fat/inode.c	2004-06-24 11:20:43.943750521 +0200
@@ -499,9 +499,8 @@
 	}
 	/* UTF8 doesn't provide FAT semantics */
 	if (!strcmp(opts->iocharset, "utf8")) {
-		printk(KERN_ERR "FAT: utf8 is not a valid IO charset"
-		       " for FAT filesystems\n");
-		return -EINVAL;
+		printk(KERN_ERR "FAT: utf8 is not a recommended IO charset"
+		       " for FAT filesystems, filesystem will be case sensitive!\n");
 	}
 
 	if (opts->unicode_xlate)

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2oUSxULwo51rQBIRAnKNAJ4kv+j4bMnaspV7fUuiF25bAvzvdACfT8qX
Eb8Vb+HVeTi4GLa8QPItAKc=
=twdE
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

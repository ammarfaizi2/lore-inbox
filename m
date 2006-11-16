Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424621AbWKPVN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424621AbWKPVN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424624AbWKPVN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:13:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:25515 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1424621AbWKPVNz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:13:55 -0500
Message-Id: <200611162113.kAGLDrLW024301@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Christian <christiand59@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CIFS close with pending writes
In-Reply-To: Your message of "Wed, 15 Nov 2006 14:29:53 +0100."
             <200611151429.53388.christiand59@web.de>
From: Valdis.Kletnieks@vt.edu
References: <200611151429.53388.christiand59@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163711633_15079P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Nov 2006 16:13:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163711633_15079P
Content-Type: text/plain; charset=us-ascii

On Wed, 15 Nov 2006 14:29:53 +0100, Christian said:

I was hitting this under 2.6.19-rc5-mm1 as well:

> [ 7190.693567] CIFS does not yet support partial page writes on O_WRONLY files

I get that one even without "heavy stressing" - just doing a CIFS mount of
a share from our NetApp and trying to copy a file onto it will trigger
this variant.  'cat /etc/motd >> /mnt/server/my_dir/foo' triggers it.
(changing the shell redirect to '1<>/mnt/server/my_dir/foo' solves THIS one,
and creates the second flavor:

> [ 7190.693600]  CIFS VFS: close with pending writes

Happens every time you close a file after writing anything other than an
exact multiple of 4K.

Some quick testing indicates that this works properly under -rc5-mm2 (in fact,
I didn't report it against -mm1 because when I discovered it the other day, I
already knew -mm2 was out...)


--==_Exmh_1163711633_15079P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFXNSRcC3lWbTT17ARAh70AJ4ndLDpJocqTYNtOXCsb/tJw1mpRACfYxrM
7S0qx9fNC+erGqBp306fW6U=
=qToi
-----END PGP SIGNATURE-----

--==_Exmh_1163711633_15079P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTKQB3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 20:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTKQB3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 20:29:22 -0500
Received: from h80ad25d2.async.vt.edu ([128.173.37.210]:38290 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263281AbTKQB3V (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 20:29:21 -0500
Message-Id: <200311170129.hAH1TELa006720@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reading libs fails through NFS 
In-Reply-To: Your message of "Mon, 17 Nov 2003 01:45:39 +0100."
             <20031117004539.GA2155@werewolf.able.es> 
From: Valdis.Kletnieks@vt.edu
References: <20031117004539.GA2155@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1777407677P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Nov 2003 20:29:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1777407677P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 Nov 2003 01:45:39 +0100, "J.A. Magallon" said:

>     fd = open("/lib/libnss_files.so.2", O_RDONLY);

> The node boots via PXE, with a version of libnss_files.so.2 on the /lib present
> in the initrd, which is replaced by the mounted one.

Just a shot in the dark, but could there be a bug in the NFS code where it's
getting upset that there's cached pages of the file in memory, but the file
that the cached page is from isn't from the file that NFS can see? (note that
this is possibly *different* than a stale NFS handle when a file is unlinked
and then recreated - here chasing the origin of the page doesn't point at
the NFS mount, but at the initrd mount.

Yes, when you mount over a directory, the previous contents are supposed to
become invisible.  I wonder if there's a bug with that if a file is read and
pages cached 'sufficiently early' in the boot process (i.e. before the
real root gets mounted over the initrd root..)

--==_Exmh_-1777407677P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/uCRpcC3lWbTT17ARAsWpAKDsc0vFBxzTsVkxl2bd69dp497MPgCg+Vp/
OgPKgK4nFb5HBnnwR5mY3gM=
=vTaw
-----END PGP SIGNATURE-----

--==_Exmh_-1777407677P--

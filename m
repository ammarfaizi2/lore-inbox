Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUEVOLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUEVOLp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUEVOLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:11:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:20626 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261405AbUEVOKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:10:41 -0400
Date: Sat, 22 May 2004 16:10:36 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease filp size by 8
Message-ID: <20040522141036.GZ4623@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ro1PRY3Rtw8g7IwX"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-12-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ro1PRY3Rtw8g7IwX
Content-Type: multipart/mixed; boundary="C311HLcnHV2CzHlo"
Content-Disposition: inline


--C311HLcnHV2CzHlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

attached patch decreases the size of struct file by 8 bytes on 64 bit
arches by avoiding unecessary padding.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--C311HLcnHV2CzHlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=small-filp
Content-Transfer-Encoding: quoted-printable

diff -uNrp linux-2.6.5/include/linux/fs.h linux-2.6.5.smallstruct/include/l=
inux/fs.h
--- linux-2.6.5/include/linux/fs.h	2004-05-22 13:11:08.000000000 +0200
+++ linux-2.6.5.smallstruct/include/linux/fs.h	2004-05-22 14:32:55.00000000=
0 +0200
@@ -513,8 +513,8 @@ struct fown_struct {
 	rwlock_t lock;          /* protects pid, uid, euid fields */
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
-	int signum;		/* posix.1b rt signal to be delivered on IO */
 	void *security;
+	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
=20
 /*
@@ -542,10 +542,10 @@ struct file {
 	atomic_t		f_count;
 	unsigned int 		f_flags;
 	mode_t			f_mode;
+	int			f_error;
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
 	unsigned int		f_uid, f_gid;
-	int			f_error;
 	struct file_ra_state	f_ra;
=20
 	unsigned long		f_version;

--C311HLcnHV2CzHlo--

--Ro1PRY3Rtw8g7IwX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAr19cxmLh6hyYd04RAjsyAJ9hYCGqP70ncYJ4oM/Mnbp0mF9W2wCdGb/t
qtGB3WbNueOu7O6x4AUbsCA=
=NQp7
-----END PGP SIGNATURE-----

--Ro1PRY3Rtw8g7IwX--

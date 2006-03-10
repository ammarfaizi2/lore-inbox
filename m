Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWCJP4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWCJP4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWCJP4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:56:32 -0500
Received: from ns.suse.de ([195.135.220.2]:7816 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751315AbWCJP4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:56:31 -0500
Date: Fri, 10 Mar 2006 16:57:38 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
Message-ID: <20060310155738.GL5766@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline
X-Operating-System: Linux 2.6.16-rc5-git2-3-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

likely a merge error by patch ... which makes setuid_dumpable
appear in /proc/sys/fs/ rather than kernel/. I assume it belongs
to kernel as the naming suggests.

Patch is against 2.6.16-rc5-git9.

=46rom: Kurt Garloff <garloff@suse.de>
Subject: suid-dumpable ended up in wrong sysctl dir

Diffing in sysctl.c is tricky, using more context is recommended.
suid_dumpable ended up in fs/ instead of kernel/ and the reason
is likely a patch with too little context.

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.15/kernel/sysctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.orig/kernel/sysctl.c
+++ linux-2.6.15/kernel/sysctl.c
@@ -647,12 +647,20 @@ static ctl_table kern_table[] =3D {
 		.data		=3D &randomize_va_space,
 		.maxlen		=3D sizeof(int),
 		.mode		=3D 0644,
 		.proc_handler	=3D &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	=3D KERN_SETUID_DUMPABLE,
+		.procname	=3D "suid_dumpable",
+		.data		=3D &suid_dumpable,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D &proc_dointvec,
+	},
 #if defined(CONFIG_S390) && defined(CONFIG_SMP)
 	{
 		.ctl_name	=3D KERN_SPIN_RETRY,
 		.procname	=3D "spin_retry",
 		.data		=3D &spin_retry,
 		.maxlen		=3D sizeof (int),
@@ -1032,20 +1040,12 @@ static ctl_table fs_table[] =3D {
 		.procname	=3D "inotify",
 		.mode		=3D 0555,
 		.child		=3D inotify_table,
 	},
 #endif=09
 #endif
-	{
-		.ctl_name	=3D KERN_SETUID_DUMPABLE,
-		.procname	=3D "suid_dumpable",
-		.data		=3D &suid_dumpable,
-		.maxlen		=3D sizeof(int),
-		.mode		=3D 0644,
-		.proc_handler	=3D &proc_dointvec,
-	},
 	{ .ctl_name =3D 0 }
 };
=20
 static ctl_table debug_table[] =3D {
 	{ .ctl_name =3D 0 }
 };
--=20
Kurt Garloff, Head Architect Linux, Novell Inc.

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEEaHyxmLh6hyYd04RAoOKAJ9v0yNJpPSljzGV/yKw58P/TTaBIQCeJ+pa
1nkaJipdav3iApr02/QMYs4=
=KedY
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVBMVTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVBMVTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 16:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVBMVSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 16:18:12 -0500
Received: from news.suse.de ([195.135.220.2]:13967 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261312AbVBMVMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 16:12:30 -0500
Date: Sun, 13 Feb 2005 16:12:10 -0500
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] 4/5: LSM hooks rework
Message-ID: <20050213211210.GL27893@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20050213210515.GH27893@tpkurt.garloff.de> <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de> <20050213211139.GK27893@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Content-Disposition: inline
In-Reply-To: <20050213211139.GK27893@tpkurt.garloff.de>
X-Operating-System: Linux 2.6.11-rc3-bk6-20-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Consider the capability case the likely one
References: 40217, 39439

The case that security_ops points to the default capability_
security_ops is the fast path and arguably the more likely one
on most systems. So mark it likely to tell the compiler to
optimize accordingly and increase the chances of having this
predicted correctly by the CPU.

This is patch 4/5 of the LSM overhaul.

 security.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.10/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/include/linux/security.h
+++ linux-2.6.10/include/linux/security.h
@@ -1253,9 +1253,9 @@ extern int mod_reg_security	(const char=20
 extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
=20
 /* Condition for invocation of non-default security_op */
 #define COND_SECURITY(seop, def) 	\
-	(security_ops =3D=3D &capability_security_ops)? def: security_ops->seop
+	(likely(security_ops =3D=3D &capability_security_ops))? def: security_ops=
->seop
=20
 #else /* CONFIG_SECURITY */
 static inline int security_init(void)
 {
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCD8KqxmLh6hyYd04RAgFdAJ9x6Fg4DaqTZnQOTyS+O9xLi1IfuQCgslha
lEuKxn8swiid2ZCWVN5hxyM=
=tBjH
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--

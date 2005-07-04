Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVGDG7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVGDG7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVGDG7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:59:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:17130 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261525AbVGDG7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 02:59:17 -0400
Date: Mon, 4 Jul 2005 08:59:02 +0200
From: Kurt Garloff <garloff@suse.de>
To: Tony Jones <tonyj@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050704065902.GO11093@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Tony Jones <tonyj@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
	Linux LSM list <linux-security-module@wirex.com>
References: <20050703154405.GE11093@tpkurt.garloff.de> <20050703190007.GA30292@immunix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
Content-Disposition: inline
In-Reply-To: <20050703190007.GA30292@immunix.com>
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Vy1A5eXR7jld12ZH
Content-Type: multipart/mixed; boundary="N/GrjenRD+RJfyz+"
Content-Disposition: inline


--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Sun, Jul 03, 2005 at 12:00:07PM -0700, Tony Jones wrote:
> Agree with James, pls resend to linux-security-module@wirex.com.

Done.

> The topic of replacing dummy (with capability) was discussed there
> last week, in the context of stacker, but a common solution for both
> cases would be needed.

Both cases?

> Also, I was going to ask where 4/5 and 5/5 were :-)

They were part of my previous submission attempts as indicated in the
first message [Patch 0/3]. Last time I sent them people were discussing
whether or not we should have this likely/unlikely, so I left this out
this time, as I'd rather prefer discussing the other patches.

Still, the 3% perf. increase measurement that has been done was with
patches 4 and 5, so claiming otherwise would not be right.

> If you are claiming a perf increase it would be nice to get an idea
> what these patches were even though you believe most of the gain was
> in patch #3.

For completeness, find both attached.

Best,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-likely-cap
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Consider the capability case the likely one
References: SUSE40217, SUSE39439

The case that security_ops points to the default capability_
security_ops is the fast path and arguably the more likely one
on most systems. So mark it likely to tell the compiler to
optimize accordingly and increase the chances of having this
predicted correctly by the CPU.

This is patch 4/5 of the LSM overhaul.

 security.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.12/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/include/linux/security.h
+++ linux-2.6.12/include/linux/security.h
@@ -1258,9 +1258,9 @@ extern int mod_reg_security	(const char=20
 extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
=20
 /* Condition for invocation of non-default security_op */
 #  define COND_SECURITY(seop, def) 	\
-	(security_ops =3D=3D &capability_security_ops)? def: security_ops->seop
+	(likely(security_ops =3D=3D &capability_security_ops))? def: security_ops=
->seop
=20
 # else /* CONFIG_SECURITY */
 static inline int security_init(void)
 {

--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-se-enabled
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Test security_enabled var rather than security_ops pointer
References: SUSE40217, SUSE39439

Rather than doing a pointer comparison, test an integer var
for being null. Should be slightly faster.
I consider this patch as optional.

Note that it does not introduce a (new) race, as we still set
the security_ops pointer to the capability_security_ops. So no
wmb() is needed for the module unload case.

Sidenote: A wmb() in the module load and unload cases might
actually be useful to ensure that the other CPUs start using the
new LSM pointer ASAP. It's still racy, but that's by design of
LSM. Introducing locks would hurt performance tremendously.
One could do RCU ... but that's not for this patchset.

This is patch 5/5 of the LSM overhaul.

 include/linux/security.h |    7 ++++---
 security/security.c      |    7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.12/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/include/linux/security.h
+++ linux-2.6.12/include/linux/security.h
@@ -1246,10 +1246,10 @@ struct security_operations {
 };
=20
 /* global variables */
 extern struct security_operations *security_ops;
-/* default security ops */
-extern struct security_operations capability_security_ops;
+/* Security enabled? */
+extern int security_enabled;
=20
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -1258,16 +1258,17 @@ extern int mod_reg_security	(const char=20
 extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
=20
 /* Condition for invocation of non-default security_op */
 #  define COND_SECURITY(seop, def) 	\
-	(likely(security_ops =3D=3D &capability_security_ops))? def: security_ops=
->seop
+	(unlikely(security_enabled))? security_ops->seop: def
=20
 # else /* CONFIG_SECURITY */
 static inline int security_init(void)
 {
 	return 0;
 }
=20
+#  define security_enabled 0
 #  define COND_SECURITY(seop, def) def
 # endif
=20
 # ifdef CONFIG_SECURITY_NETWORK
Index: linux-2.6.12/security/security.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/security/security.c
+++ linux-2.6.12/security/security.c
@@ -21,10 +21,14 @@
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
=20
 /* things that live in dummy.c */
 extern void security_fixup_ops (struct security_operations *ops);
+/* default security ops */
+extern struct security_operations capability_security_ops;
=20
 struct security_operations *security_ops;	/* Initialized to NULL */
+int security_enabled;				/* ditto */
+EXPORT_SYMBOL(security_enabled);
=20
 static inline int verify(struct security_operations *ops)
 {
 	/* verify the security_operations structure exists */
@@ -59,8 +63,9 @@ int __init security_init(void)
 		       "capability_security_ops structure.\n", __FUNCTION__);
 		return -EIO;
 	}
=20
+	security_enabled =3D 0;
 	security_ops =3D &capability_security_ops;
=20
 	/* Initialize compiled-in security modules */
 	do_security_initcalls();
@@ -91,8 +96,9 @@ int register_security(struct security_op
 	if (security_ops !=3D &capability_security_ops)
 		return -EAGAIN;
=20
 	security_ops =3D ops;
+	security_enabled =3D 1;
=20
 	return 0;
 }
=20
@@ -115,8 +121,9 @@ int unregister_security(struct security_
 		       "registered, failing.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20
+	security_enabled =3D 0;
 	security_ops =3D &capability_security_ops;
=20
 	return 0;
 }

--N/GrjenRD+RJfyz+--

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyN42xmLh6hyYd04RAjkJAJ406HCB91X7MDesAiWVq5YQvyOOcgCgmOS5
Fc+A4YiJhxenECcb9aupPQ8=
=n3GQ
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--

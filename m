Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVE0Dbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVE0Dbe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 23:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVE0Dbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 23:31:34 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.37]:43653 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261612AbVE0Db2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 23:31:28 -0400
Date: Fri, 27 May 2005 06:31:26 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org,
       dhowells@redhat.com
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE
Message-ID: <20050527033126.GH1329@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Blaisorblade <blaisorblade@yahoo.it>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org,
	dhowells@redhat.com
References: <20050527003843.433BA1AEE88@zion.home.lan> <200505270306.09425.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <200505270306.09425.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 27, 2005 at 03:06:09AM +0200, Blaisorblade wrote:
> On Friday 27 May 2005 02:38, blaisorblade@yahoo.it wrote:
> > After porting this fixlet to UML:
> >
> > http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbD=
YKQ
> >
> > , I've also added a warning which should refuse compilation with insane
> > values for PREEMPT_ACTIVE... maybe we should simply move PREEMPT_ACTIVE=
 out
> > of architectures using GENERIC_IRQS.
> Ok, a grep shows that possible culprits (i.e. giving success to
> grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as PREEMPT_ACTI=
VE,=20
> as given by grep PREEMPT_ACTIVE include/asm-*/thread_info.h) are (at a fi=
rst=20
> glance): frv, sh, sh64.
>=20
Yeah, that's bogus for sh and sh64 anyways, this should do it.

It would be nice to move PRREMPT_ACTIVE so it isn't per-arch anymore,
there's not many users that use a different value (at least for the ones
using generic hardirqs, ia64 seems to be the only one?).

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

include/asm-sh/thread_info.h: needs update
include/asm-sh64/thread_info.h: needs update
Index: include/asm-sh/thread_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/asm-sh/thread_info.h  =
(mode:100644)
+++ uncommitted/include/asm-sh/thread_info.h  (mode:100644)
@@ -27,7 +27,7 @@
=20
 #endif
=20
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
=20
 /*
  * macros/functions for gaining access to the thread information structure
Index: include/asm-sh64/thread_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/asm-sh64/thread_info.h=
  (mode:100644)
+++ uncommitted/include/asm-sh64/thread_info.h  (mode:100644)
@@ -73,7 +73,7 @@
=20
 #define THREAD_SIZE  8192
=20
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
=20
 /* thread information flags */
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFClpSO1K+teJFxZ9wRAhOsAJ4jDX5P0S399mCyFkC//eCvA0sGiwCdEbO2
RWarcPqTuVfLRAfL6nGV0RU=
=Tp0k
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVELIuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVELIuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVELIsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:48:46 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:5664
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261348AbVELIqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:46:36 -0400
Message-Id: <s28325fb.011@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:46:49 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] adjust per_cpu definition in non-SMP case
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part57749BE9.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part57749BE9.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Fix (in the architectures I'm actually building for) the UP definition of
per_cpu so that the cpu specified may be any expression, not just an
identifier or a suffix expression.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/include/asm-generic/percpu.h linux-2.6.12-=
rc4/include/asm-generic/percpu.h
--- linux-2.6.12-rc4.base/include/asm-generic/percpu.h	2005-03-02 =
08:37:50.000000000 +0100
+++ linux-2.6.12-rc4/include/asm-generic/percpu.h	2005-03-15 =
14:40:12.000000000 +0100
@@ -29,7 +29,7 @@ do {								=
\
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
=20
-#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##v=
ar))
+#define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__#=
#var))
 #define __get_cpu_var(var)			per_cpu__##var
=20
 #endif	/* SMP */
diff -Npru linux-2.6.12-rc4.base/include/asm-ia64/percpu.h linux-2.6.12-rc4=
/include/asm-ia64/percpu.h
--- linux-2.6.12-rc4.base/include/asm-ia64/percpu.h	2005-03-02 =
08:38:17.000000000 +0100
+++ linux-2.6.12-rc4/include/asm-ia64/percpu.h	2005-03-15 14:40:12.0000000=
00 +0100
@@ -50,7 +50,7 @@ extern void *per_cpu_init(void);
=20
 #else /* ! SMP */
=20
-#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##v=
ar))
+#define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__#=
#var))
 #define __get_cpu_var(var)			per_cpu__##var
 #define per_cpu_init()				(__phys_per_cpu_start)
=20
diff -Npru linux-2.6.12-rc4.base/include/asm-x86_64/percpu.h linux-2.6.12-r=
c4/include/asm-x86_64/percpu.h
--- linux-2.6.12-rc4.base/include/asm-x86_64/percpu.h	2005-03-02 =
08:38:13.000000000 +0100
+++ linux-2.6.12-rc4/include/asm-x86_64/percpu.h	2005-03-15 =
15:19:44.000000000 +0100
@@ -39,7 +39,7 @@ extern void setup_per_cpu_areas(void);
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
=20
-#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##v=
ar))
+#define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__#=
#var))
 #define __get_cpu_var(var)			per_cpu__##var
=20
 #endif	/* SMP */



--=__Part57749BE9.0__=
Content-Type: text/plain; name="linux-2.6.12-rc4-percpu.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-percpu.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Fix (in the architectures I'm actually building for) the UP definition of
per_cpu so that the cpu specified may be any expression, not just an
identifier or a suffix expression.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/include/asm-generic/percpu.h linux-2.6.12-rc4/include/asm-generic/percpu.h
--- linux-2.6.12-rc4.base/include/asm-generic/percpu.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc4/include/asm-generic/percpu.h	2005-03-15 14:40:12.000000000 +0100
@@ -29,7 +29,7 @@ do {								\
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
-#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
+#define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
diff -Npru linux-2.6.12-rc4.base/include/asm-ia64/percpu.h linux-2.6.12-rc4/include/asm-ia64/percpu.h
--- linux-2.6.12-rc4.base/include/asm-ia64/percpu.h	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.12-rc4/include/asm-ia64/percpu.h	2005-03-15 14:40:12.000000000 +0100
@@ -50,7 +50,7 @@ extern void *per_cpu_init(void);
 
 #else /* ! SMP */
 
-#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
+#define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
 #define per_cpu_init()				(__phys_per_cpu_start)
 
diff -Npru linux-2.6.12-rc4.base/include/asm-x86_64/percpu.h linux-2.6.12-rc4/include/asm-x86_64/percpu.h
--- linux-2.6.12-rc4.base/include/asm-x86_64/percpu.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc4/include/asm-x86_64/percpu.h	2005-03-15 15:19:44.000000000 +0100
@@ -39,7 +39,7 @@ extern void setup_per_cpu_areas(void);
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
-#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
+#define per_cpu(var, cpu)			(*((void)(cpu), &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */

--=__Part57749BE9.0__=--

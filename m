Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292893AbSCEJbj>; Tue, 5 Mar 2002 04:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCEJb3>; Tue, 5 Mar 2002 04:31:29 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:39439 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S292893AbSCEJbM>;
	Tue, 5 Mar 2002 04:31:12 -0500
Date: Tue, 5 Mar 2002 12:34:42 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] EXPORT_SYMBOL(i8253_lock) in arch/i386/kernel/time.c
Message-ID: <20020305093302.GA283@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.6-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: multipart/mixed; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

in arch/i386/kernel/time.c (2.5.6-pre2) we make EXPORT_SYMBOL(i8253_lock), =
but
	- linux/module.h isn't included in time.c;
	- time.o isn't declared as export-objs in Makefile.

So we have theses warnings during kernel compilation:
 time.c:118: warning: type defaults to `int' in declaration of `EXPORT_SYMB=
OL'
 time.c:118: warning: parameter names (without types) in function declarati=
on
 time.c:118: warning: data definition has no type or storage class

Attached patch fixes these buglets, please consider applying.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-time-export-symbol
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff /linux/arch/i386/kernel/Makefile /root/lin=
ux/arch/i386/kernel/Makefile
--- /linux/arch/i386/kernel/Makefile	Wed Jan 30 00:58:18 2002
+++ /root/linux/arch/i386/kernel/Makefile	Mon Mar  4 22:07:12 2002
@@ -14,7 +14,7 @@
=20
 O_TARGET :=3D kernel.o
=20
-export-objs     :=3D mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     :=3D mca.o mtrr.o msr.o cpuid.o microcode.o time.o i386_ks=
yms.o
=20
 obj-y	:=3D process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -urN -X /usr/share/dontdiff /linux/arch/i386/kernel/time.c /root/linux=
/arch/i386/kernel/time.c
--- /linux/arch/i386/kernel/time.c	Thu Jan 31 23:16:50 2002
+++ /root/linux/arch/i386/kernel/time.c	Mon Mar  4 22:01:43 2002
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/module.h>
=20
 #include <asm/io.h>
 #include <asm/smp.h>

--+xNpyl7Qekk2NvDX--

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8hJEyBm4rlNOo3YgRAl4BAJ42xTSZazfGU59hhvmm12/ljayJLgCeNzff
6bHQItO94+upM4YGsfIMu84=
=XvuU
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--

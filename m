Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTEJCdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 22:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbTEJCdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 22:33:15 -0400
Received: from adsl-66-141-42-79.dsl.austtx.swbell.net ([66.141.42.79]:44672
	"EHLO dragon.taral.net") by vger.kernel.org with ESMTP
	id S261873AbTEJCdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 22:33:13 -0400
Date: Fri, 9 May 2003 21:45:44 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [BK PATCH] __verify_write brokenness
Message-ID: <20030510024544.GA1561@taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looks like the recent access_ok fixes broke building of i386.
__verify_write is still referenced in a couple places.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


ChangeSet@1.1096, 2003-05-09 21:37:04-05:00, taral@dragon.taral.net
  Remove remaining references to __verify_write


 arch/i386/kernel/i386_ksyms.c |    3 ---
 include/asm-i386/uaccess.h    |    2 --
 2 files changed, 5 deletions(-)


diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Fri May  9 21:44:01 2003
+++ b/arch/i386/kernel/i386_ksyms.c	Fri May  9 21:44:01 2003
@@ -73,9 +73,6 @@
 #ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
 #endif
-#ifndef CONFIG_X86_WP_WORKS_OK
-EXPORT_SYMBOL(__verify_write);
-#endif
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_extended_fpu);
diff -Nru a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	Fri May  9 21:44:01 2003
+++ b/include/asm-i386/uaccess.h	Fri May  9 21:44:01 2003
@@ -42,8 +42,6 @@
 } ____cacheline_aligned_in_smp movsl_mask;
 #endif
=20
-int __verify_write(const void *, unsigned long);
-
 #define __addr_ok(addr) ((unsigned long)(addr) < (current_thread_info()->a=
ddr_limit.seg))
=20
 /*

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


M'XL( '%GO#X  \55VV[30!!]SG[%2GU$MF?VXIL45&@12" 1!?4)H6B[7B=3D6
M8KO:=3D5HJ^>.[-=3D"$BL10BK#]L-ZQS\R<,\<^H1?.V'S2*:LVY(2^:UV73PJK
MEFT3#IMA8SH?F+>M#T1;9R-G=3D;2IFNW7@(62^-A,=3D7I%KXUU^01#_K#3W5Z9
M?#)_\_;BPZLY(=3D,I/5NI9FD^F8Y.IZ1K[;7:%.Y4=3D:O-?3JK&E>;3H6ZK?N'
M1WL&P/PI,>$@XQYC$$FOL4!4 DT!3*2QV*%=3DF6:YK8[">1S(&#(!<0^(".2<
M8HB0Q11X!#*"C#+,>9*#"$#F '3@XO0Q,?0%HP&0U_1Y>SDCFLY-W5X;:DVM
MJJ9JEGY5&FL:;9S/1A<+SW=3D5WBYN;-49\I[*&,AL1S )_O @!!20ER.=3D5(W>
M; L3*5<'%4_C:*NTK\B%J_W6,B%ZR05"+T4A$HZRT&5<RHP?X'$$UW.%'ITC
M9CT(1#9:I[)Z%0U :V,;LQG6B[6[K5VH]TH5P+"721JG?9J4I;Y,%5=3D2\DMV
ML-11Z/UJN;\5P^@??6W<#L_0$%'KJ_JTJ):FO8?\_"/AE]]I2: $CH"BYS+A
M<C",9#_;!7/,1NP"-.#_UB[?3?)+CWQ3XR,-[,UP^:F?'1?F"38Z3V+*!\D/
M#_6XWG]KM,-BCUH-4H^=3D2M%#&K-T4)K)IRC-_I_2PT?BD=3D"'&W^*RD)2MOOY
6Z971:[>MIX JP4PK<@=3D<#^Z-6@<    =20
=20
--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Most parents have better things to do with their time than take care of
their children." -- Me

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vGfYoQQF8xCPwJQRAt1zAJ45I6Ms3CFHi2TT+eIigTJ4Vwgf6wCeLCna
RnQwD6HixzS7PgEfbhDQgfs=
=jc/F
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

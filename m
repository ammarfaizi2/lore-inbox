Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSJKBWx>; Thu, 10 Oct 2002 21:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSJKBWx>; Thu, 10 Oct 2002 21:22:53 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:56289 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262250AbSJKBWw>; Thu, 10 Oct 2002 21:22:52 -0400
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15782.10671.966729.985443@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 11 Oct 2002 10:30:23 +0900
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Removal of *user_ret macros
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a janitor patch to remove some of the remaining *user_ret
macros that were missed.  I am told the ones in parisc have already
been fixed and are waiting a merge.  This patch was done against 2.5
bk current, but it will apply to 2.4 as well.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.747, 2002-10-10 18:00:45+09:00, steve@sofia.bsd2.kbnes.nec.co.jp
  Janitor clean up.  Macros containing return statements are evil.
  


 uaccess.h |   24 ------------------------
 1 files changed, 24 deletions(-)


diff -Nru a/include/asm-cris/uaccess.h b/include/asm-cris/uaccess.h
--- a/include/asm-cris/uaccess.h	Thu Oct 10 18:03:41 2002
+++ b/include/asm-cris/uaccess.h	Thu Oct 10 18:03:41 2002
@@ -147,25 +147,6 @@
 #define __put_user(x,ptr) \
   __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
 
-/*
- * The "xxx_ret" versions return constant specified in third argument, if
- * something bad happens. These macros can be optimized for the
- * case of just returning from the function xxx_ret is used.
- */
-
-#define put_user_ret(x,ptr,ret) \
-	do { if (put_user(x,ptr)) return ret; } while (0)
-
-#define get_user_ret(x,ptr,ret) \
-	do { if (get_user(x,ptr)) return ret; } while (0)
-
-#define __put_user_ret(x,ptr,ret) \
-	do { if (__put_user(x,ptr)) return ret; } while (0)
-
-#define __get_user_ret(x,ptr,ret) \
-	do { if (__get_user(x,ptr)) return ret; } while (0)
-
-
 extern long __put_user_bad(void);
 
 #define __put_user_nocheck(x,ptr,size)			\
@@ -1016,11 +997,6 @@
 (__builtin_constant_p(n) ?			\
  __constant_copy_to_user(to, from, n) :		\
  __generic_copy_to_user(to, from, n))
-
-#define copy_to_user_ret(to,from,n,retval) \
-	do { if (copy_to_user(to,from,n)) return retval; } while (0)
-#define copy_from_user_ret(to,from,n,retval) \
-	do { if (copy_from_user(to,from,n)) return retval; } while (0)
 
 /* We let the __ versions of copy_from/to_user inline, because they're often
  * used in fast paths and have only a small space overhead.

===================================================================


This BitKeeper patch contains the following changesets:
1.747
## Wrapped with gzip_uu ##


begin 664 bkpatch5654
M'XL(`&U"I3T``[64;6O;,!#'7U>?XJ#O5BR?9-FN#1G9FK'1;2QD]'51Y$OM
M-I:#I7@4_.&GN-"5LJY[ZEG@!TYW_O_OAX[APE%?'CE/`[%C^-`Y']ZZ3:/Y
MVE62WZPM.6[)<-/QZUU(675=2(GKKJ5XVA:[WL37VC:^ZR/)4Q:2EMJ;&@;J
M77DD>'+_Q=_NJ#Q:O7M_\>G-BK'9#,YJ;:_H*WF8S5BH,.AMY>;:U]O.<M]K
MZUKR.G1OQ_O442+*<*4B3S#-1I&ARD<C*B&T$E2A5*>98@L]--7E.6TVU-_.
M=:5W?M+QN))`+*1$E>`HBBR1;`&"YRH'E+'`L$"<EHBE2D^P"`\PR9X_[1*<
M"(B0O87_J^>,&3B_\QG,EK2%_8X#?-:F[QR8SGK=V,9>04]^W]OPF]I32]8[
MT#T!#<V6AQ+L(X1^0K+E#_-9](?!&&IDKV%W&.O/Y376;/<5Q=JUD>D;%^^U
M,>0<KQ_H33.5C++`%,<$59:EE3!9BNEZO7G6YN<Z"#Q,%D.,2:)$,?'V])X#
M@"\HYQ]K2TRD$F.2YH@3H.HQGHB_C2=")-5+\EG"BMIN('AU&6"$=D(T@'<W
MAR\0]=^F%4!:_F(D?X'E0J3!D"+<413PX#`R-9D;MV]G>1K"5,B^`SNYLJ/]
#!```
`
end


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284117AbRLAOaU>; Sat, 1 Dec 2001 09:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284115AbRLAOaM>; Sat, 1 Dec 2001 09:30:12 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:38036 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S284113AbRLAOaA>; Sat, 1 Dec 2001 09:30:00 -0500
Date: Sat, 1 Dec 2001 19:58:54 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: linux-kernel@vger.kernel.org
cc: Manik Raina <manik@cisco.com>
Subject: [Patch] : prevents multiple inclusion of headers
Message-ID: <Pine.LNX.4.21.0112011957330.30854-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

added customary 

#ifndef __FOO__
#define __FOO__

...
...

#endif 

to some headers in include/math-emu directory.

Manik


---- diffs ----


Index: double.h
===================================================================
RCS file: /vger/linux/include/math-emu/double.h,v
retrieving revision 1.4
diff -u -r1.4 double.h
--- double.h	20 Dec 1999 05:17:51 -0000	1.4
+++ double.h	1 Dec 2001 14:28:33 -0000
@@ -22,6 +22,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef    __MATH_EMU_DOUBLE_H__
+#define    __MATH_EMU_DOUBLE_H__
+
 #if _FP_W_TYPE_SIZE < 32
 #error "Here's a nickel kid.  Go buy yourself a real computer."
 #endif
@@ -197,3 +200,6 @@
 #define _FP_FRAC_HIGH_RAW_D(X)	_FP_FRAC_HIGH_1(X)
 
 #endif /* W_TYPE_SIZE < 64 */
+
+
+#endif /* __MATH_EMU_DOUBLE_H__ */
Index: extended.h
===================================================================
RCS file: /vger/linux/include/math-emu/extended.h,v
retrieving revision 1.4
diff -u -r1.4 extended.h
--- extended.h	20 Dec 1999 05:17:54 -0000	1.4
+++ extended.h	1 Dec 2001 14:28:33 -0000
@@ -19,6 +19,10 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+
+#ifndef    __MATH_EMU_EXTENDED_H__
+#define    __MATH_EMU_EXTENDED_H__
+
 #if _FP_W_TYPE_SIZE < 32
 #error "Here's a nickel, kid. Go buy yourself a real computer."
 #endif
@@ -388,3 +392,5 @@
 #define _FP_FRAC_HIGH_RAW_E(X)	(X##_f0)
 
 #endif /* not _FP_W_TYPE_SIZE < 64 */
+
+#endif /* __MATH_EMU_EXTENDED_H__ */
Index: op-1.h
===================================================================
RCS file: /vger/linux/include/math-emu/op-1.h,v
retrieving revision 1.4
diff -u -r1.4 op-1.h
--- op-1.h	19 Dec 1999 23:55:18 -0000	1.4
+++ op-1.h	1 Dec 2001 14:28:33 -0000
@@ -22,6 +22,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef    __MATH_EMU_OP_1_H__
+#define    __MATH_EMU_OP_1_H__
+
 #define _FP_FRAC_DECL_1(X)	_FP_W_TYPE X##_f
 #define _FP_FRAC_COPY_1(D,S)	(D##_f = S##_f)
 #define _FP_FRAC_SET_1(X,I)	(X##_f = I)
@@ -295,3 +298,5 @@
     else								\
       D##_f <<= _FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs;		\
   } while (0)
+
+#endif /* __MATH_EMU_OP_1_H__ */
Index: op-2.h
===================================================================
RCS file: /vger/linux/include/math-emu/op-2.h,v
retrieving revision 1.5
diff -u -r1.5 op-2.h
--- op-2.h	22 Feb 2001 05:40:06 -0000	1.5
+++ op-2.h	1 Dec 2001 14:28:33 -0000
@@ -22,6 +22,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef __MATH_EMU_OP_2_H__
+#define __MATH_EMU_OP_2_H__
+
 #define _FP_FRAC_DECL_2(X)	_FP_W_TYPE X##_f0, X##_f1
 #define _FP_FRAC_COPY_2(D,S)	(D##_f0 = S##_f0, D##_f1 = S##_f1)
 #define _FP_FRAC_SET_2(X,I)	__FP_FRAC_SET_2(X, I)
@@ -606,3 +609,4 @@
     _FP_FRAC_SLL_2(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));	\
   } while (0)
 
+#endif
Index: op-4.h
===================================================================
RCS file: /vger/linux/include/math-emu/op-4.h,v
retrieving revision 1.3
diff -u -r1.3 op-4.h
--- op-4.h	20 Sep 1999 12:14:30 -0000	1.3
+++ op-4.h	1 Dec 2001 14:28:33 -0000
@@ -22,6 +22,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef __MATH_EMU_OP_4_H__
+#define __MATH_EMU_OP_4_H__
+
 #define _FP_FRAC_DECL_4(X)	_FP_W_TYPE X##_f[4]
 #define _FP_FRAC_COPY_4(D,S)			\
   (D##_f[0] = S##_f[0], D##_f[1] = S##_f[1],	\
@@ -659,3 +662,4 @@
      _FP_FRAC_SLL_4(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));	\
    } while (0)
 
+#endif
Index: op-8.h
===================================================================
RCS file: /vger/linux/include/math-emu/op-8.h,v
retrieving revision 1.3
diff -u -r1.3 op-8.h
--- op-8.h	20 Sep 1999 12:14:32 -0000	1.3
+++ op-8.h	1 Dec 2001 14:28:33 -0000
@@ -21,6 +21,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef __MATH_EMU_OP_8_H__
+#define __MATH_EMU_OP_8_H__
+
 /* We need just a few things from here for op-4, if we ever need some
    other macros, they can be added. */
 #define _FP_FRAC_DECL_8(X)	_FP_W_TYPE X##_f[8]
@@ -101,3 +104,4 @@
     X##_f[0] |= (_s != 0);						\
   } while (0)
 
+#endif
Index: op-common.h
===================================================================
RCS file: /vger/linux/include/math-emu/op-common.h,v
retrieving revision 1.4
diff -u -r1.4 op-common.h
--- op-common.h	20 Dec 1999 05:18:00 -0000	1.4
+++ op-common.h	1 Dec 2001 14:28:34 -0000
@@ -21,6 +21,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef __MATH_EMU_OP_COMMON_H__
+#define __MATH_EMU_OP_COMMON_H__
+
 #define _FP_DECL(wc, X)			\
   _FP_I_TYPE X##_c, X##_s, X##_e;	\
   _FP_FRAC_DECL_##wc(X)
@@ -846,3 +849,4 @@
     q = n / d, r = n % d;			\
   } while (0)
 
+#endif /* __MATH_EMU_OP_COMMON_H__ */
Index: quad.h
===================================================================
RCS file: /vger/linux/include/math-emu/quad.h,v
retrieving revision 1.4
diff -u -r1.4 quad.h
--- quad.h	20 Dec 1999 05:18:03 -0000	1.4
+++ quad.h	1 Dec 2001 14:28:34 -0000
@@ -22,6 +22,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef  __MATH_EMU_QUAD_H__
+#define  __MATH_EMU_QUAD_H__
+
 #if _FP_W_TYPE_SIZE < 32
 #error "Here's a nickel, kid. Go buy yourself a real computer."
 #endif
@@ -201,3 +204,5 @@
 #define _FP_FRAC_HIGH_RAW_Q(X)	_FP_FRAC_HIGH_2(X)
 
 #endif /* not _FP_W_TYPE_SIZE < 64 */
+
+#endif /* __MATH_EMU_QUAD_H__ */
Index: single.h
===================================================================
RCS file: /vger/linux/include/math-emu/single.h,v
retrieving revision 1.4
diff -u -r1.4 single.h
--- single.h	20 Dec 1999 05:18:06 -0000	1.4
+++ single.h	1 Dec 2001 14:28:34 -0000
@@ -22,6 +22,9 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
+#ifndef    __MATH_EMU_SINGLE_H__
+#define    __MATH_EMU_SINGLE_H__
+
 #if _FP_W_TYPE_SIZE < 32
 #error "Here's a nickel kid.  Go buy yourself a real computer."
 #endif
@@ -109,3 +112,5 @@
 
 #define _FP_FRAC_HIGH_S(X)	_FP_FRAC_HIGH_1(X)
 #define _FP_FRAC_HIGH_RAW_S(X)	_FP_FRAC_HIGH_1(X)
+
+#endif /* __MATH_EMU_SINGLE_H__ */
Index: soft-fp.h
===================================================================
RCS file: /vger/linux/include/math-emu/soft-fp.h,v
retrieving revision 1.4
diff -u -r1.4 soft-fp.h
--- soft-fp.h	20 Dec 1999 05:18:09 -0000	1.4
+++ soft-fp.h	1 Dec 2001 14:28:34 -0000
@@ -21,8 +21,8 @@
    not, write to the Free Software Foundation, Inc.,
    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
-#ifndef SOFT_FP_H
-#define SOFT_FP_H
+#ifndef __MATH_EMU_SOFT_FP_H__
+#define __MATH_EMU_SOFT_FP_H__
 
 #include <asm/sfp-machine.h>
 
@@ -178,4 +178,4 @@
 #include <stdlib/longlong.h>
 #endif
 
-#endif
+#endif /* __MATH_EMU_SOFT_FP_H__ */


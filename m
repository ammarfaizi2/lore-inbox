Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUJEGqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUJEGqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268851AbUJEGqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:46:47 -0400
Received: from ozlabs.org ([203.10.76.45]:40164 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268849AbUJEGpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:45:17 -0400
Date: Tue, 5 Oct 2004 16:42:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PPC64] xmon sparse cleanups
Message-ID: <20041005064255.GF3695@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

This patch removes many sparse warnings from the xmon code.  Mostly
K&R function declarations and 0-instead-of-NULLs.

I believe this removes all save one sparse error in xmon, excepting
those inherited from header files.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/xmon/xmon.c
===================================================================
--- working-2.6.orig/arch/ppc64/xmon/xmon.c	2004-09-24 10:14:09.000000000 +1000
+++ working-2.6/arch/ppc64/xmon/xmon.c	2004-10-05 16:31:01.822963256 +1000
@@ -645,7 +645,7 @@
 	for (i = 0; i < NBPTS; ++i, ++bp)
 		if (bp->enabled && pc == bp->address)
 			return bp;
-	return 0;
+	return NULL;
 }
 
 static struct bpt *in_breakpoint_table(unsigned long nip, unsigned long *offp)
@@ -1582,7 +1582,7 @@
 extern char dec_exc;
 
 void
-super_regs()
+super_regs(void)
 {
 	int cmd;
 	unsigned long val;
@@ -1816,7 +1816,7 @@
     "";
 
 void
-memex()
+memex(void)
 {
 	int cmd, inc, i, nslash;
 	unsigned long n;
@@ -1967,7 +1967,7 @@
 }
 
 int
-bsesc()
+bsesc(void)
 {
 	int c;
 
@@ -1985,7 +1985,7 @@
 			 || ('a' <= (c) && (c) <= 'f') \
 			 || ('A' <= (c) && (c) <= 'F'))
 void
-dump()
+dump(void)
 {
 	int c;
 
@@ -2150,7 +2150,7 @@
 static unsigned mask;
 
 void
-memlocate()
+memlocate(void)
 {
 	unsigned a, n;
 	unsigned char val[4];
@@ -2183,7 +2183,7 @@
 static unsigned long mlim = 0xffffffff;
 
 void
-memzcan()
+memzcan(void)
 {
 	unsigned char v;
 	unsigned a;
@@ -2212,7 +2212,7 @@
 
 /* Input scanning routines */
 int
-skipbl()
+skipbl(void)
 {
 	int c;
 
@@ -2237,8 +2237,7 @@
 };
 
 int
-scanhex(vp)
-unsigned long *vp;
+scanhex(unsigned long *vp)
 {
 	int c, d;
 	unsigned long v;
@@ -2322,7 +2321,7 @@
 }
 
 void
-scannl()
+scannl(void)
 {
 	int c;
 
@@ -2365,13 +2364,13 @@
 static char *lineptr;
 
 void
-flush_input()
+flush_input(void)
 {
 	lineptr = NULL;
 }
 
 int
-inchar()
+inchar(void)
 {
 	if (lineptr == NULL || *lineptr == 0) {
 		if (fgets(line, sizeof(line), stdin) == NULL) {
@@ -2384,8 +2383,7 @@
 }
 
 void
-take_input(str)
-char *str;
+take_input(char *str)
 {
 	lineptr = str;
 }
Index: working-2.6/arch/ppc64/xmon/ppc-opc.c
===================================================================
--- working-2.6.orig/arch/ppc64/xmon/ppc-opc.c	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/xmon/ppc-opc.c	2004-10-05 16:41:20.355047248 +1000
@@ -20,6 +20,7 @@
    Software Foundation, 59 Temple Place - Suite 330, Boston, MA
    02111-1307, USA.  */
 
+#include <linux/stddef.h>
 #include "nonstdio.h"
 #include "ppc.h"
 
@@ -110,12 +111,12 @@
   /* The zero index is used to indicate the end of the list of
      operands.  */
 #define UNUSED 0
-  { 0, 0, 0, 0, 0 },
+  { 0, 0, NULL, NULL, 0 },
 
   /* The BA field in an XL form instruction.  */
 #define BA UNUSED + 1
 #define BA_MASK (0x1f << 16)
-  { 5, 16, 0, 0, PPC_OPERAND_CR },
+  { 5, 16, NULL, NULL, PPC_OPERAND_CR },
 
   /* The BA field in an XL form instruction when it must be the same
      as the BT field in the same instruction.  */
@@ -125,7 +126,7 @@
   /* The BB field in an XL form instruction.  */
 #define BB BAT + 1
 #define BB_MASK (0x1f << 11)
-  { 5, 11, 0, 0, PPC_OPERAND_CR },
+  { 5, 11, NULL, NULL, PPC_OPERAND_CR },
 
   /* The BB field in an XL form instruction when it must be the same
      as the BA field in the same instruction.  */
@@ -168,21 +169,21 @@
 
   /* The BF field in an X or XL form instruction.  */
 #define BF BDPA + 1
-  { 3, 23, 0, 0, PPC_OPERAND_CR },
+  { 3, 23, NULL, NULL, PPC_OPERAND_CR },
 
   /* An optional BF field.  This is used for comparison instructions,
      in which an omitted BF field is taken as zero.  */
 #define OBF BF + 1
-  { 3, 23, 0, 0, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
+  { 3, 23, NULL, NULL, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
 
   /* The BFA field in an X or XL form instruction.  */
 #define BFA OBF + 1
-  { 3, 18, 0, 0, PPC_OPERAND_CR },
+  { 3, 18, NULL, NULL, PPC_OPERAND_CR },
 
   /* The BI field in a B form or XL form instruction.  */
 #define BI BFA + 1
 #define BI_MASK (0x1f << 16)
-  { 5, 16, 0, 0, PPC_OPERAND_CR },
+  { 5, 16, NULL, NULL, PPC_OPERAND_CR },
 
   /* The BO field in a B form instruction.  Certain values are
      illegal.  */
@@ -197,36 +198,36 @@
 
   /* The BT field in an X or XL form instruction.  */
 #define BT BOE + 1
-  { 5, 21, 0, 0, PPC_OPERAND_CR },
+  { 5, 21, NULL, NULL, PPC_OPERAND_CR },
 
   /* The condition register number portion of the BI field in a B form
      or XL form instruction.  This is used for the extended
      conditional branch mnemonics, which set the lower two bits of the
      BI field.  This field is optional.  */
 #define CR BT + 1
-  { 3, 18, 0, 0, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
+  { 3, 18, NULL, NULL, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
 
   /* The CRB field in an X form instruction.  */
 #define CRB CR + 1
-  { 5, 6, 0, 0, 0 },
+  { 5, 6, NULL, NULL, 0 },
 
   /* The CRFD field in an X form instruction.  */
 #define CRFD CRB + 1
-  { 3, 23, 0, 0, PPC_OPERAND_CR },
+  { 3, 23, NULL, NULL, PPC_OPERAND_CR },
 
   /* The CRFS field in an X form instruction.  */
 #define CRFS CRFD + 1
-  { 3, 0, 0, 0, PPC_OPERAND_CR },
+  { 3, 0, NULL, NULL, PPC_OPERAND_CR },
 
   /* The CT field in an X form instruction.  */
 #define CT CRFS + 1
-  { 5, 21, 0, 0, PPC_OPERAND_OPTIONAL },
+  { 5, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The D field in a D form instruction.  This is a displacement off
      a register, and implies that the next operand is a register in
      parentheses.  */
 #define D CT + 1
-  { 16, 0, 0, 0, PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED },
+  { 16, 0, NULL, NULL, PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED },
 
   /* The DE field in a DE form instruction.  This is like D, but is 12
      bits only.  */
@@ -252,40 +253,40 @@
 
   /* The E field in a wrteei instruction.  */
 #define E DS + 1
-  { 1, 15, 0, 0, 0 },
+  { 1, 15, NULL, NULL, 0 },
 
   /* The FL1 field in a POWER SC form instruction.  */
 #define FL1 E + 1
-  { 4, 12, 0, 0, 0 },
+  { 4, 12, NULL, NULL, 0 },
 
   /* The FL2 field in a POWER SC form instruction.  */
 #define FL2 FL1 + 1
-  { 3, 2, 0, 0, 0 },
+  { 3, 2, NULL, NULL, 0 },
 
   /* The FLM field in an XFL form instruction.  */
 #define FLM FL2 + 1
-  { 8, 17, 0, 0, 0 },
+  { 8, 17, NULL, NULL, 0 },
 
   /* The FRA field in an X or A form instruction.  */
 #define FRA FLM + 1
 #define FRA_MASK (0x1f << 16)
-  { 5, 16, 0, 0, PPC_OPERAND_FPR },
+  { 5, 16, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FRB field in an X or A form instruction.  */
 #define FRB FRA + 1
 #define FRB_MASK (0x1f << 11)
-  { 5, 11, 0, 0, PPC_OPERAND_FPR },
+  { 5, 11, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FRC field in an A form instruction.  */
 #define FRC FRB + 1
 #define FRC_MASK (0x1f << 6)
-  { 5, 6, 0, 0, PPC_OPERAND_FPR },
+  { 5, 6, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FRS field in an X form instruction or the FRT field in a D, X
      or A form instruction.  */
 #define FRS FRC + 1
 #define FRT FRS
-  { 5, 21, 0, 0, PPC_OPERAND_FPR },
+  { 5, 21, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FXM field in an XFX instruction.  */
 #define FXM FRS + 1
@@ -298,11 +299,11 @@
 
   /* The L field in a D or X form instruction.  */
 #define L FXM4 + 1
-  { 1, 21, 0, 0, PPC_OPERAND_OPTIONAL },
+  { 1, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The LEV field in a POWER SC form instruction.  */
 #define LEV L + 1
-  { 7, 5, 0, 0, 0 },
+  { 7, 5, NULL, NULL, 0 },
 
   /* The LI field in an I form instruction.  The lower two bits are
      forced to zero.  */
@@ -316,24 +317,24 @@
 
   /* The LS field in an X (sync) form instruction.  */
 #define LS LIA + 1
-  { 2, 21, 0, 0, PPC_OPERAND_OPTIONAL },
+  { 2, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The MB field in an M form instruction.  */
 #define MB LS + 1
 #define MB_MASK (0x1f << 6)
-  { 5, 6, 0, 0, 0 },
+  { 5, 6, NULL, NULL, 0 },
 
   /* The ME field in an M form instruction.  */
 #define ME MB + 1
 #define ME_MASK (0x1f << 1)
-  { 5, 1, 0, 0, 0 },
+  { 5, 1, NULL, NULL, 0 },
 
   /* The MB and ME fields in an M form instruction expressed a single
      operand which is a bitmask indicating which bits to select.  This
      is a two operand form using PPC_OPERAND_NEXT.  See the
      description in opcode/ppc.h for what this means.  */
 #define MBE ME + 1
-  { 5, 6, 0, 0, PPC_OPERAND_OPTIONAL | PPC_OPERAND_NEXT },
+  { 5, 6, NULL, NULL, PPC_OPERAND_OPTIONAL | PPC_OPERAND_NEXT },
   { 32, 0, insert_mbe, extract_mbe, 0 },
 
   /* The MB or ME field in an MD or MDS form instruction.  The high
@@ -345,7 +346,7 @@
 
   /* The MO field in an mbar instruction.  */
 #define MO MB6 + 1
-  { 5, 21, 0, 0, 0 },
+  { 5, 21, NULL, NULL, 0 },
 
   /* The NB field in an X form instruction.  The value 32 is stored as
      0.  */
@@ -361,34 +362,34 @@
   /* The RA field in an D, DS, DQ, X, XO, M, or MDS form instruction.  */
 #define RA NSI + 1
 #define RA_MASK (0x1f << 16)
-  { 5, 16, 0, 0, PPC_OPERAND_GPR },
+  { 5, 16, NULL, NULL, PPC_OPERAND_GPR },
 
   /* The RA field in the DQ form lq instruction, which has special
      value restrictions.  */
 #define RAQ RA + 1
-  { 5, 16, insert_raq, 0, PPC_OPERAND_GPR },
+  { 5, 16, insert_raq, NULL, PPC_OPERAND_GPR },
 
   /* The RA field in a D or X form instruction which is an updating
      load, which means that the RA field may not be zero and may not
      equal the RT field.  */
 #define RAL RAQ + 1
-  { 5, 16, insert_ral, 0, PPC_OPERAND_GPR },
+  { 5, 16, insert_ral, NULL, PPC_OPERAND_GPR },
 
   /* The RA field in an lmw instruction, which has special value
      restrictions.  */
 #define RAM RAL + 1
-  { 5, 16, insert_ram, 0, PPC_OPERAND_GPR },
+  { 5, 16, insert_ram, NULL, PPC_OPERAND_GPR },
 
   /* The RA field in a D or X form instruction which is an updating
      store or an updating floating point load, which means that the RA
      field may not be zero.  */
 #define RAS RAM + 1
-  { 5, 16, insert_ras, 0, PPC_OPERAND_GPR },
+  { 5, 16, insert_ras, NULL, PPC_OPERAND_GPR },
 
   /* The RB field in an X, XO, M, or MDS form instruction.  */
 #define RB RAS + 1
 #define RB_MASK (0x1f << 11)
-  { 5, 11, 0, 0, PPC_OPERAND_GPR },
+  { 5, 11, NULL, NULL, PPC_OPERAND_GPR },
 
   /* The RB field in an X form instruction when it must be the same as
      the RS field in the instruction.  This is used for extended
@@ -402,22 +403,22 @@
 #define RS RBS + 1
 #define RT RS
 #define RT_MASK (0x1f << 21)
-  { 5, 21, 0, 0, PPC_OPERAND_GPR },
+  { 5, 21, NULL, NULL, PPC_OPERAND_GPR },
 
   /* The RS field of the DS form stq instruction, which has special
      value restrictions.  */
 #define RSQ RS + 1
-  { 5, 21, insert_rsq, 0, PPC_OPERAND_GPR },
+  { 5, 21, insert_rsq, NULL, PPC_OPERAND_GPR },
 
   /* The RT field of the DQ form lq instruction, which has special
      value restrictions.  */
 #define RTQ RSQ + 1
-  { 5, 21, insert_rtq, 0, PPC_OPERAND_GPR },
+  { 5, 21, insert_rtq, NULL, PPC_OPERAND_GPR },
 
   /* The SH field in an X or M form instruction.  */
 #define SH RTQ + 1
 #define SH_MASK (0x1f << 11)
-  { 5, 11, 0, 0, 0 },
+  { 5, 11, NULL, NULL, 0 },
 
   /* The SH field in an MD form instruction.  This is split.  */
 #define SH6 SH + 1
@@ -426,12 +427,12 @@
 
   /* The SI field in a D form instruction.  */
 #define SI SH6 + 1
-  { 16, 0, 0, 0, PPC_OPERAND_SIGNED },
+  { 16, 0, NULL, NULL, PPC_OPERAND_SIGNED },
 
   /* The SI field in a D form instruction when we accept a wide range
      of positive values.  */
 #define SISIGNOPT SI + 1
-  { 16, 0, 0, 0, PPC_OPERAND_SIGNED | PPC_OPERAND_SIGNOPT },
+  { 16, 0, NULL, NULL, PPC_OPERAND_SIGNED | PPC_OPERAND_SIGNOPT },
 
   /* The SPR field in an XFX form instruction.  This is flipped--the
      lower 5 bits are stored in the upper 5 and vice- versa.  */
@@ -443,25 +444,25 @@
   /* The BAT index number in an XFX form m[ft]ibat[lu] instruction.  */
 #define SPRBAT SPR + 1
 #define SPRBAT_MASK (0x3 << 17)
-  { 2, 17, 0, 0, 0 },
+  { 2, 17, NULL, NULL, 0 },
 
   /* The SPRG register number in an XFX form m[ft]sprg instruction.  */
 #define SPRG SPRBAT + 1
 #define SPRG_MASK (0x3 << 16)
-  { 2, 16, 0, 0, 0 },
+  { 2, 16, NULL, NULL, 0 },
 
   /* The SR field in an X form instruction.  */
 #define SR SPRG + 1
-  { 4, 16, 0, 0, 0 },
+  { 4, 16, NULL, NULL, 0 },
 
   /* The STRM field in an X AltiVec form instruction.  */
 #define STRM SR + 1
 #define STRM_MASK (0x3 << 21)
-  { 2, 21, 0, 0, 0 },
+  { 2, 21, NULL, NULL, 0 },
 
   /* The SV field in a POWER SC form instruction.  */
 #define SV STRM + 1
-  { 14, 2, 0, 0, 0 },
+  { 14, 2, NULL, NULL, 0 },
 
   /* The TBR field in an XFX form instruction.  This is like the SPR
      field, but it is optional.  */
@@ -471,52 +472,52 @@
   /* The TO field in a D or X form instruction.  */
 #define TO TBR + 1
 #define TO_MASK (0x1f << 21)
-  { 5, 21, 0, 0, 0 },
+  { 5, 21, NULL, NULL, 0 },
 
   /* The U field in an X form instruction.  */
 #define U TO + 1
-  { 4, 12, 0, 0, 0 },
+  { 4, 12, NULL, NULL, 0 },
 
   /* The UI field in a D form instruction.  */
 #define UI U + 1
-  { 16, 0, 0, 0, 0 },
+  { 16, 0, NULL, NULL, 0 },
 
   /* The VA field in a VA, VX or VXR form instruction.  */
 #define VA UI + 1
 #define VA_MASK	(0x1f << 16)
-  { 5, 16, 0, 0, PPC_OPERAND_VR },
+  { 5, 16, NULL, NULL, PPC_OPERAND_VR },
 
   /* The VB field in a VA, VX or VXR form instruction.  */
 #define VB VA + 1
 #define VB_MASK (0x1f << 11)
-  { 5, 11, 0, 0, PPC_OPERAND_VR },
+  { 5, 11, NULL, NULL, PPC_OPERAND_VR },
 
   /* The VC field in a VA form instruction.  */
 #define VC VB + 1
 #define VC_MASK (0x1f << 6)
-  { 5, 6, 0, 0, PPC_OPERAND_VR },
+  { 5, 6, NULL, NULL, PPC_OPERAND_VR },
 
   /* The VD or VS field in a VA, VX, VXR or X form instruction.  */
 #define VD VC + 1
 #define VS VD
 #define VD_MASK (0x1f << 21)
-  { 5, 21, 0, 0, PPC_OPERAND_VR },
+  { 5, 21, NULL, NULL, PPC_OPERAND_VR },
 
   /* The SIMM field in a VX form instruction.  */
 #define SIMM VD + 1
-  { 5, 16, 0, 0, PPC_OPERAND_SIGNED},
+  { 5, 16, NULL, NULL, PPC_OPERAND_SIGNED},
 
   /* The UIMM field in a VX form instruction.  */
 #define UIMM SIMM + 1
-  { 5, 16, 0, 0, 0 },
+  { 5, 16, NULL, NULL, 0 },
 
   /* The SHB field in a VA form instruction.  */
 #define SHB UIMM + 1
-  { 4, 6, 0, 0, 0 },
+  { 4, 6, NULL, NULL, 0 },
 
   /* The other UIMM field in a EVX form instruction.  */
 #define EVUIMM SHB + 1
-  { 5, 11, 0, 0, 0 },
+  { 5, 11, NULL, NULL, 0 },
 
   /* The other UIMM field in a half word EVX form instruction.  */
 #define EVUIMM_2 EVUIMM + 1
@@ -533,11 +534,11 @@
   /* The WS field.  */
 #define WS EVUIMM_8 + 1
 #define WS_MASK (0x7 << 11)
-  { 3, 11, 0, 0, 0 },
+  { 3, 11, NULL, NULL, 0 },
 
   /* The L field in an mtmsrd instruction */
 #define MTMSRD_L WS + 1
-  { 1, 16, 0, 0, PPC_OPERAND_OPTIONAL },
+  { 1, 16, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
 };
 
Index: working-2.6/arch/ppc64/xmon/start.c
===================================================================
--- working-2.6.orig/arch/ppc64/xmon/start.c	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/xmon/start.c	2004-10-05 16:33:50.355028808 +1000
@@ -173,7 +173,7 @@
 		c = xmon_getchar();
 		if (c == -1) {
 			if (p == str)
-				return 0;
+				return NULL;
 			break;
 		}
 		*p++ = c;



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSKRMzW>; Mon, 18 Nov 2002 07:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSKRMzV>; Mon, 18 Nov 2002 07:55:21 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:38916 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262464AbSKRMyC>; Mon, 18 Nov 2002 07:54:02 -0500
Date: Mon, 18 Nov 2002 11:00:59 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021118130059.GF2093@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there is four outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.893, 2002-11-18 10:42:11-02:00, acme@conectiva.com.br
  o i2c: fix up header cleanups: add include <linux/interrupt.h>
  
  Also some cleanups wrt struct member initialization style.


 i2c-elektor.c |   46 +++++++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 21 deletions(-)


diff -Nru a/drivers/i2c/i2c-elektor.c b/drivers/i2c/i2c-elektor.c
--- a/drivers/i2c/i2c-elektor.c	Mon Nov 18 10:56:50 2002
+++ b/drivers/i2c/i2c-elektor.c	Mon Nov 18 10:56:50 2002
@@ -32,23 +32,27 @@
 #include <linux/slab.h>
 #include <linux/version.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <asm/irq.h>
-#include <asm/io.h>
+#include <linux/wait.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
 #include <linux/i2c-elektor.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
 #include "i2c-pcf8584.h"
 
 #define DEFAULT_BASE 0x330
 
-static int base   = 0;
-static int irq    = 0;
+static int base;
+static int irq;
 static int clock  = 0x1c;
 static int own    = 0x55;
-static int mmapped = 0;
-static int i2c_debug = 0;
+static int mmapped;
+static int i2c_debug;
 
 /* vdovikin: removed static struct i2c_pcf_isa gpi; code - 
   this module in real supports only one device, due to missing arguments
@@ -199,24 +203,24 @@
  * This is only done when more than one hardware adapter is supported.
  */
 static struct i2c_algo_pcf_data pcf_isa_data = {
-	NULL,
-	pcf_isa_setbyte,
-	pcf_isa_getbyte,
-	pcf_isa_getown,
-	pcf_isa_getclock,
-	pcf_isa_waitforpin,
-	10, 10, 100,		/*	waits, timeout */
+	.setpcf	    = pcf_isa_setbyte,
+	.getpcf	    = pcf_isa_getbyte,
+	.getown	    = pcf_isa_getown,
+	.getclock   = pcf_isa_getclock,
+	.waitforpin = pcf_isa_waitforpin,
+	.udelay	    = 10,
+	.mdelay	    = 10,
+	.timeout    = 100,
 };
 
 static struct i2c_adapter pcf_isa_ops = {
-	"PCF8584 ISA adapter",
-	I2C_HW_P_ELEK,
-	NULL,
-	&pcf_isa_data,
-	pcf_isa_inc_use,
-	pcf_isa_dec_use,
-	pcf_isa_reg,
-	pcf_isa_unreg,
+	.name		   = "PCF8584 ISA adapter",
+	.id		   = I2C_HW_P_ELEK,
+	.algo_data	   = &pcf_isa_data,
+	.inc_use	   = pcf_isa_inc_use,
+	.dec_use	   = pcf_isa_dec_use,
+	.client_register   = pcf_isa_reg,
+	.client_unregister = pcf_isa_unreg,
 };
 
 int __init i2c_pcfisa_init(void) 

===================================================================


This BitKeeper patch contains the following changesets:
1.893
## Wrapped with gzip_uu ##


begin 664 bkpatch15294
M'XL(`)+CV#T``]U576_;1A!\YOV*10SDI1%U>_P0Q41!',MM!`>HX"#H2P#B
M=#Q+!_.KY-&."_[X+FG%EA0E;I,^E:($869V>;LS`$_@8Z/KV)$JU^P$WI6-
MC1U5%EI9<R-=5>;NJB;BLBR)&&_*7(_?7HQ-H;(VU<U(N`$C>BFMVL"-KIO8
M0==[0.Q=I6/G\ORWC^]/+QF;S>!L(XNU_J`MS&;,EO6-S-+FC;2;K"Q<6\NB
MR;4='MP]2#O!N:!/@!./!V&'(?<GG<(44?JH4R[\*/19/\.;P[,?=$'$"(6/
MG'?HA8'/YH!N-/6`BS'B&"-`'OLB1AQQ$7,.1YO"+P@CSM["?SO`&5-0@A$J
MABOS&=H*-EJFN@:5:5FT51.#3%/8+A]>9:9H/Y,75M=U6UEW\YH:T'V:-24T
M9-5#(=S6%AI;M\I"KO,5]32%L49FYB]I35D0>9=IEUT`^IZ8LN6C46ST+R_&
MN.3L]1/+26O3YV5,X_;?D<[T-56X:F=9/L>H"\5D*KIIRO4D]<B^T!>K2!XW
MYHFN6_<%CSI_POUH2.0W2YY.Z$_.0(F=4A2IMUV9?](PP@`C$2%V8NI-[\.+
M_#"[//I^=D4`(X'_S_3>V_H[C.K;X:8T+K_M\`]$>^'Y@.SD>U/,O1`$"2='
MA+?2#)J%C^"S3SN\;/*Q*7ON`*O_[,%/;.X/;?T)_3:6YE:T!0LKV>B7NP`5
MO&3S@/?B`/?%>2ZK2J?[>J&25*_:-561S3!A"TH:1,QQ&VTK=>4`73.@?XEI
M9$+@ZL[J%\2OC_'K/;Z\+;[F"=S2*BO5]2$]@+V@W]9565>FV!$\@KV$]I3)
MN^TCD/=0_C5D3:[+UGZ!")L+%#3C0N"4)G;<0N;:<0;^V?+LURB(?%A\.*7(
MRHJ\?=9W,>E6L1!GR;L_DF5R_O[\HF=DMBZ35%IYSS__<M8>&BH+E;2-=O8F
MW8(]G^HC_!;L>9497=BDUFO3T&GV9`3N2-KB0?0H&<`7CR]JM='JNFGS&8I0
-!!BNV-^.,1@2"`@`````
`
end

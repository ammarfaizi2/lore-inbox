Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSIAT7J>; Sun, 1 Sep 2002 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSIAT7J>; Sun, 1 Sep 2002 15:59:09 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:21729 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317392AbSIAT7I>;
	Sun, 1 Sep 2002 15:59:08 -0400
Date: Sun, 1 Sep 2002 22:03:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Make new keyboard code work on x86-64
Message-ID: <20020901220332.A74737@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

An ifdef needs to be added for x86-64 so that i8042.c works on it as
well:

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.578, 2002-09-01 22:01:48+02:00, ak@suse.de
  Because x86-64 also always reserves the kbd region,
  we must not call request_region() in i8042-io.h, like
  we don't for i386, alpha, etc.


 i8042-io.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h	Sun Sep  1 22:02:08 2002
+++ b/drivers/input/serio/i8042-io.h	Sun Sep  1 22:02:08 2002
@@ -62,7 +62,7 @@
  * On ix86 platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on ix86 boxes.
  */
-#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__)
+#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
 		return 0;
 #endif
@@ -71,7 +71,7 @@
 
 static inline void i8042_platform_exit(void)
 {
-#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__)
+#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__)
 	release_region(I8042_DATA_REG, 16);
 #endif
 }

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch74729
M'XL(`$!R<CT``[646V_:,!2`G_&O.!-2UZJ0V([C!"2FKF7:IDT:8NHS,HXA
M'B%FL8%URH^?N8RBL4LWC5Q\.?:Y^7Q)$^ZMJKJ-E?GDE,Q1$]X8Z[H-N[0J
MD%_]?&B,GX>YF:MPORL<ST)=+I8.^?6!<#*'E:ILMT&"Z"!Q#PO5;0Q?O;Y_
M_W*(4*\'=[DHI^JC<M#K(6>JE2@R>R-<7I@R<)4H[5PY$4@SKP];:XHQ]7=,
MD@C'O"8<LZ26)"-$,*(R3%G*&=H'=K,/^T?]#B;^Y936E%&>H#Z0($Y2P#3$
MG1`3H+2+29>EU]@/,(C9SE*FX)I`&Z-;^+_QWB$)MTH*[P2^I+S-&8C"&M^L
MQ8.%2OFBK)0%ERN8C3,OF&I3MKS66L%\:1V4QH$41>&7/B^5=:/=ELLKT"7H
M%#/:UB;(6U#HF=KI9:9\[F!B*M!1REO>V2(7+5!.!N@=T(@G*1H\5@FU__)"
M"`N,7L#W8KBU+O0T=\%2KC=%R2J]P62'3N@SU"9\C'1W<@F)2!H1C&M"".4U
MY4*JL<!*I#2.$G94FB?9\Y7W/6&LCE,_VG+X>[T-G.?,X(35IQA-:<?WL3<7
MLSBF6X"C$WS93_"ET*9GP?<8VU_PNL%J=^P?H%VMMX_'9/"'"OP#>'T>`T%O
MMVU33^!9IB:Z5-GE:+1A?32Z@HN+8ZG-3V7;[^%4[!,=<>;EJ._Y\UZV[?F\
:'/Z@,E=R9I?S7L;'40=/(O0-FSU=`ZX%````
`
end

-- 
Vojtech Pavlik
SuSE Labs

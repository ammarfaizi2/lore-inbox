Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319564AbSIMJBZ>; Fri, 13 Sep 2002 05:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319565AbSIMJBZ>; Fri, 13 Sep 2002 05:01:25 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:1169 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319564AbSIMJBY>;
	Fri, 13 Sep 2002 05:01:24 -0400
Date: Fri, 13 Sep 2002 11:06:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Minor input fixes [2/7]
Message-ID: <20020913110600.B28378@ucw.cz>
References: <20020913110453.A28145@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020913110453.A28145@ucw.cz>; from vojtech@suse.cz on Fri, Sep 13, 2002 at 11:04:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.568.4.3, 2002-09-01 22:01:48+02:00, ak@suse.de
  Because x86-64 also always reserves the kbd region,
  we must not call request_region() in i8042-io.h, like
  we don't for i386, alpha, etc.


 i8042-io.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h	Thu Sep 12 23:37:30 2002
+++ b/drivers/input/serio/i8042-io.h	Thu Sep 12 23:37:30 2002
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
1.568.4.3
## Wrapped with gzip_uu ##


begin 664 bkpatch25188
M'XL(`!H)@3T``[646V_:,!2`G_&O.!-2UZJ0V([C!"2FKF7:IDT:8NHS,HXA
M'B%FL8%URH^?N8RBL4LWC5Q\.?:Y^7Q)$^ZMJKJ-E?GDE,Q1$]X8Z[H-N[0J
MD%_]?&B,GX>YF:MPORL<ST)=+I8.^?6!<#*'E:ILMT&"Z"!Q#PO5;0Q?O;Y_
M_W*(4*\'=[DHI^JC<M#K(6>JE2@R>R-<7I@R<)4H[5PY$4@SKP];:XHQ]7=,
MD@C'O"8<LZ26)"-$,*(R3%G*&=H'=K,/^T?]#B;^Y936E%&>H#Z0(.9IP(((
M,`UQ)\0$*.UBTF7I-?8##&*VLY8IN";0QN@6_F_,=TC"K9+".X$O*6]S!J*P
MQC=K\6"A4KXP*V7!Y0IFX\P+IMJ4+:^U5C!?6@>E<2!%4?BESTMEW6BWY?(*
M=`DZQ8RVM0GR%A1ZIG9ZF2F?.YB8"G24\I9WMLA%"Y23`7H'-.))B@:/E4+M
MO[P0P@*C%_"](&ZM"SW-7;"4ZTUALDIO4-GA$_H,M0D?(]V=7$(BDD8$XYH0
M0GE-N9!J++`2*8VCA!V5YDGV?/5]3QBKX]2/MBS^7F\#Z#DS..'U*493VO%]
M[,W%+([I%N)3?-E/\*70IF?!]QC;7_"ZP6IW[!^@7:VWC\=D\(<*_`-X?1X#
M06^W;5-/X%FF)KI4V>5HM&%]-+J"BXMCJ<U/9=OOX53L$QUQYN6H[_GS7K;M
<^;P<_J(R5W)FE_->E$Q(AXQC]`T:)6GJL@4`````
`
end

-- 
Vojtech Pavlik
SuSE Labs

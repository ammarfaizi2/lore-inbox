Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSJIIIz>; Wed, 9 Oct 2002 04:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJIIIz>; Wed, 9 Oct 2002 04:08:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:44425 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261477AbSJIIIu>;
	Wed, 9 Oct 2002 04:08:50 -0400
Date: Wed, 9 Oct 2002 10:14:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Input - Fix i8042.c for Sun [3/3]
Message-ID: <20021009101427.B10773@ucw.cz>
References: <20021009101256.A10748@ucw.cz> <20021009101359.A10773@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021009101359.A10773@ucw.cz>; from vojtech@suse.cz on Wed, Oct 09, 2002 at 10:13:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.717, 2002-10-09 09:12:00+02:00, vojtech@suse.cz
  Fix i8042 for Sun, recent updates broke it.


 i8042.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Wed Oct  9 10:11:35 2002
+++ b/drivers/input/serio/i8042.c	Wed Oct  9 10:11:35 2002
@@ -21,10 +21,6 @@
 #include <linux/serio.h>
 #include <linux/sched.h>
 
-#undef DEBUG
-
-#include "i8042.h"
-
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
 MODULE_LICENSE("GPL");
@@ -41,6 +37,9 @@
 static int i8042_direct;
 static int i8042_dumbkbd;
 
+#undef DEBUG
+#include "i8042.h"
+
 spinlock_t i8042_lock = SPIN_LOCK_UNLOCKED;
 
 struct i8042_values {
@@ -287,7 +286,6 @@
  */
 
 static struct i8042_values i8042_kbd_values = {
-	.irq =		I8042_KBD_IRQ,
 	.irqen =	I8042_CTR_KBDINT,
 	.disable =	I8042_CTR_KBDDIS,
 	.name =		"KBD",
@@ -306,7 +304,6 @@
 };
 
 static struct i8042_values i8042_aux_values = {
-	.irq =		I8042_AUX_IRQ,
 	.irqen =	I8042_CTR_AUXINT,
 	.disable =	I8042_CTR_AUXDIS,
 	.name =		"AUX",
@@ -811,6 +808,9 @@
 
 	if (i8042_platform_init())
 		return -EBUSY;
+
+	i8042_aux_values.irq =	I8042_AUX_IRQ;
+	i8042_kbd_values.irq =	I8042_KBD_IRQ;
 
 	if (i8042_controller_init())
 		return -ENODEV;

===================================================================

This BitKeeper patch contains the following changesets:
1.717
## Wrapped with gzip_uu ##


begin 664 bkpatch10739
M'XL(`+?DHST``[647V^;,!3%G^-/<=4\=H%[P4!@RM2FZ=JHD]:EBK2'2I%C
MG,"20`8F[28^_`SI,JW;NC]:`5FR.=<Z/O<G=V%:JB+J[/(/6LF$=>$R+W74
M*:M26?*SF4_RW,SM)-\H^T%ESU=VFFTKS<S_:Z%E`CM5E%&'+/>PHC]M5=29
MG%],WYQ.&!L,X"P1V5+=*`V#`=-YL1/KN#P1.EGGF:4+D94;I84E\TU]D-8.
MHF->CP(7/;\F'WE02XJ)!"<5H\/[/F</QDX>;#^J)\00?8\3KS'P0I>-@*R`
M`D#')K0Q!`PC<B+$8VQ&>+0='!/TD`WA_YH^8Q)>I_>0]I$[L,@+N*FR%U`H
MJ3(-U3866I4P+_*5@E1;[`J,>637WX)DO;]\&$.![-7A@/HN7:?+1%N5O&MR
MBXNTZ>2^N[8A(\WMUIXE]X<*T"7'\\FO71.K4P?8G$>05,AI@?'CZ'Z[8]N;
M@,CS:NX'#F])>:*H8>?9W/_`T1^Y;\BBFKNF.RU9%'X/%D6>]RNP?.CYSP:6
MP<G@H\1*+%6#SS[@M]`K[MK/\'#]5-;_@-?(X<#9F+M@;H(JB]4"1N?#Z07K
MIIE<5[&"H_WFR1&[->H0@=C(-4D1&_>I*;MEG58R$]7]S*12J=)*BX\PZ(S;
MY=/I^]EX\N[E5]EJ'O],=C4<[66'&TDF2J[*:C.(PSEY_@+9%QLPFW+^!```
`
end

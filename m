Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSKOIHp>; Fri, 15 Nov 2002 03:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKOIG6>; Fri, 15 Nov 2002 03:06:58 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:49537 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265895AbSKOIGB>;
	Fri, 15 Nov 2002 03:06:01 -0500
Date: Fri, 15 Nov 2002 09:12:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Remove dead logibusmouse.h [6/13]
Message-ID: <20021115091247.E16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091214.D16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:12:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.786.54.3, 2002-10-23 10:41:57+02:00, vojtech@suse.cz
  Remove dead logibusmouse.h.


 logibusmouse.h |  104 ---------------------------------------------------------
 1 files changed, 104 deletions(-)

===================================================================

diff -Nru a/include/linux/logibusmouse.h b/include/linux/logibusmouse.h
--- a/include/linux/logibusmouse.h	Fri Nov 15 08:31:24 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,104 +0,0 @@
-#ifndef _LINUX_BUSMOUSE_H
-#define _LINUX_BUSMOUSE_H
-
-/*
- * linux/include/linux/busmouse.h: header file for Logitech Bus Mouse driver
- * by James Banks
- *
- * based on information gleamed from various mouse drivers on the net
- *
- * Heavily modified by David giller (rafetmad@oxy.edu)
- *
- * Minor modifications for Linux 0.96c-pl1 by Nathan Laredo
- * gt7080a@prism.gatech.edu (13JUL92)
- *
- * Microsoft BusMouse support by Teemu Rantanen (tvr@cs.hut.fi) (02AUG92)
- *
- * Microsoft Bus Mouse support modified by Derrick Cole (cole@concert.net)
- *    8/28/92
- *
- * Microsoft Bus Mouse support folded into 0.97pl4 code
- *    by Peter Cervasio (pete%q106fm.uucp@wupost.wustl.edu) (08SEP92)
- * Changes:  Logitech and Microsoft support in the same kernel.
- *           Defined new constants in busmouse.h for MS mice.
- *           Added int mse_busmouse_type to distinguish busmouse types
- *           Added a couple of new functions to handle differences in using
- *             MS vs. Logitech (where the int variable wasn't appropriate).
- *
- */
-
-#define MOUSE_IRQ		5
-#define LOGITECH_BUSMOUSE       0   /* Minor device # for Logitech  */
-#define MICROSOFT_BUSMOUSE      2   /* Minor device # for Microsoft */
-
-/*--------- LOGITECH BUSMOUSE ITEMS -------------*/
-
-#define	LOGIBM_BASE		0x23c
-#define	MSE_DATA_PORT		0x23c
-#define	MSE_SIGNATURE_PORT	0x23d
-#define	MSE_CONTROL_PORT	0x23e
-#define	MSE_INTERRUPT_PORT	0x23e
-#define	MSE_CONFIG_PORT		0x23f
-#define	LOGIBM_EXTENT		0x4
-
-#define	MSE_ENABLE_INTERRUPTS	0x00
-#define	MSE_DISABLE_INTERRUPTS	0x10
-
-#define	MSE_READ_X_LOW		0x80
-#define	MSE_READ_X_HIGH		0xa0
-#define	MSE_READ_Y_LOW		0xc0
-#define	MSE_READ_Y_HIGH		0xe0
-
-/* Magic number used to check if the mouse exists */
-#define MSE_CONFIG_BYTE		0x91
-#define MSE_DEFAULT_MODE	0x90
-#define MSE_SIGNATURE_BYTE	0xa5
-
-/* useful Logitech Mouse macros */
-
-#define MSE_INT_OFF()	outb(MSE_DISABLE_INTERRUPTS, MSE_CONTROL_PORT)
-#define MSE_INT_ON()	outb(MSE_ENABLE_INTERRUPTS, MSE_CONTROL_PORT)
-
-/*--------- MICROSOFT BUSMOUSE ITEMS -------------*/
-
-#define	MSBM_BASE			0x23d
-#define	MS_MSE_DATA_PORT	        0x23d
-#define	MS_MSE_SIGNATURE_PORT	        0x23e
-#define	MS_MSE_CONTROL_PORT	        0x23c
-#define	MS_MSE_CONFIG_PORT		0x23f
-#define	MSBM_EXTENT			0x3
-
-#define	MS_MSE_ENABLE_INTERRUPTS	0x11
-#define	MS_MSE_DISABLE_INTERRUPTS	0x10
-
-#define	MS_MSE_READ_BUTTONS             0x00
-#define	MS_MSE_READ_X		        0x01
-#define	MS_MSE_READ_Y                   0x02
-
-#define MS_MSE_START                    0x80
-#define MS_MSE_COMMAND_MODE             0x07
-
-/* useful microsoft busmouse macros */
-
-#define MS_MSE_INT_OFF() {outb(MS_MSE_COMMAND_MODE, MS_MSE_CONTROL_PORT); \
-			    outb(MS_MSE_DISABLE_INTERRUPTS, MS_MSE_DATA_PORT);}
-#define MS_MSE_INT_ON()  {outb(MS_MSE_COMMAND_MODE, MS_MSE_CONTROL_PORT); \
-			    outb(MS_MSE_ENABLE_INTERRUPTS, MS_MSE_DATA_PORT);}
-
- 
-struct mouse_status {
-	unsigned char	buttons;
-	unsigned char	latch_buttons;
-	int		dx;
-	int		dy;	
-	int 		present;
-	int		ready;
-	int		active;
-	wait_queue_head_t wait;
-	struct fasync_struct *fasyncptr;
-};
-
-/* Function Prototypes */
-
-#endif
-

===================================================================

This BitKeeper patch contains the following changesets:
1.786.54.3
## Wrapped with gzip_uu ##


begin 664 bkpatch16437
M'XL(`,RBU#T``[64[6K;,!2&?T=7(>C/$NOHPQ\1>&1MQP8=+&3T`ESI-/9J
M6\&6DVV87?O4+,W6P%:6=98-DBU>G?<]#SZC-SUV>K)QGSR:DIS1=Z[W>M(/
M/4;F:U@OG0MK5KH&V7X7N[UG5;L>/`G?%X4W)=U@U^L)C^3AC?^R1CU9OGE[
M\_[UDI`\IY=ET:[P(WJ:Y\2[;E/4MI\7OJQ=&_FN:/L&?1$9UXR'K:,`$&'$
M/)40)R-/0*6CX9;S0G&T(%26*&*WS5;,J_:N*RP6-G+=ZDB#@Y"0*2[X**2`
MC%Q1'J59$L4JDA0$X\"$I!RTXCI.ST%H`+HW/-_'0<\YG0*YH"];_24Q=(F-
MVR!]J)[6;E7=#GWC'DXM(W)-A4PXD,7/",GT+R]"H`#RZIG*J];4@T565^WP
MF3VMXU<S,R5&/LOB=%3!1YJFL4FLE3Q3QY&-%Y6_1EQCQRS6Z-&R*$RF3[6_
M'<L\]BP\"F1(3F0"=A2=IO<\<O]N_<4.D*,,^K,=HN*134&YT`JT3'[')OPO
M-J]V06OZ)P<!TA\]^D"GW79W!^@6)[;K!+P//QY3HKGOAR87*KF+,37D.Z`$
&\]GE!```
`
end

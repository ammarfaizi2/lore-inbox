Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSGYOI0>; Thu, 25 Jul 2002 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSGYOI0>; Thu, 25 Jul 2002 10:08:26 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:52166 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314340AbSGYOIZ>;
	Thu, 25 Jul 2002 10:08:25 -0400
Date: Thu, 25 Jul 2002 16:11:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [cset] Fix mouse wheel direction in psmouse.c
Message-ID: <20020725161132.A22767@ucw.cz>
References: <20020725083716.A20717@ucw.cz> <20020725140040.A14561@ucw.cz> <20020725140342.B14561@ucw.cz> <20020725142559.C14561@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020725142559.C14561@ucw.cz>; from vojtech@suse.cz on Thu, Jul 25, 2002 at 02:25:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull http://linux-input.bkbits.net:8080/linux-input' should also
work.

===================================================================

ChangeSet@1.447, 2002-07-25 16:08:56+02:00, vojtech@twilight.ucw.cz
  Because the Linux Input core follows the USB HID standard where it
  comes to directions of movement and rotation, a mouse wheel should
  be positive where it "rotates forward, away from the user". We had
  the opposite in psmouse.c. Fixed this.

===================================================================

 psmouse.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Thu Jul 25 16:09:18 2002
+++ b/drivers/input/mouse/psmouse.c	Thu Jul 25 16:09:18 2002
@@ -102,7 +102,7 @@
 			case 1: /* Mouse extra info */
 
 				input_report_rel(dev, packet[2] & 0x80 ? REL_HWHEEL : REL_WHEEL,
-					(int) (packet[2] & 7) - (int) (packet[2] & 8));
+					(int) (packet[2] & 8) - (int) (packet[2] & 7));
 				input_report_key(dev, BTN_SIDE, (packet[2] >> 4) & 1);
 				input_report_key(dev, BTN_EXTRA, (packet[2] >> 5) & 1);
 					
@@ -111,7 +111,7 @@
 			case 3: /* TouchPad extra info */
 
 				input_report_rel(dev, packet[2] & 0x08 ? REL_HWHEEL : REL_WHEEL,
-					(int) ((packet[2] >> 4) & 7) - (int) ((packet[2] >> 4) & 8));
+					(int) ((packet[2] >> 4) & 8) - (int) ((packet[2] >> 4) & 7));
 				packet[0] = packet[2] | 0x08;
 
 				break;
@@ -135,14 +135,14 @@
  */
 
 	if (psmouse->type == PSMOUSE_IMPS || psmouse->type == PSMOUSE_GENPS)
-		input_report_rel(dev, REL_WHEEL, (signed char) packet[3]);
+		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
 
 /*
  * Scroll wheel and buttons on IntelliMouse Explorer
  */
 
 	if (psmouse->type == PSMOUSE_IMEX) {
-		input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 7) - (int) (packet[3] & 8));
+		input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
 		input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
 		input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
 	}

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch22758
M'XL(`(X&0#T``[65;4_;,!#'7]>?X@32U@J:.(GS0*<B!G10K=*J(L2+"2$W
MN9",-(X2MX4I'WZ.6Q7&@#TPTDI6[^'G._M_Z3:<5UCV6@OQ36*8D&TX%97L
MM>0RS=+K1!KS<&F$WY5](H2RFXF8H;F.-J<W9IH7<TF4?\QEF,`"RZK7L@QG
M8Y%W!?9:D\')^>CCA)!^'XX2GE_C&4KH]XD4Y8)G477`99*)W)`ESZL92FZ$
M8E9O0FN;4EM]7,MWJ.O5ED>97X=69%F<61A1FP4>(^O"#AZ5_YCCVZYEVXX;
MU*[M^#8Y!LM@S`=JF]0W;1<LKT>#GNOM4+M'*3R#A1T+NI0<PO]MXHB$<(@A
MGU<(,D$8I?G\%H;-04,H2H189)E85MIY?G8(I\-CJ"3/(UY&L$Q0A:120=3F
MJ*($1&F)H4Q%7H&(8286.,-<@LJ`4DC>>':!*T>SI0)@!E4BYEFD(%.$0E2I
M3!>X8<.63E/P6)1+M:O*7O([B$LQTU4I3KEEP`5"PAM(8Q.%YJC\'(I*[V6$
M!GQ*;S%2`6EED,^@[L-SR?A>(Z3[EP\AE%.R_]R=U5&9-B)="=?499B;<M;R
MH([ET(#9-0T\ZM53?SIU@\@)8F2NC?@JMI(>HX'KU$[`+*8'XL6T9DC>L)=7
ML54OENO93/7B>'MZC/9^&2+G=T/$H,O>9(B4M(!GF5;?2M7W@V"H%UV!\3S+
M[@P8OE?B5MVF<:JT.)R-STQ[5P&:`3G!O/G9B'-U8U^@6R[U5XEM_/+E_8-Z
MCRVJCHX,5TNK>=II+CO0+GAX@_*K?0GO(.A`%YZP^YW.!X6PF$;HY2'B0>S^
M/K#.(](3[C70"310+ZV6[O6JQ$*4S9*U(USLPF0PNKHX'0Q&N]!M5^EUKLXR
M3'C9@376N=0LMNJ/N7_&^KE+YYGNG4WWFW^>,,'PIIK/^EZ`;CSU]\@/^0N@
%3.X&````
`
end


-- 
Vojtech Pavlik
SuSE Labs

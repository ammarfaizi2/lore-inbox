Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265974AbSKOIHo>; Fri, 15 Nov 2002 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbSKOIHF>; Fri, 15 Nov 2002 03:07:05 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:48257 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265909AbSKOIF0>;
	Fri, 15 Nov 2002 03:05:26 -0500
Date: Fri, 15 Nov 2002 09:12:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Probe for Synaptics Touchpads so that other probes don't confuse them [5/13]
Message-ID: <20021115091214.D16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091119.C16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:11:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.786.54.2, 2002-10-23 10:41:21+02:00, dwmw2@infradead.org
  psmouse.c: First check for a Synaptics touchpad, other probes confuse
  it enough to disable the trackpoint.


 psmouse.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Fri Nov 15 08:31:33 2002
+++ b/drivers/input/mouse/psmouse.c	Fri Nov 15 08:31:33 2002
@@ -312,6 +312,26 @@
 		return PSMOUSE_PS2;
 
 /*
+ * Try Synaptics TouchPad magic ID
+ */
+
+       param[0] = 0;
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+
+       if (param[1] == 0x47) {
+               /* We could do more here. But it's sufficient just
+                  to stop the subsequent probes from screwing the
+                  thing up. */
+               psmouse->vendor = "Synaptics";
+               psmouse->name = "TouchPad";
+               return PSMOUSE_PS2;
+       }
+
+/*
  * Try Genius NetMouse magic init.
  */
 

===================================================================

This BitKeeper patch contains the following changesets:
1.786.54.2
## Wrapped with gzip_uu ##


begin 664 bkpatch16466
M'XL(`-6BU#T``^6574_;,!2&K^M?<007&Q]-;"=M0U`1`PI#&Z-JBW:Q3<A-
MW";0Q)GMM&/K_ON<?H2IL(JA<36W4N7X/:?GO.>QL@E7BDN_,A8WF@<1VH2W
M0FF_HG+%K>"[V7>$,'L[$@FW%RJ[?VO':99K9,[;3`<1C+E4?H583OE$WV7<
MKW1:9U?OWW00:C;A.&+ID'>YAF83:2'';!2J0Z:CD4@M+5FJ$JZ9%8AD6DJG
M%&-J/C72<'"M/B5U[#:F`0D)82[A(::N5W?1HK##1=DK\013BO?,#YE2ZNT1
M=`+$:GAUJ^9:%#"U";:I`P3[+O$IV<'4QQC"23*AAW$ZD"SD++2$',(.@2I&
M1_!OJS]&`60J$;/B?3B-I=(01#RXA8&0P*![E[),QX$R?YP'4<;"71`ZXA(R
M*?I<02#2@8DV>6(-/!7YT`Q`0!@KUA]Q,%(P)0:WF8A3;:%W0!V*/=2^GPFJ
M_N5""#.,#F!IO9[$HW@8:2L/)L4(0AD74,Q!L6?-V663<V,:V"$.]EPZQ5X=
MUZ?]1K]?\T+'&W"W1CE_;`1/R&O&760EQ!CNU8@[@V]M6`'D"_;Q`,^G]$#V
M<,/=J]&IXQAH9L@2;Q564E\'*\4O1>OS$;T'U*19B^A\=I=0E9/9UR#77C_&
M9S!\[A`7*$:P#3UY]UL7O:*+-@LA8<,X@/,3(['19P3SE3')DD_X"S0![Y</
MYX5<&U<3EH:O%_O=N7H7VMV+RZMNZ_KXXN2ZV^IU6MVM_R;VK-4[_W!Z:8)+
M#^,!O)[[2(R/QLAO;F,+?BR/E\O>AH_<X)./0@@%)$)R,%QQ"XYR;7!ZI4#E
M@T$<Q#S5<),KO9K!+$.:TB*;8:;RON)?\T*]8',@10(JD'P2I\-"\UB&J#C+
M,ZO@8.5LT7CU8,S3T%R')FR4)&WL_U&=LH07VB5K#Z62ZURFI9'M+BTE/XV1
:]O;]&WAV&56>-,TE-M?59>@7.P[2P]P'````
`
end

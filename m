Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270206AbTGMKWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270207AbTGMKWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:22:15 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:2760 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270206AbTGMKWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:22:05 -0400
Date: Sun, 13 Jul 2003 12:36:43 +0200
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] helptext for radiolists in menuconfig
Message-ID: <20030713103642.GA15718@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19beDj-00049w-00*1rNFe/Q3Yg.*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patchs adds functionality to display helptext in choice-menus
in menuconfig.

--
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1485, 2003-07-12 20:06:34+02:00, andersg@0x63.nu
  Make menuconfig display helptext in "choice" menus.


 kconfig/mconf.c      |   20 ++++++++++++++++----
 lxdialog/checklist.c |    3 ++-
 2 files changed, 18 insertions(+), 5 deletions(-)


diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c	Sat Jul 12 20:07:32 2003
+++ b/scripts/kconfig/mconf.c	Sat Jul 12 20:07:32 2003
@@ -607,6 +607,7 @@
 	struct symbol *active;
 	int stat;
 
+	active = sym_get_choice_value(menu->sym);
 	while (1) {
 		cprint_init();
 		cprint("--title");
@@ -618,13 +619,18 @@
 		cprint("6");
 
 		current_menu = menu;
-		active = sym_get_choice_value(menu->sym);
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
 			cprint("%p", child);
 			cprint("%s", menu_get_prompt(child));
-			cprint(child->sym == active ? "ON" : "OFF");
+			if (sym_get_choice_value(menu->sym) == child->sym) {
+				cprint("ON");
+			}else if (active== child->sym) {
+				cprint("SELECTED");
+			}else{
+				cprint("OFF");
+			}
 		}
 
 		stat = exec_conf();
@@ -634,9 +640,15 @@
 				break;
 			sym_set_tristate_value(menu->sym, yes);
 			return;
-		case 1:
-			show_help(menu);
+		case 1: {
+			struct menu *tmp;
+			if (sscanf(input_buf, "%p", &tmp) == 1) {
+				show_help(tmp);
+				active=tmp->sym;
+			} else
+				show_help(menu);
 			break;
+		}
 		case 255:
 			return;
 		}
diff -Nru a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
--- a/scripts/lxdialog/checklist.c	Sat Jul 12 20:07:32 2003
+++ b/scripts/lxdialog/checklist.c	Sat Jul 12 20:07:32 2003
@@ -138,7 +138,7 @@
     /* Initializes status */
     for (i = 0; i < item_no; i++) {
 	status[i] = !strcasecmp (items[i * 3 + 2], "on");
-	if (!choice && status[i])
+	if ((!choice && status[i]) || (!strcasecmp (items[i * 3 + 2], "selected")))
             choice = i;
     }
 
@@ -302,6 +302,7 @@
 	case 'H':
 	case 'h':
 	case '?':
+	    fprintf (stderr, "%s", items[(scroll + choice) * 3]);
 	    delwin (dialog);
 	    free (status);
 	    return 1;

===================================================================


This BitKeeper patch contains the following changesets:
1.1485
## Wrapped with gzip_uu ##


M'XL( &1.$#\  \U6:V_;-A3];/Z*6Q<+[*:62)%Z6(4+=TFZ!>O:(%T_%8%!
M2[0M6"^(E)-TVG\?*3ENZK;.UFY 90,$'_?HW'O/(?08WDE1A3V>QZ*22_08
M?BVD"GOXQJ-67NOY95'HN1USQ>U8;.RUJ'*1VO.U/4^+:Z1/7' 5K6"CX\,>
ML>AN1=V6(NQ=GOWR[M6+2X0F$SA9\7PIW@H%DPE21;7A:2RG7*W2(K=4Q7.9
M"<6MJ,B:W='&P=C1/Y?X%+M>0SS,_"8B,2&<$1%CAP4>0U61):*>+BKK0U&)
M)/T<A&*?.)BZCN-J$(>YZ!2(15C@ J8V]FWB@(-#[(64'6,GQ!BV59ENJP''
M#HPP^AG^6^HG*(+?^5I )O(Z*O)%LH0XD67*;V$ETE*)&P5)#OUH5221Z+?G
MI(5^ \*HB]'%Q[JBT;]\$,(<H^</9"2C*BF5M-.;..%IL;2CE8C6:2*5%=U+
MDF'J-=C%WK@9!POAN\SW:2R<N1/LE_)!R+9;Q'=]%C2.ZS&J27Y(RE*DTS3)
MZYM1Y@5KJZB6[^^H7^TPUUT1[<R,6X9$(V)&'4(;BBG#S6(\YC&-R3AR S^F
MWE<9?@'M/CF/$=T#H^Y#*3TL^.^O,2J-[;X'/< ^IHU6JTM:<["/SB#CT/5#
M%AQP!OF!G-%)Y@V,JNOVKY5^<;!!W^"<4\(($'3>#;UD 8/!HXX)'!V!5%S5
M\GUR-82F@<$CJ:J(2Q%E)0P2)3*]!4^ PC$X5T^A+T4J(B7B_G X1.<4,X,)
M^EF459(K#2Z5KGFEC_XD^T^A@QCHG(HTU2#=BX<&\FKX[!-![BG8:/%_M1**
M^49DT[Q6TLJ3?,VM7+?\H)\\,G:TZ@AIF.=J*1OU!?]<?<2#$?N!Y-=="E^1
MWUX!OD%YYQX>&WGP2"4; ;K3M]EL*=2L(S+3-:C%P+ 9/==;6@ZGGF-$J@??
M2-8,/NKU6M$^$*SEHL65I/%V^J>)ZT6M*@?]-Z_[&EXO_"52*<#@=:P.1KT]
M>W5V\L?9Z?W8/=R7+^\V-6OJ@Z-9TZ!E;6P$).PPM:WJ2+6EAR<J*Y_MTI(1
MSQ>#)"]K-9O7"V.<4AOG2!]JDR)WK.2JN)Z9A@[,5@NP+>U$+[0)=$S \-P+
B,2_6,9I<VQ)-=_<!U%XOLLXF8T&"N;E4_P8%_E/%;PD     
 

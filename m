Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSLHPZ4>; Sun, 8 Dec 2002 10:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSLHPZ4>; Sun, 8 Dec 2002 10:25:56 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:48647 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261295AbSLHPZ3>; Sun, 8 Dec 2002 10:25:29 -0500
Date: Sun, 8 Dec 2002 13:33:01 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
Subject: [PATCHES] 2: more trivial compile fix and includes fixups patches
Message-ID: <20021208153301.GA14779@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.com
References: <20021207182510.GE10322@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20021207182510.GE10322@conectiva.com.br>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/misc-2.5
	
	There are 34 outstanding changesets, the last 20 are attached.

	Jeff, again, some for drivers/net

- Arnaldo

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.857.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.857, 2002-12-07 23:33:19-02:00, acme@conectiva.com.br
  o epca: use module_{init,exit}, {cleanup,init}_module now are macros


 epca.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)


diff -Nru a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c	Sun Dec  8 13:27:48 2002
+++ b/drivers/char/epca.c	Sun Dec  8 13:27:48 2002
@@ -141,12 +141,6 @@
 	configured.
 ----------------------------------------------------------------------- */
 	
-
-#ifdef MODULE
-int                init_module(void);
-void               cleanup_module(void);
-#endif /* MODULE */
-
 static inline void memwinon(struct board_info *b, unsigned int win);
 static inline void memwinoff(struct board_info *b, unsigned int win);
 static inline void globalwinon(struct channel *ch);
@@ -1534,8 +1528,7 @@
 } /* End pc_open */
 
 #ifdef MODULE
-/* -------------------- Begin init_module ---------------------- */
-int __init init_module()
+static int __init epca_module_init(void)
 { /* Begin init_module */
 
 	unsigned long	flags;
@@ -1548,8 +1541,9 @@
 	restore_flags(flags);
 
 	return(0);
-} /* End init_module */
+}
 
+module_init(epca_module_init);
 #endif
 
 #ifdef ENABLE_PCI
@@ -1559,8 +1553,8 @@
 #ifdef MODULE
 /* -------------------- Begin cleanup_module  ---------------------- */
 
-void cleanup_module()
-{ /* Begin cleanup_module */
+static void __exit epca_module_exit(void)
+{
 
 	int               count, crd;
 	struct board_info *bd;
@@ -1613,7 +1607,8 @@
 
 	restore_flags(flags);
 
-} /* End cleanup_module */
+}
+module_exit(epca_module_exit);
 #endif /* MODULE */
 
 /* ------------------ Begin pc_init  ---------------------- */

===================================================================


This BitKeeper patch contains the following changesets:
1.857
## Wrapped with gzip_uu ##


begin 664 bkpatch31784
M'XL(`/1D\ST``\U4WV_3,!!^KO^*D_;"1)/X[/Q&164;@FE(5$5[KCS'+!%-
M7"5N-]3T?\=)JU)*Q\3$`VFDL\YW]WUW]Z5G<-NH.AT(62IR!A]U8]*!U)62
MIE@)5^K2O:OMQ51K>^'ENE3>Q8U7%HUTF!L0>S411N:P4G63#M#E>X_YOE#I
M8/K^P^VG=U-"1B.XS$5UK[XH`Z,1,;I>B7G6C(7)Y[IR32VJIE2F!VWWH2VC
ME-E?@!&G0=AB2/VHE9@A"A]51ID?AS[I^(^/>1]5048CC%B`V/J,84BN`-TX
MB(`R#YE'(V`\Y3S%Q*$LI11.%H77"`XE%_!O&[@D$C2HA10I+!L%I<Z6<S5;
M%U5AANJQ,)LAK.5<B6JY&';.S6P;`I5^`%';#"%KW9`;\%D2(9G\'#=Q_O(A
MA`I*WC[38E87W=8]F8O:ZYB[\J!9G]*@]3ERUL9W@F&<?(UY1%$$R>G!/EG/
M[BVFR#F&;6"/K-?2B>#G5?5BQJ0LJGL]5G.CW'SY-%-*$1.KL;"U6Z:\5QCR
MWP06_EE@$3C(_F>%;=?P&9SZH7^M8B:G-O("X5VA[X/]-#'@=ESDVMH8D#1&
MF$)"41F8S3IR?2,[@KWCU4H7V7F7&*!-N-[937]B]G08>YQ\_J9+#-D6,>36
M[A"[JA:RF\\OD)UC![FVN2&&/6AGF04]C#I.LV#[/TF9*_FM69:C.$RL<E1`
*?@!L=#$;D@4`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.858.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.858, 2002-12-07 23:41:49-02:00, acme@conectiva.com.br
  o istallion: use module_{init,exit}, {cleanup,init}_module now are macros


 istallion.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Sun Dec  8 13:27:41 2002
+++ b/drivers/char/istallion.c	Sun Dec  8 13:27:41 2002
@@ -796,7 +796,6 @@
  *	not increase character latency by much either...
  */
 static struct timer_list stli_timerlist = TIMER_INITIALIZER(stli_poll, 0, 0);
-};
 
 static int	stli_timeron;
 
@@ -813,7 +812,7 @@
  *	Loadable module initialization stuff.
  */
 
-int init_module()
+static int __init istallion_module_init(void)
 {
 	unsigned long	flags;
 
@@ -831,7 +830,7 @@
 
 /*****************************************************************************/
 
-void cleanup_module()
+static void __exit istallion_module_exit(void)
 {
 	stlibrd_t	*brdp;
 	stliport_t	*portp;
@@ -897,6 +896,9 @@
 
 	restore_flags(flags);
 }
+
+module_init(istallion_module_init);
+module_exit(istallion_module_exit);
 
 /*****************************************************************************/
 

===================================================================


This BitKeeper patch contains the following changesets:
1.858
## Wrapped with gzip_uu ##


begin 664 bkpatch31752
M'XL(`.UD\ST``\U476_3,!1]KG_%E?;"1)OX*Y^HJ&Q#,`V)JFA/@"K',20B
MB:?$Z4#+_CM.6KIJZU;Q\4`2R=*]/N?>XWN<([AL5!V/A"P5.H*WNC'Q2.I*
M29.OA"-UZ22U32RTM@DWTZ5R3R[<,F_DA#H>LJFY,#*#E:J;>$0<MHV8'U<J
M'BU>O[E\]VJ!T'0*IYFHOJH/RL!TBHRN5Z)(FYDP6:$KQ]2B:DIEAJ+==FM'
M,:;V]4C`L.=WQ,<\Z"1)"1&<J!13'OH<]?W/[O=]CX50'&+"&(DZ3J.`H#,@
M3NB%@*E+J(L#H"SF).;1!-,88]A+"L\)3#`Z@7\KX!1)T)`W1A1%KJL8VD9!
MJ=.V4,N;O,K-6'W/S>T8;F2A1-5>C?O@[7*]!2I]#:*V""%KW:`+X)1:UOG=
MF:/);SX(88'1RP,ZTSKO1^_*3-3NMGU'[LCF&/..L,@+NL1/0IR$B<*,IH'D
M^X_X:=+U&#GA7L>B"+/!6H\A#COM[P2@55[K66F9G:NF=53:?OQ5[O-!&9QB
M%E+6T<!CT>!&XC\PH_>T&3V8L/_>C.LYO8=)?3U\UESS1T?V!T8]"Z((['T.
M[?D1=+Y>+*/))>25@>6R[^].T*;1(?ILI?/TV&(9'[##LL'V*0ONQ3X$]]$-
M^#RT]1GZA'9Y]U8[?H%VX7M)[9[M3U1F2GYKVG*:LB^)2'R)?@)56"H;L@4`
!````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.859.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.859, 2002-12-07 23:42:18-02:00, acme@conectiva.com.br
  o stallion: use module_{init,exit}, {cleanup,init}_module now are macros


 stallion.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Sun Dec  8 13:27:33 2002
+++ b/drivers/char/stallion.c	Sun Dec  8 13:27:33 2002
@@ -757,7 +757,7 @@
  *	Loadable module initialization stuff.
  */
 
-int init_module()
+static int __init stallion_module_init(void)
 {
 	unsigned long	flags;
 
@@ -775,7 +775,7 @@
 
 /*****************************************************************************/
 
-void cleanup_module()
+static void __exit stallion_module_exit(void)
 {
 	stlbrd_t	*brdp;
 	stlpanel_t	*panelp;
@@ -850,6 +850,9 @@
 
 	restore_flags(flags);
 }
+
+module_init(stallion_module_init);
+module_exit(stallion_module_exit);
 
 /*****************************************************************************/
 

===================================================================


This BitKeeper patch contains the following changesets:
1.859
## Wrapped with gzip_uu ##


begin 664 bkpatch31720
M'XL(`.5D\ST``\U476^;,!1]CG_%E?JR:@%L8P-ARI2UG;JJE1IEZM,V1:YQ
M!QK@"$RZJ?2_SY`TB]JTT3X>!DB6[KWGW'-]CSB`JUI5\4#(0J$#^*!K$P^D
M+I4TV5*X4A?N=643,ZUMPDMUH;RC<Z_(:NE0ER.;F@HC4UBJJHX'Q/4W$?-C
MH>+![/WIU<6[&4+C,1RGHORJ/BH#XS$RNEJ*/*DGPJ2Y+EU3B;(NE.F;MIO2
MEF),[<M)Z&,>M"3`+&PE20@1C*@$4Q8%#'7Z)X]U/V(A%$>8,,)&+:/4@DZ`
MN!$?`:8>H1X.@?HQHS&)'$QCC&$G*;PFX&!T!/]V@&,D04-M1)YGNHRAJ144
M.FER-;_+RLP,U??,W`_A3N9*E,UBV`7OYZL2*/4MB,HBA*QTC<Z!$<X9FOZZ
M<N3\YH,0%AB]W3-F4F7=YCV9BLI[4._*K:$9QKP-6.#S=H1Y>',MI1I1GA#)
M=U_PBYSK'5+2<8ZHW_OJ&<!^E_V5>K3,*CTI++&[J!M7)<VGAVY?]LW`*/8C
MZK><AA'O?4CX$QOREVW(P:'_NPU7.[H$I[KM/VNKZ7/K^@.'GH0!!H+.5H>E
M,IF$K#0PGW>Z-G.L]?7!5TN=)8<6&D8]M#_6T"YEL=V,3[!=<(T]BS@%'WU&
FV[2[>AV^0=OH792V9//'E*F2W^JF&/,;(01G#/T$=*A0?9\%````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.860.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.860, 2002-12-08 00:57:30-02:00, acme@conectiva.com.br
  o cdrom/gscd: fixup printk format specifier


 gscd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/cdrom/gscd.c b/drivers/cdrom/gscd.c
--- a/drivers/cdrom/gscd.c	Sun Dec  8 13:27:26 2002
+++ b/drivers/cdrom/gscd.c	Sun Dec  8 13:27:26 2002
@@ -268,7 +268,7 @@
 		goto out;
 
 	if (req->cmd != READ) {
-		printk("GSCD: bad cmd %d\n", rq_data_dir(req));
+		printk("GSCD: bad cmd %lu\n", rq_data_dir(req));
 		end_request(req, 0);
 		goto repeat;
 	}

===================================================================


This BitKeeper patch contains the following changesets:
1.860
## Wrapped with gzip_uu ##


begin 664 bkpatch31688
M'XL(`-YD\ST``\V4;6O;,!#'7UN?XF@9M&RQ3P]^B$=&UF2THX.%E+[:1E$E
MI3:-K516L@W\X>LFK!E=MK"R%Y,$`MUQ][^['SJ$R\:X/)"J,N00SFSC\T#9
MVBA?KF2H;!5>N\XPM;8S1(6M3'1R'E5EHWHLC$EGFDBO"E@9U^0!#?GCB_^^
M,'DP?7=Z^>'ME)#!`$:%K&_,A?$P&!!OW4K.=3.4OIC;.O1.UDUE_#II^^C:
M,D36[9BF'..DI0F*M%544RH%-1J9R!)!'O0/G^I^$H4RS)`*1K-6T#@69`PT
MS!($9!%E$6:`F,=ISK&'+$>$G4'A)84>DA/XMP6,B`(+2CM;13>-TCG,RF_+
M!2Q<6?M;F%E720_-PJAR5AI'SD%@IYU,METEO;]<A*!$\F9/)=J5#\.-MMI"
M]5-1`BFV7'`6M\)0CDKTXWYFV$S3W0W\?<#U@%B<LK2E&8^S-32[O/?S\WS1
M9%4Z.^R:782+9AD:O?ST(]67/TBGM&.+][$;<,8X7[/%?T&+I7O1HO\!6ION
M?X2>^[H^'2J3G8-X!G)CEE*@Y/WF"H*-BJ.#TXO1.(=KJ4%5&E[,EY_K@U?@
G[JZT]/)*E^[(F;OCX]?;+T<51MTVRVJ0($]BWI^1>_;,-A?.!```
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.861.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.861, 2002-12-08 00:58:07-02:00, acme@conectiva.com.br
  o appletalk/cops: add missing linux/spinlock include


 cops.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/net/appletalk/cops.c b/drivers/net/appletalk/cops.c
--- a/drivers/net/appletalk/cops.c	Sun Dec  8 13:27:20 2002
+++ b/drivers/net/appletalk/cops.c	Sun Dec  8 13:27:20 2002
@@ -68,6 +68,7 @@
 #include <linux/if_ltalk.h>	/* For ltalk_setup() */
 #include <linux/delay.h>	/* For udelay() */
 #include <linux/atalk.h>
+#include <linux/spinlock.h>
 
 #include <asm/system.h>
 #include <asm/bitops.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.861
## Wrapped with gzip_uu ##


begin 664 bkpatch31656
M'XL(`-AD\ST``]5476_4,!!\/O^*E>X1)=EU?(D3D:JT($!%XG2H/\!UK":Z
M)(YBWP%2?CSN4;6TE)[X>,'VD]<>S\R.O(1+9Z9RH71OV!+>6>?+A;:#T;[=
MJUC;/KZ:0F%C;2@DC>U-<G:1]*W3$8]7+)36RNL&]F9RY8+B]&['?QU-N=B\
M>7OYX=6&L:J"\T8-U^:3\5!5S-MIK[K:G2K?=':(_:0&UQM_>'2^.SIS1![F
MBO(45]E,&8I\UE03*4&F1BYD)M@-_]/'O!^A$$>)?!5P9H$R0_8:*)89`?*$
M>((2$,N5+#&/D)>(\"0HO""(D)W!OQ5PSC184./8!81NFV@[NA)474/PVK7#
M-73ML/N2N+$=.JNWT`ZZV]6&74`0(R5;W]O+HM\<C*%"=G)$4CVU-UU.!N.3
MAT1C_8-*@2CFX'0A9X-&B!2%UJK0**Z>=O0X\&WG)*9S6A12'-+TW*WC`?M[
M,;_(W'$Q%/1PS(CF-!><#C&DGU.8_E\I_-Z8CQ!-GP\KI&K];(_^(*7O<P1B
BR]M'X>5#,G%S<O\?Z<;HK=OU%:594%9P]@UK3$'YZP0`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.862.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.862, 2002-12-08 00:59:07-02:00, acme@conectiva.com.br
  o sound/mpu401: attach_mpu returns int


 mpu401.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/sound/oss/mpu401.h b/sound/oss/mpu401.h
--- a/sound/oss/mpu401.h	Sun Dec  8 13:27:13 2002
+++ b/sound/oss/mpu401.h	Sun Dec  8 13:27:13 2002
@@ -7,7 +7,7 @@
 
 /*	From mpu401.c */
 int probe_mpu401(struct address_info *hw_config);
-void attach_mpu401(struct address_info * hw_config, struct module *owner);
+int attach_mpu401(struct address_info * hw_config, struct module *owner);
 void unload_mpu401(struct address_info *hw_info);
 
 int intchk_mpu401(void *dev_id);

===================================================================


This BitKeeper patch contains the following changesets:
1.862
## Wrapped with gzip_uu ##


begin 664 bkpatch31623
M'XL(`-%D\ST``\5476O;,!1]CG[%A;YLW6)?R?)'/#*RMF,;'2QD]#FH\FWM
M+;:*)"<,_..G9*7-VHZP#Y@D)*1[.3KWZ*`CN'!DRY'2+;$C>&^<+T?:=*1]
MLU:1-FUT:4-@84P(Q+5I*3XYC]O&Z;&(4A9"<^5U#6NRKASQ*+D[\=]NJ!PM
MWKZ[^/AFP=AT"J>UZJ[I,WF83IDW=JU6E9LI7Z],%WFK.M>2WUTZW*4.`E&$
MGO(\P30;>(8R'S2O.%>24X5"%IED6_ZSA[P?H'"!!8JTP'R06!0%.P,>%9D`
M%#$7,1:`6*:3$O,QBA(1G@2%%QS&R$[@WQ9PRC08<*;OJKB]Z27R$I3W2M?+
ML`5+OK>=@Z;S[!PDS[*4S>\%9>/?;(RA0O;Z0!&5;;;O&N_3BNJ]BL(>!RZ"
MK`-/\H+CA"XG.4_5)'M:O>$'E''N9[C;MYE@,DB9!SVV?GF<>]@X?T.956I-
M7V:N=Q15]"NJ*#$)*XHL4"VR?&<C^<A$R4$3\?]LHIW.GV!L-[L13#%_0O(_
ML-891^#LPVX.=^U1"(C/G+>]#H=59<FY9=-=&3B&>K,,(ETUUR_A-J$U5;\B
@.#:;CNSS5_=?C:Y)?W5].Q4)D:0L8=\!)ZUY%\8$````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.863.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.863, 2002-12-08 01:00:36-02:00, acme@conectiva.com.br
  o net/dl2k: test_bit expects pointer to long


 dl2k.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/net/dl2k.c b/drivers/net/dl2k.c
--- a/drivers/net/dl2k.c	Sun Dec  8 13:27:06 2002
+++ b/drivers/net/dl2k.c	Sun Dec  8 13:27:06 2002
@@ -1142,7 +1142,8 @@
 	u16 rx_mode = 0;
 	int i;
 	int bit;
-	int index, crc;
+	int index;
+	long crc;
 	struct dev_mc_list *mclist;
 	struct netdev_private *np = dev->priv;
 	

===================================================================


This BitKeeper patch contains the following changesets:
1.863
## Wrapped with gzip_uu ##


begin 664 bkpatch31589
M'XL(`,ID\ST``\U446O;,!!^MG[%01^'[3M9LA,7CZSMV$8'"QE]+HJDQ2:Q
M'6PMZ<`_?K+'&FC3P48?)@DD=*?[OKO[T`7<];;+`Z5KRR[@8]N[/-!M8[6K
M#BK2;1VM.V]8M:TWQ&5;V_CJ-JZK7H<\DLR;ELKI$@ZVZ_.`HN3QQOW8VSQ8
MO?]P]_G=BK&B@.M2-1O[U3HH"N;:[J!VIE\H5^[:)G*=:OK:N@ET>'0=."+W
M4U*6H$P'2E%D@R9#I`19@US,4L%&_HNGO)]$(8XSY'*.V2`H326[`8IF:0+(
M8^(QS@`I1\R3-$3N#W`V*+PA")%=P>LF<,TTM-!8%YL=W^;@;._NUY4#^[#W
M^#WLVZIQMO.PX-$V[!8$)31GRU-96?B7@S%4R-["?FS8^3Q,5XVMC7\SB_0I
MH3F-J:0"4S%0IC,C9M\,28N2GZ_=2]&FSB2("1]2/N<XJ>6Y[RB;UZ?*K#FJ
MSMSO;;-9F%W5;">V[O@B6_)4A>24>+9"BDE'_+F,^)]EQ"&D_T%&ORK^!<+N
M."TOB^69XO^#N&Z(A`1BGZ:=L\!#0]48^W#)@A$==*<O3W^(+JW>]M_K8BW]
-"UPK]A-MG=;?GP0`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.864.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.864, 2002-12-08 09:37:17-02:00, acme@conectiva.com.br
  o appletalk/cops: s/spinlock_init/spin_lock_init/g


 cops.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/net/appletalk/cops.c b/drivers/net/appletalk/cops.c
--- a/drivers/net/appletalk/cops.c	Sun Dec  8 13:26:59 2002
+++ b/drivers/net/appletalk/cops.c	Sun Dec  8 13:26:59 2002
@@ -321,7 +321,7 @@
 
         lp = (struct cops_local *)dev->priv;
         memset(lp, 0, sizeof(struct cops_local));
-        spinlock_init(&lp->lock);
+        spin_lock_init(&lp->lock);
 
 	/* Copy local board variable to lp struct. */
 	lp->board               = board;

===================================================================


This BitKeeper patch contains the following changesets:
1.864
## Wrapped with gzip_uu ##


begin 664 bkpatch31557
M'XL(`,-D\ST``\V4VVK<,!"&KU=/(0B4EF![1I*/Q2%-4MJ20I<MN0Y:6<1F
M;<M8ZI:"'[Y:MV23-,WV=%'98,8C_9Y_YL-'],KJL5A(U6ER1-\:ZXJ%,KU6
MKMG*4)DN7(\^L3+&)Z+:=#HZNXRZQJJ`A3'QJ:5TJJ9;/=IB@2&_?>.^#+I8
MK%Z_N7K_:D5(6=+S6O8W^J-VM"R),^-6MI4]E:YN31^Z4?:VTV[^Z'2[=6(`
MS%\QIASB9,($1#HIK!"E0%T!$UDBR*[^TX=U/U!!!AEP`)Y,`CGFY()BZ`]3
M8!&R"#(*><'3`M,`6`%`'Q6EQT@#(&?TWQHX)XH:*H>A]0KM)E)FL`6UD1V:
MOC5J<]WTC9NCZWUX0RZIMP(Q6>Z;2X+?7(2`!')RP%`U-KL91[UVT?TR0W7'
MHP`0D^]SGDT:M!`<A%(R5R#6C_?SL/!N;H@\13%Y]32?67KJU&&\_M[,3XC[
M)3/`8@_BQ/,\$S.$R'Y@4!QD$/\C!N>Q?*#!^'F^/5/+)R?T!XQ><"8HDG??
I'O3[NE_,\V?M$)SLPA<O][\F56NUL9^Z,H_7:1)G%?D*()!0I/8$````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.865.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.865, 2002-12-08 10:50:38-02:00, acme@conectiva.com.br
  o net/dl2k: set_bit requires a long pointer


 dl2k.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/net/dl2k.c b/drivers/net/dl2k.c
--- a/drivers/net/dl2k.c	Sun Dec  8 13:26:52 2002
+++ b/drivers/net/dl2k.c	Sun Dec  8 13:26:52 2002
@@ -1142,8 +1142,7 @@
 	u16 rx_mode = 0;
 	int i;
 	int bit;
-	int index;
-	long crc;
+	long index, crc;
 	struct dev_mc_list *mclist;
 	struct netdev_private *np = dev->priv;
 	

===================================================================


This BitKeeper patch contains the following changesets:
1.865
## Wrapped with gzip_uu ##


begin 664 bkpatch31525
M'XL(`+QD\ST``\V4P6K<,!"&S]93#.38KCTC2[;CXI(F*6U)(<N6G(LB*[')
MVMK*RK8!/WQEEV0AV;2TY%#;(-`,,_\_\^$#N!B,*R.E.\,.X*,=?!EIVQOM
MVZV*M>WB2Q<"*VM#(&EL9Y+CLZ1K![W@L60AM%1>-[`U;B@CBM.'&W^W,66T
M>O_AXO.[%6-5!2>-ZJ_-%^.AJIBW;JO6]7"D?+.V?>R=ZH?.^+GI^)`Z<D0>
M7DEYBC(;*4.1CYIJ(B7(U,A%D0DVZ3]ZK/M1%>)8$*4YY:.@4(R=`L5%)@%Y
M0CS!`@A+B65:+)"7B+"W*+PB6"`[AI<U<,(T6.B-3^HUOREA,/[K9>O!F6^W
MK3,#*`A-KF%CV]X;Q\X@>*",+7=398N_?!A#A>PM;*9][;=1NW;:;'(O+-8[
M/X<T.<D$9F*D7.>U**YJD@8EWS^ZYZK-B^$24S%F7$HYP_(T=Z+FY:4^@\YO
MI&**F/(@]9#CS!`73Q`2?T2(_P<(_9KV.2S<]_D+2"SW#/X?P#HE$A(X^Q3.
G#(A%<^>VK\V/UZ"=?K/[<^C&Z)OAMJLTOTK3&HG]!/?F8>"5!```
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.866.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.866, 2002-12-08 10:51:36-02:00, acme@conectiva.com.br
  o oss/wf_midi: fix up header cleanups, add include <linux/interrupt.h>


 wf_midi.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/sound/oss/wf_midi.c b/sound/oss/wf_midi.c
--- a/sound/oss/wf_midi.c	Sun Dec  8 13:26:46 2002
+++ b/sound/oss/wf_midi.c	Sun Dec  8 13:26:46 2002
@@ -50,6 +50,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
 

===================================================================


This BitKeeper patch contains the following changesets:
1.866
## Wrapped with gzip_uu ##


begin 664 bkpatch31493
M'XL(`+9D\ST``]5476_3,!1]KG_%E?H(37SMQ$TC,I4-!&A(5$5[1I[MDH@D
MCFRG'5)^/%D891J%B8\7;#_Y6N>>>\Z1YW#EC<MG4C6&S.&U]2&?*=L:%:J]
MC)1MHFLW%K;6CH6XM(V)SR_CIO)JP:*4C*6-#*J$O7$^GV'$CS?A<V?RV?;E
MJZNWS[>$%`5<E++]:-Z;`$5!@G5[66N_EJ&L;1L%)UO?F#`U'8Y/!T8I&W>*
M2TY3,:"@R7)0J!%E@D93EF0B(;?\UP]Y/T!!1C-D*>79D"!'05X`1ID00%F,
M+*89(,U3S+E84)93"B=!X0G"@I)S^+<#7!`%%JSW\6'WH:ETE<.NNH&^@])(
M;1RHVLBV[_Q3D%I#U:JZUP:>U57;W\15&XQS?1>B\HQ<0H)IPLGFN^!D\9N+
M$"HI.7MD2.VJ6]]C;_M6?R,>J7LC)Q3IP.F*IX/8I5R@6*$2UV(TX[2\PU>L
M>T+<X=VYAYP/R:@CGQ)UXO'CV?HKUJ0[2*/*4!NW;J2:`']&F:[8"C,<LS;P
M92;8%+@?X\;_^[A-?KR#A3M,9XS/YI0U?Y#"-RD#)/-?]3]^.*HTZI/OFP*U
.QE0EC'P!]C9[M=X$````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.867.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.867, 2002-12-08 10:56:09-02:00, acme@conectiva.com.br
  o scsi/ini9100u: fix up header cleanups: add include <linux/interrupt.h>
  
  Also clean up the includes a bit.


 ini9100u.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


diff -Nru a/drivers/scsi/ini9100u.c b/drivers/scsi/ini9100u.c
--- a/drivers/scsi/ini9100u.c	Sun Dec  8 13:26:38 2002
+++ b/drivers/scsi/ini9100u.c	Sun Dec  8 13:26:38 2002
@@ -115,9 +115,6 @@
 #endif
 
 #include <linux/module.h>
-
-#include <stdarg.h>
-#include <asm/irq.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
@@ -126,16 +123,18 @@
 #include <linux/spinlock.h>
 #include <linux/stat.h>
 #include <linux/config.h>
-
 #include <linux/kernel.h>
+#include <linux/proc_fs.h>
 #include <linux/string.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
-#include <linux/proc_fs.h>
+#include <linux/slab.h>
+
 #include <asm/io.h>
+
 #include "scsi.h"
 #include "hosts.h"
-#include <linux/slab.h>
 #include "ini9100u.h"
 
 #ifdef DEBUG_i91u

===================================================================


This BitKeeper patch contains the following changesets:
1.867
## Wrapped with gzip_uu ##


begin 664 bkpatch31461
M'XL(`*YD\ST``]U4VVK<,!!]7GW%0![+VC.Z>&W3#;F5MJ30)25O@:*5E=K4
M:R^6G*;@CX^\:9,FV6SHY:FV0.`Y<WQ&YZ`].'>VRR?:K"S;@W>M\_G$M(TU
MOKK2D6E7T;(+A;.V#86X;%<V/CJ-5Y4S4QXI%DH+[4T)5[9S^80B<??%?U_;
M?'+VYNWYA\,SQN9S."YU\\5^LA[F<^;;[DK7A3O0OJS;)O*=;MS*^LU/ASOH
MP!%Y>!7-!*IDH`3E;#!4$&E)MD`NTT2R4?_!8]V/6(AC2ER12`9)2@IV`A2E
MR0R0Q\1C3($P5TF.V11YC@A;2>$5P139$?S;`8Z9@1:<<55<-55&B'T.E]4U
M]&LHK2YL!Z:VNNG7+@==%%`UINX+"Z_KJNFO0Y.W7=>O?53N!ZJP#FO7WO:,
M'+ZT/UL<:%A6/F*G('DB%%O<.\.FO_DPAAK9_@NG4735&)#XP7R1^>5L)&(Z
M"($B&\REG"U5DAIM,HW+=+L/.SE_6)U@L%K.^&P3OV<:7@[C7ZEGI2D/:N>C
MPNZ6C"&:4@HE!JF4S#;I)'P2SF1W.!5,D_\EG!OG/L*T^[99(6R+YTS\@]R>
M$*40+@'B&1![3P+#MO=(^;IKS>=+-^H."-J">##;"0EY2R:!/X&Z6B]'U,4(
@4`%W,38$9^^O45-:\]7UJWDA4Y'14K$;8&.=;J(%````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.868.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.868, 2002-12-08 11:00:09-02:00, acme@conectiva.com.br
  o scsi/pci2220i: fix up header cleanups: add include <linux/interrupt.h>


 pci2220i.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/scsi/pci2220i.c b/drivers/scsi/pci2220i.c
--- a/drivers/scsi/pci2220i.c	Sun Dec  8 13:26:31 2002
+++ b/drivers/scsi/pci2220i.c	Sun Dec  8 13:26:31 2002
@@ -38,6 +38,7 @@
 
 //#define DEBUG 1
 
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -52,9 +53,11 @@
 #include <linux/blk.h>
 #include <linux/timer.h>
 #include <linux/spinlock.h>
+
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
+
 #include "scsi.h"
 #include "hosts.h"
 #include "pci2220i.h"

===================================================================


This BitKeeper patch contains the following changesets:
1.868
## Wrapped with gzip_uu ##


begin 664 bkpatch31429
M'XL(`*=D\ST``]546V_3,!1^KG_%D?J(FAQ?XT1T*AL(IB%1%>V-%]=Q240N
M5>R4(>7'DP6I&V/KQ.4%V_*Q?.SC[YSOD^=P[5V7S8RM'9G#N]:';&;;QME0
M'DQDVSK:=J-CT[:C(R[:VL7G5W%=>KM@D22C:VV"+>#@.I_-:,2/.^';WF6S
MS9NWU^]?;0A9+N&B,,UG]]$%6"Y):+N#J7*_,J&HVB8*G6E\[<+TZ'`\.C!$
M-G9)$XY2#52A2`9+<TJ-H"Y')K02Y!;_ZB'N!U$H0TV95)@.@BDNR6N@D58:
MD,64Q:B!T@PQPW2!;%S`HT'A!84%DG/XMPE<$`LM>.O+>&]+QAB6&>S*&^CW
M4#B3NPYLY4S3[WT&)L^A;&S5YPY>5F73W\1E$US7]?L0%6?D"@1/*"?KNY*3
MQ6\V0M`@.7LFS;PK;YF/?P(>V7M)"T0]R%3K<5:2[K:)2G=\IY$]7M^3(2<*
M.2+*0:'4>I+5$Q>>%]G?@">%+5:5#U'N3B-&)JD07/)!)EHED^@H_T5S\K3F
M^'^@N1^,?(!%]W4:HX;63Y'S!W*\%`B4S$]AN)1B//)IM,EDCW^1+9S]XOMZ
02;><REREY#L*:T@-^00`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.869.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.869, 2002-12-08 11:01:42-02:00, acme@conectiva.com.br
  o scsi/pci2000: fix up header includes: add include <linux/interrupt.h>


 pci2000.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)


diff -Nru a/drivers/scsi/pci2000.c b/drivers/scsi/pci2000.c
--- a/drivers/scsi/pci2000.c	Sun Dec  8 13:26:23 2002
+++ b/drivers/scsi/pci2000.c	Sun Dec  8 13:26:23 2002
@@ -35,8 +35,9 @@
  ****************************************************************************/
 #define PCI2000_VERSION		"1.20"
 
+#include <linux/blk.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
-
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -45,15 +46,15 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
+#include <linux/stat.h>
+#include <linux/spinlock.h>
+
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <linux/blk.h>
+
 #include "scsi.h"
 #include "hosts.h"
-#include <linux/stat.h>
-#include <linux/spinlock.h>
-
 #include "pci2000.h"
 #include "psi_roy.h"
 

===================================================================


This BitKeeper patch contains the following changesets:
1.869
## Wrapped with gzip_uu ##


begin 664 bkpatch31397
M'XL(`)]D\ST``\U4VX[3,!!]KK]BI#ZB)#.V<VE$5V6W"%:+1%6T;[RXCB'1
MYE+%;EFD?/PF`<I22E=<'K`M2YX9'Y^9.?(4;JUITXG2E6%3>-U8ETYT4QOM
MBKWR=5/YF[9WK)NF=P1Y4YG@\B:H"JL][H>L=ZV4TSGL36O3"?GB8'&?MR:=
MK%^^NGWS8LW8?`Y7N:H_FG?&P7S.7-/N59G9A7)YV=2^:U5M*^/&1[M#:,<1
M>3]#B@6&44<1RKC3E!$I229#+I-(LH'_XICW$0IQ3$@@XJR3(B;!ED!^$LT`
M>4`\P`2(4J14<@]YB@@G0>$9@8?L$OYM`E=,0P-6VR+8ZJ*_@RE\*.YAMX7<
MJ,RT4-2ZW&7&IJ"R[-L)GI=%O;L/BMJ9MMUMG9]?L!N0,L&(K;Y7G'F_.1A#
MA>SBB2RSMA@:'SSF[>M'*4O$I!-<RJC3<2CBT&Q4J`5R'9\N[SG(KPTD,>M$
M2!2-HCH=_[3"_H8ZRW6^**WS,W.6+_*0I!2A&'`H'`5'>*PW,3NOMPB\\#_7
MVY=VO`6O_32N7C^K7W3F#Y1X+6+@;'I$85/>#8\?FW]@MA0S('8M8Q`_!5JG
MW"D`NRWJLM$C^'NV#&E`&/?A)'NDPQ>G<Z/O[*Z:QR9*XH02]@!K;I_>4`4`
!````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.870.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.870, 2002-12-08 11:04:04-02:00, acme@conectiva.com.br
  o oss/maui: fix up header cleanups: add include <linux/interrupt.h>


 maui.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/sound/oss/maui.c b/sound/oss/maui.c
--- a/sound/oss/maui.c	Sun Dec  8 13:26:17 2002
+++ b/sound/oss/maui.c	Sun Dec  8 13:26:17 2002
@@ -24,6 +24,7 @@
  *					* Older versions will cause problems.
  */
 
+#include <linux/interrupt.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.870
## Wrapped with gzip_uu ##


begin 664 bkpatch31365
M'XL(`)ED\ST``]5446_3,!!^KG_%27U$3>YL)VDC,I4-!&A(5$7[`<;Q2$02
M5[93"LJ/)PNCH*YB8N(%^^P'W^F[[^X^>0XWWKA\IG1KV!S>6!_RF;:=T:'>
MJTC;-OKH1L?6VM$15[8U\>5UW-9>+WB4L-&U44%7L#?.YS.*Q/$E?-V9?+9]
M]?KFW8LM8T4!5Y7J/ID/)D!1L&#=7C6E7ZM0-;:+@E.=;TV8D@['T($C\G$G
ME`E,TH%2E-F@J212DDR)7"Y3R>[XKT]YGZ`0QR4)),D'*9>8LI=`T3)#0!X3
MCW$)1#G*T1;(<T0X"PK/"!;(+N'?%G#%-%BPWL>MZNL<;NL#]#NHC"J-`]T8
MU?4[GX,J2Z@[W?2E@>=-W?6'N.Z"<:[?A:BZ8-<@$TG(-K^ZS19_N1A#A>SB
MD0I+5]\-/?:V[\J)=:1_*U8BK@9*9,('K3/-C5JI6RV("W6^L<,/H)\MN`>[
M'YI$&L:#.`GI-/)Q/3V=+-L99P[KZ8[TM_,L1YZ"5H*C'%+BJ9BD)1\(B_YO
M84W]?P\+]V6R42B;!Z-X@MC>\A2(S?^4_/BIZ,KHS[YO"Y6A2(1(V7>'$V'/
$P@0`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.871.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.871, 2002-12-08 11:13:45-02:00, acme@conectiva.com.br
  o net/wan/hostess_sv11: remove unused variable flags


 hostess_sv11.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/net/wan/hostess_sv11.c b/drivers/net/wan/hostess_sv11.c
--- a/drivers/net/wan/hostess_sv11.c	Sun Dec  8 13:26:10 2002
+++ b/drivers/net/wan/hostess_sv11.c	Sun Dec  8 13:26:10 2002
@@ -211,7 +211,6 @@
 {
 	struct z8530_dev *dev;
 	struct sv11_device *sv;
-	unsigned long flags;
 	
 	/*
 	 *	Get the needed I/O space

===================================================================


This BitKeeper patch contains the following changesets:
1.871
## Wrapped with gzip_uu ##


begin 664 bkpatch31333
M'XL(`))D\ST``\V4WVO;,!#'GZ._XJ"/P_:=+/^H(2-K.S;H8"&C3V,,15;B
M$-L:ENQNX#^^JL?:TH:F&WV8I`>AD^[N>_=!)W!E=5?,I&HT.X&/QKIBIDRK
ME=L-,E2F"=>=-ZR,\8:H,HV.SBZC9F=5P,.$>=-2.E7!H#M;S"B,[T[<KQ^Z
MF*W>?[CZ]&[%V'P.YY5LM_J+=C"?,V>Z0=:E74A7U:8-72=;VV@W!1WOKHX<
MD?N94!9CDHZ4HLA&1261%*1+Y")/!;O-?_$X[T=>B&-.,0H4HT@$(;L`"O.,
M`'E$/,(<B`J*"Y$$R`M$..@4WA`$R,[@=06<,P4&6NVB:]GZ.ENGK?UN!Y\2
M=+HQ@X:^[:TN89#=3JYK#9M:;BV[!!&?YBE;WI>7!7\Y&$.)[.T1266WN^UR
M="C)4#W0*1!IC-'K'?5:)F(C%?'\5.9R<[BF+W']NWL4"QR19T),1#W_[CAF
MKR&)R5JVB_JGZ;;]/NSW?1_ZK=]\_1/[VXOT$4]]K#S.1P\(BHG.[`F;^#R;
M"`']3VQ.G?H,07<]+8_:\DC3_@'>"TX"Z/XO4I56>]LW\R3+5<JU9C?FY2`I
$YP0`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.872.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.872, 2002-12-08 11:25:37-02:00, acme@conectiva.com.br
  o net/wan/sdla_fr: test_bit and friends require a long pointer


 sdla_fr.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)


diff -Nru a/drivers/net/wan/sdla_fr.c b/drivers/net/wan/sdla_fr.c
--- a/drivers/net/wan/sdla_fr.c	Sun Dec  8 13:26:03 2002
+++ b/drivers/net/wan/sdla_fr.c	Sun Dec  8 13:26:03 2002
@@ -225,10 +225,10 @@
 	sdla_t *card;			/* -> owner */
 	unsigned route_flag;		/* Add/Rem dest addr in route tables */
 	unsigned inarp;			/* Inverse Arp Request status */ 
-	unsigned char inarp_ready;	/* Ready to send requests */
+	long inarp_ready;		/* Ready to send requests */
 	int inarp_interval;		/* Time between InArp Requests */
 	unsigned long inarp_tick;	/* InArp jiffies tick counter */
-	unsigned char interface_down;	/* Bring interface down on disconnect */
+	long interface_down;		/* Bring interface down on disconnect */
       #if defined(LINUX_2_1) || defined(LINUX_2_4)
 	struct net_device_stats ifstats;	/* interface statistics */
       #else
@@ -259,8 +259,8 @@
 
 	u32 ip_local;
 	u32 ip_remote;
-	u8  config_dlci;
-	u32 unconfig_dlci;
+	long config_dlci;
+	long unconfig_dlci;
 
 	/* Whether this interface should be setup as a gateway.
 	 * Used by dynamic route setup code */
@@ -1459,7 +1459,8 @@
         int err;
     	unsigned char *sendpacket;
     	fr508_flags_t* adptr_flags = card->flags;
-	int udp_type, delay_tx_queued=0;
+	int udp_type;
+	long delay_tx_queued = 0;
 	unsigned long smp_flags=0;
 	unsigned char attr = 0;
 
@@ -2811,7 +2812,7 @@
 				chan->name, NIPQUAD(chan->ip_remote));
 
 		}else {
-			printk(KERN_INFO "%s: Route Added Successfully: %u.%u.%u.%U\n",
+			printk(KERN_INFO "%s: Route Added Successfully: %u.%u.%u.%u\n",
 				card->devname,NIPQUAD(chan->ip_remote));
 			chan->route_flag = ROUTE_ADDED;
 		}

===================================================================


This BitKeeper patch contains the following changesets:
1.872
## Wrapped with gzip_uu ##


begin 664 bkpatch31301
M'XL(`(MD\ST``\U4VV[;,`Q]MKZ":%%@Z!9;%]_J(D.OVXH.;9&B;P,,15(2
M+XF<R7*Z`/[X*?9Z6=<NV.5AM@`:H@]Y2!YP&VXJ93*/B[E"V_"AK&SFB5(K
M88LE]T4Y]X?&.09EZ1S!I)RKX.@\F!>5Z%$_0LYUQ:V8P%*9*O.(S^YO[&JA
M,F]P^O[FX^$`H7X?CB=<C]6ULM#O(UN:)9_)ZH#;R:S4OC5<5W-EVZ3-_:\-
MQ9BZ-R()PU'<D!B'22.()(2'1$E,PS0.T9K_P5/>3Z(0BE/""`NC)F1[:8Q.
M@/AI0@'3@-``IT!(1J.,)3U,,XSAV:#PFD`/HR/XMP4<(P$E:&6#6ZZ#2LYX
M/C(96%79?%A8X%K"R!1*RPJ,^E(71@$'EW<,B[+05AET#B%S.=#50Z-1[S<?
MA##'Z.V&XJ0IUO,.GM#UQ:-B0XQ)PT*:1(V4%)-0B8@.XY`S\7QC-T3MID<C
MQIHHC**T5=2+D,T*^\L:D.1+]=D5(=6\U%.U\DLS]NOIIBH(3<@>C4+21!%-
MDU:#9.\G";)?2S"!7OQ_2K";S27TS&U[G*2N7A[3'^CSA%+7)736&:]-7VAN
M%KE17*[V/2_8A<'ZT[4'*L>V)>N*J&`W<'!&6GAK[N".^X@+E<OR5G<1CDSQ
MV`-K#Y0:I-M\I5[/HXL64Z`N6LR<Z:(Y]Z@8YW(FBOWO5[7^X?*$A`[F2+36
MX5P:J.4B7Z_,.XQ4,[[*[=?<<:^5A#Y@AZ0I"5OZG?4\;^&(VNFK\]/!17YV
M\>X2MG:JS.WKVBHXE-(AKVLA5%6-ZMELE<%.[=^=3WKKS<,&%Q,EIE4][[.A
.9$,QE.@;(A%O7QT&````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.873.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.873, 2002-12-08 11:42:11-02:00, acme@conectiva.com.br
  o if_wanpipe_common: test_bit and friends requires a long pointer


 if_wanpipe_common.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/if_wanpipe_common.h b/include/linux/if_wanpipe_common.h
--- a/include/linux/if_wanpipe_common.h	Sun Dec  8 13:25:56 2002
+++ b/include/linux/if_wanpipe_common.h	Sun Dec  8 13:25:56 2002
@@ -33,7 +33,7 @@
 	atomic_t command;
 	atomic_t disconnect;
 	atomic_t driver_busy;
-	unsigned char common_critical;
+	long common_critical;
 	struct timer_list *tx_timer;
 	struct sock *sk;		/* Wanpipe Sock bind's here */ 
 	int   (*func) (struct sk_buff *, netdevice_t *, 

===================================================================


This BitKeeper patch contains the following changesets:
1.873
## Wrapped with gzip_uu ##


begin 664 bkpatch31269
M'XL(`(1D\ST``\V486O;,!"&/T>_XJ`?1VR=+,>N1T;6=FRC@X6,?@Z*?(G%
M;"FSE78#__@J#C30!M*-#289"WSR>_?J'G0!=QVUQ4CIAM@%?'*=+T;:6=+>
MW*M(NR9:M2&P<"X$XLHU%%_=QHWI]%A$*0NAN?*Z@GMJNV*$4?+TQ?_:4C%:
M?/AX]^7]@K'I%*XK93?TC3Q,I\R[]E[593=3OJJ=C7RK;->0'Y+V3UM[P;D(
M,\4LX>FDQPF76:^Q1%02J>1"YA/)]O7/GM?]3`4%SS$1:9+U,@EJ[`8PRK,$
MN(A1Q#P'Q$**`G',1<$YG!2%-PACSJ[@[QJX9AH<F/7R0=FMV=(RB#3.%N"I
M\\N5\:!L">O6D"T[:.G'SK34@8*0>@-;9ZRGEMV"E#*3;'X\:S;^S<$85YR]
M@^V^BZ?-&:OK74EQ;>SN9_RBZ*@ZFLX1$QE,B\NTS_E:I"NM4=%JE>5T^H!?
MJ7[HIA0\ZT7"I1@(._OKGKQ_;XPUQF[<C&I/4;5[K2'.$2\#)3(8"NN`YPLX
M>7863OQOX3PTZBN,VX?A";#-S_?L#PB^22:`[//P'@U%',26NC7>:%6_/=Y<
6NB+]O=LUTX34))N@9(^,EE,Y%04`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.874.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.874, 2002-12-08 11:52:16-02:00, acme@conectiva.com.br
  o wanpipe: test_bit and friends requires a long pointer


 drivers/net/wan/sdlamain.c |    2 +-
 include/linux/wanpipe.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/net/wan/sdlamain.c b/drivers/net/wan/sdlamain.c
--- a/drivers/net/wan/sdlamain.c	Sun Dec  8 13:25:48 2002
+++ b/drivers/net/wan/sdlamain.c	Sun Dec  8 13:25:48 2002
@@ -503,7 +503,7 @@
 		}
 
 	}else{
-		printk(KERN_INFO "%s: Card Configured %i or Piggybacking %i!\n",
+		printk(KERN_INFO "%s: Card Configured %lu or Piggybacking %i!\n",
 			wandev->name,card->configured,card->wandev.piggyback);
 	} 
 
diff -Nru a/include/linux/wanpipe.h b/include/linux/wanpipe.h
--- a/include/linux/wanpipe.h	Sun Dec  8 13:25:48 2002
+++ b/include/linux/wanpipe.h	Sun Dec  8 13:25:48 2002
@@ -358,7 +358,7 @@
 	char in_isr;			/* interrupt-in-service flag */
 	char buff_int_mode_unbusy;	/* flag for carrying out dev_tint */  
 	char dlci_int_mode_unbusy;	/* flag for carrying out dev_tint */
-	char configured;		/* flag for previous configurations */
+	long configured;		/* flag for previous configurations */
 	
 	unsigned short irq_dis_if_send_count; /* Disabling irqs in if_send*/
 	unsigned short irq_dis_poll_count;   /* Disabling irqs in poll routine*/

===================================================================


This BitKeeper patch contains the following changesets:
1.874
## Wrapped with gzip_uu ##


begin 664 bkpatch31237
M'XL(`'QD\ST``]V5;VO;,!#&7UN?XM92&-UBZV39L3,RNJ;=5CK:D-%W@Z+(
M2B+J/YDLIROXP\]Q1EJZ)F'M7HS9Q@++OGONN=_A?;@JE>DY0F:*[,/GHK0]
M1Q:YDE8OA"N+S!V;9F-4%,V&-RLRY1V?>YDN98>Y`6FVAL+*&2R4*7L.NO[Z
MB;V;JYXS.OUT]>7#B)!^'P8SD4_55V6AWR>V,`N1)N61L+.TR%UK1%YFRK9)
MZ_6K-:.4-6>`79\&88TAY=U:8H(H.*J$,AZ%G"SU'SW6_2@*,AJASQEBS3GO
M<G("Z$9=#I1YR#P:`6(O8#T,.Y3U*(4G@\(;!AU*CN'O%C`@$@JX%?E<-[:!
M5:6]'FL+(D]@8K3*DQ*,^EYIHTH0T"2<PKS0N56&G`,/:.R3X;W#I/.'!R%4
M4/)^1U6)T<M&>[FR7J/5*Y-49$+GKGQ0)J<4:[\;\:A.5.0'$YZ,0XPC0=G3
MENX*NVI<T*QU@#YE.V7J7*95HKQ4Y]4/[Y>I[NQA*V*.=<@PXG4\[L8A95$0
MRVC,Q[A!X[:8#P2&-(ZPI7US4;OQ?ZG/Q%2EO3M:WF5AYFT-HMH9-J(^=@/D
M2Y\Q8NV`(/MM/MCV^4#HX#\V'RML+J%C;MNKX7VXI4'/F)Z3@(:`Y&RU.,[<
M-+EO7I^?CBZNSRX^7L+>0=F#@3`)#(I\HJ>540D<I!44!H9Z.KT;"WFC&]4'
M^M6W?.]MR]`&Z'8#]*()(%FCHSA2J6T^J;:3WS"(<1.-+\D/_1:9X#\@9C7'
MCXC9X,1S</%#7.*R6IPVN5QS\<YQO$.8I&(*DP:/N5$+753E^@UA=9&7<.C=
9_W_E3,F;LLKZ,E)C+M`G/P$U_MGLVP<`````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.875.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.875, 2002-12-08 11:54:44-02:00, acme@conectiva.com.br
  o net/wan/sealevel: remove unused flags variable


 sealevel.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/net/wan/sealevel.c b/drivers/net/wan/sealevel.c
--- a/drivers/net/wan/sealevel.c	Sun Dec  8 13:25:41 2002
+++ b/drivers/net/wan/sealevel.c	Sun Dec  8 13:25:41 2002
@@ -211,8 +211,6 @@
 	struct z8530_dev *dev;
 	struct slvl_device *sv;
 	struct slvl_board *b;
-	
-	unsigned long flags;
 	int u;
 	
 	/*

===================================================================


This BitKeeper patch contains the following changesets:
1.875
## Wrapped with gzip_uu ##


begin 664 bkpatch31205
M'XL(`'5D\ST``\V4WVO;,!#'GZ._XJ"/P[9.EFS'D)&U'1MTL)#1I[&'JZS%
M(;8U)-G=P'_\W'1K2]HU[,?#)#T(G71WW[L/.H%+;UPY(]T:=@)OK0_E3-O.
MZ+`=*-:VC:_<9%A;.QF2VK8F.;U(VJW7D8@5FTPK"KJ&P3A?SC!.[T["MR^F
MG*U?O[E\]VK-V&(!9S5U&_/!!%@L6+!NH*;R2PIU8[LX..I\:\(^Z'AW=12<
MBVDJS%.NLA$S+O-18X5($DW%A2PRR6[R7Q[F?>`%!2\P50*S42H^3]DY8%SD
M"KA(4"2\`,12R5+*B(N2<WC2*;Q`B#@[A7\KX(QIL-"9D%Q3EWA#C1E,4X(S
MK1T,]%WO306?&]IX&,AMZ:HQ[`)DFF4I6]V7ED6_.1CCQ-G+(W(JM[WI<'*8
M8*P?Z).<XY@62LU'@RGIG"HQSX0D-7^ZEL?<_NB8E#@JE?)B3]&OWQS'ZF]E
M,&JH6S9?K=OTN[C?]7T\;:?-QY]Q/QW5A"*;XA2J&%4NBOR6PD<,XO,,<HC$
M_\+@;6O>0^2N]VMB:O5,E_Z`T'.!$L3]9Z-KHW>^;Q>5)*UR*=EW/XPY6,@$
"````
`
end

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.876.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.876, 2002-12-08 12:01:30-02:00, acme@conectiva.com.br
  o parport/probe: fix up header cleanups: add include <linux/string.h>


 probe.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/parport/probe.c b/drivers/parport/probe.c
--- a/drivers/parport/probe.c	Sun Dec  8 13:25:34 2002
+++ b/drivers/parport/probe.c	Sun Dec  8 13:25:34 2002
@@ -7,6 +7,7 @@
 
 #include <linux/parport.h>
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <asm/uaccess.h>
 
 static struct {

===================================================================


This BitKeeper patch contains the following changesets:
1.876
## Wrapped with gzip_uu ##


begin 664 bkpatch31173
M'XL(`&YD\ST``]646VO;,!3'GZ-/<2"/P[9NEE4SEUXVMM%!0T8_@"(IM:EM
M&5G..O"'G^-!NH5F9=U>)NE!Z$C_<_NA)=SUUN<+I1N+EO#1]2%?:-=:':J=
MBK5KXHV?#&OG)D-2NL8F5S=)4_4ZHG&*)M-*!5W"SOH^7Y"8'4["M\[FB_7[
M#W>?+]<(%05<EZJ]MU]L@*)`P?F=JDU_H4)9NS8.7K5]8\/L=#Q<'2G&=)HI
MR1A.Q4@$YMFHB2%$<6(-IEP*CO;Q7QS'?:1"*):$I9SSD3,A&'H')):9`$P3
M0A,L@=`<DYSA"$\;#,^*PAL"$497\&\3N$8:''3*=\Z'I/-N8W/85H\P=%!:
M9:P'75O5#EV?@S(&JE;7@['PMJ[:X3'I@Z_:^[@\1S?`&984K9[JC:(_'`AA
MA='Y"SD:7^W;GOP2=:Q_RIAC(D>6IEB.5"DJ-H)OTU1M,Z.?K^YO-><&3I(T
MFS1))F>H3CQX&;&_BAYU>\9?*2PIGQ!@5)*SF4%^3"#-_G,"?[3G%B+_=5X3
F4:M3G7H%G)_.@*#E2?^'+TB75C_T0U,8QK$0@J#O)+Z^OO`$````
`
end

--AhhlLboLdkugWU4S--

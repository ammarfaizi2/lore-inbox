Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSLGSSF>; Sat, 7 Dec 2002 13:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSLGSSF>; Sat, 7 Dec 2002 13:18:05 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:6418 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264624AbSLGSRm>; Sat, 7 Dec 2002 13:17:42 -0500
Date: Sat, 7 Dec 2002 16:25:10 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHES] more trivial compile fix and includes fixups patches
Message-ID: <20021207182510.GE10322@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/misc-2.5

	There are 14 outstanding changesets, all attached.

- Arnaldo

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.105.1.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.105.1, 2002-11-23 12:31:20-02:00, acme@conectiva.com.br
  o uaccess.h: remove include sched.h, it only needs thread_info.h


 drivers/parport/daisy.c        |    3 +++
 drivers/parport/ieee1284_ops.c |    1 +
 fs/autofs/autofs_i.h           |    3 +++
 fs/autofs4/autofs_i.h          |    2 ++
 fs/ext2/ioctl.c                |    2 ++
 include/asm-i386/desc.h        |    3 +++
 include/asm-i386/mmu.h         |    1 +
 include/asm-i386/uaccess.h     |    2 +-
 ipc/msg.c                      |    2 ++
 9 files changed, 18 insertions(+), 1 deletion(-)


diff -Nru a/drivers/parport/daisy.c b/drivers/parport/daisy.c
--- a/drivers/parport/daisy.c	Sat Dec  7 15:58:46 2002
+++ b/drivers/parport/daisy.c	Sat Dec  7 15:58:46 2002
@@ -21,6 +21,9 @@
 
 #include <linux/parport.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
+
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 #define DEBUG /* undef me for production */
diff -Nru a/drivers/parport/ieee1284_ops.c b/drivers/parport/ieee1284_ops.c
--- a/drivers/parport/ieee1284_ops.c	Sat Dec  7 15:58:46 2002
+++ b/drivers/parport/ieee1284_ops.c	Sat Dec  7 15:58:46 2002
@@ -17,6 +17,7 @@
 #include <linux/config.h>
 #include <linux/parport.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 
 #undef DEBUG /* undef me for production */
diff -Nru a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
--- a/fs/autofs/autofs_i.h	Sat Dec  7 15:58:46 2002
+++ b/fs/autofs/autofs_i.h	Sat Dec  7 15:58:46 2002
@@ -26,6 +26,9 @@
 #include <linux/dcache.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/sched.h>
+
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 #ifdef DEBUG
diff -Nru a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
--- a/fs/autofs4/autofs_i.h	Sat Dec  7 15:58:46 2002
+++ b/fs/autofs4/autofs_i.h	Sat Dec  7 15:58:46 2002
@@ -24,6 +24,8 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/wait.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 /* #define DEBUG */
diff -Nru a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
--- a/fs/ext2/ioctl.c	Sat Dec  7 15:58:46 2002
+++ b/fs/ext2/ioctl.c	Sat Dec  7 15:58:46 2002
@@ -9,6 +9,8 @@
 
 #include "ext2.h"
 #include <linux/time.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 
diff -Nru a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	Sat Dec  7 15:58:46 2002
+++ b/include/asm-i386/desc.h	Sat Dec  7 15:58:46 2002
@@ -6,6 +6,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/preempt.h>
+#include <linux/smp.h>
+
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
diff -Nru a/include/asm-i386/mmu.h b/include/asm-i386/mmu.h
--- a/include/asm-i386/mmu.h	Sat Dec  7 15:58:46 2002
+++ b/include/asm-i386/mmu.h	Sat Dec  7 15:58:46 2002
@@ -1,6 +1,7 @@
 #ifndef __i386_MMU_H
 #define __i386_MMU_H
 
+#include <asm/semaphore.h>
 /*
  * The i386 doesn't have a mmu context, but
  * we put the segment information here.
diff -Nru a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	Sat Dec  7 15:58:46 2002
+++ b/include/asm-i386/uaccess.h	Sat Dec  7 15:58:46 2002
@@ -6,7 +6,7 @@
  */
 #include <linux/config.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/thread_info.h>
 #include <linux/prefetch.h>
 #include <asm/page.h>
 
diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Sat Dec  7 15:58:46 2002
+++ b/ipc/msg.c	Sat Dec  7 15:58:46 2002
@@ -23,6 +23,8 @@
 #include <linux/proc_fs.h>
 #include <linux/list.h>
 #include <linux/security.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 #include "util.h"
 

===================================================================


This BitKeeper patch contains the following changesets:
1.797.105.1
## Wrapped with gzip_uu ##


begin 664 bkpatch16279
M'XL(`-8V\CT``]V96T_C1A3'G_&G&&D?6^PY<[,G*JMT=ZMVM96*J/:IK=`P
M'L<6L1WYPBZ2/_Q.8@A.B./8]`$!2$A,=/SW.;]S&]ZAKZ4I9F=*I\9YA_[(
MRVIVIO/,Z"JY4Z[.4_>FL`=7>6X/O#A/C??ABY<FI3XG+G?LT:6J=(SN3%'.
MSL"EV[]4]RLS.[OZ[?>O?_YZY3@7%^ACK+*%^=M4Z.+"J?+B3BW#<JZJ>)EG
M;E6HK$Q-M7EHL_UH0S`F]IN#3S$7#0C,_$9#"*`8F!`3%@CV9&UELD6='#<'
M0`@!*D$TG(`4SB<$KB]]%S!W`6'B`7B$(B`S"C."SS&988S6/IKO^P;])-$Y
M=CZ@__=]/CH:Y:A66INR=.,9*DR:WQF49'I9AP:5.C:A&_^,D@KEV?(>9<:$
M):KBPJCP.LFBW(V=+X@#9M*Y?/*\<S[RRW&PPL[[@==+5MI+RX6K.Z_',,8-
M)L)G#=,^IY&,?&Z"&V5Z7+EGQ4:)`B.2B49@GP2#(J+2,]\KXB6YKI8[4JBD
M00-$$MD$A-](XV,_8BH"#CU2#MGJ"&(0,#[LE398GBK3\X0&P@M-J=UX1QBS
MW@%,:1-9Q_@1T3XA2DK5)^R8S1V!A(CQ`M.T?J[/AC`@340#X()(ZT30H.2I
M^IY,=N013D_P7U@DZ[+BK52QRHO*"U52WN\Q!D'#*)6BH8#A1FL_9$)2UJ/N
MF,6./$IP,"S/,J+J*M_^ND[V?&>AHX)COPD@Y#B,(LULV;$J^Z$[;+`C#8A_
M0F"W)EBO-MDPO,Y-<@.A,93ZAC`L15]<^RUVPTJY#Z/#FAAC@`3L.E^5SZ-+
M?1'8B`0B(K:`A!J,IGW)<8+ECEJK%9]0VO:!WA;E_3RQ3`-N.`N93X&'.A(1
ME_34/-DUVY4I?4PW_;.'WN%N^H)$<JIOJE[$\\*$L:I.L28PIH(%#?$%)9O6
M2G=:*I$S)HZW5/J*6VI;&_Y"Y\6WS8]MD9=]D9G0;3];)]D9ZE'4+\LDJ[][
M#]K>._]VCBPZGJZ+PF35^N@0(;L),!Z4":GIK-;3WTO,6X#`M@>;28'U]!H@
M.18@>,4`M65G`*!=STSA""2"?H[6L!QJ-\.(3.]Z3JJRR-81&Z]E7D3U<IE$
M9FWSG\<G_G>L!8*=C"P;HL$!\>F&"X"W5%G:UKX'QB&'3"HKP0O*RL'F/P*5
M\5.(<[.PZ5#-PR3,JK#6MVY>+(X-(=A203E9!TG:Q&E7NK%TD%=,1SM;]='!
M7HJ'0*0?CR$XNJO225B,W],<%29+R\3<"BDK4T1EORUA<>"4;CH4P^T,(MX2
M"^WZ^9R%KBLF]0R83$'/7CI,PXN69"=-LD4^-\O*N'%]W%9`,2&,<[#MR2=O
ML8&T2_\>%CT^F8+'H1:R*HQ)5]4N'P_@I*NVMQSD8W,O,`&/$5<40W1T3#W!
M06SY81LX^%N:.ML;ER$V-AZ9@@;=&3;7]:$TJ5K%>6%Z*\3VG290,'()/SA.
M=,;.H6T<4VRW6H:M96GGE;9VC%YK+1_P6OEH;QF&^-@^9@(CG]8+R>=#6\F.
ME@=8'J^"3V!CW-VSHV[G::W=T'3COW?S#`$&L!6AL>7D80?UW0D7&:]YB&@O
GU?<C_NB(24,DGS8^//['R'Y2WY9U>B$-MPNDG=Q^`$"$RI6?&@``
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.797.105.2.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.797.105.2, 2002-11-23 12:56:31-02:00, acme@conectiva.com.br
  o sb_ess: fix up header cleanup: add include <linux/interrupt.h>


 sb_ess.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/sound/oss/sb_ess.c b/sound/oss/sb_ess.c
--- a/sound/oss/sb_ess.c	Sat Dec  7 15:58:38 2002
+++ b/sound/oss/sb_ess.c	Sat Dec  7 15:58:38 2002
@@ -186,6 +186,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 
 #include "sound_config.h"

===================================================================


This BitKeeper patch contains the following changesets:
1.797.105.2
## Wrapped with gzip_uu ##


begin 664 bkpatch16247
M'XL(`,\V\CT``]5438_3,!`]U[]BI!Y1'8^3.$U$5V47!&B1J(KVC%S;)1%-
M7-E.*2@_?M-4*FRWL.+C@FWYX!F]>3/OR6.X\\85(ZEJ0\;PQOI0C)1MC`K5
M3E)E:[IR?6!I;1^(2EN;Z/HVJBNO)IRFI`\M9%`E[(SSQ0AI?'H)7[>F&"U?
MO;Y[]V))R&P&-Z5L/ID/)L!L1H)U.[G1?BY#N;$-#4XVOC9A*-J=4CO.&.]W
MBEG,4M&A8$G6*=2(,D&C&4^F(B$'_O-SWF<HB#S&)$;.NA19DI.7@#3+,XHL
MI1P8CQ`C'@/R(A5%C!/&"\;@(C0\0Y@P<@W_MHT;HL""7WTTWA>PKO;0;J$T
M4AL':F-DTVX+D%I#U:A-JPT\WU1-NX^J)ACGVFV@Y16YA13%-">+[P,GD]]<
MA##)R-43[6E7'72/O&T;'1UI4_5#KPE#UK'I8>0K$<><J_7:")T(R2_/M3M"
M6>\?PAVU2P7/.L%%G@]^>IS[M+'^AC+9&F?V\^&FZMO/N/9L8\SC'JV7F:=B
M\%EZ[B^>_;_^.DKP'B;NRW!ZORPNJ/$'KGN+TRD@&?^J_NF'4:51GWU;SY"I
-OFF=D7N=Q6]MSP0`````
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.845.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.845, 2002-12-07 12:01:38-02:00, acme@conectiva.com.br
  Merge conectiva.com.br:/home/BK/includes-2.5.old
  into conectiva.com.br:/home/BK/includes-2.5


 msg.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Sat Dec  7 15:58:31 2002
+++ b/ipc/msg.c	Sat Dec  7 15:58:31 2002
@@ -23,6 +23,8 @@
 #include <linux/proc_fs.h>
 #include <linux/list.h>
 #include <linux/security.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 #include "util.h"
 

===================================================================


This BitKeeper patch contains the following changesets:
1.845
## Wrapped with gzip_uu ##


begin 664 bkpatch16215
M'XL(`,<V\CT``[64WVZ;,!2'K^.GL-3+*7"..<8$*5/:;MJDKEJ4J0_@&#>@
M!ER!P[2)AY^32NF4-LM2;<`%8/_\YSN??,'O.MOF(VUJRR[X9]?Y?&1<8XVO
M>AT95T?+-C0LG`L-<>EJ&U_=Q'75F;&()`M-<^U-R7O;=OD(HV3_Q_]XM/EH
M\?'3W9?+!6/3*;\N=;.RWZSGTRGSKNWUNNAFVI=KUT2^U4U76[^;=-AW'02`
M"+=$E8!,!TR!U&"P0-2$M@!!64JLUTW1NM[.>A.9?N,C\_-@#!2@@&`B82"I
M*&$?.$8920XB1A&#XBARP#S)QA!>@&^1S`Y1\'?(Q\"N^+]=_C4S_-:V*\L/
M)\SWS*O&K#>%[;;<([<N0J1JO/O+!*M>W]`A)10)4A)@#1*!)F?%9)I@B*79
MA-WP`%DJ=ONV^/S9%38^\V(,-+#W)RI4/9JX[E:1^:U"!``#B%310$;)Y'YR
MKZ3-EMH>L>%@E*UB2(`)#3(EHIWT^RZGI3]S36S5VM7LH76Z?"4>F*I`55!@
M&KYQYSOB"]WIS[K#_]+]<A/<K;?.%T<E>[&C8(F84#JDH$06)'O"?$RR$_&O
F?-Q^WSU!FOESH=Y@W/[0,Z4U#]VFGA89:;4T&?L%?Q8/<6(%````
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.846.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.846, 2002-12-07 13:56:14-02:00, acme@conectiva.com.br
  o nbd: fix up headers changes, include blk.h and blkdev.h
  
  Also fix an unbalanced #endif


 drivers/block/nbd.c |    2 ++
 include/linux/nbd.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c	Sat Dec  7 15:58:24 2002
+++ b/drivers/block/nbd.c	Sat Dec  7 15:58:24 2002
@@ -37,6 +37,8 @@
 #define PARANOIA
 #include <linux/major.h>
 
+#include <linux/blk.h>
+#include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
diff -Nru a/include/linux/nbd.h b/include/linux/nbd.h
--- a/include/linux/nbd.h	Sat Dec  7 15:58:24 2002
+++ b/include/linux/nbd.h	Sat Dec  7 15:58:24 2002
@@ -53,7 +53,6 @@
 	int blksize_bits;
 	u64 bytesize;
 };
-#endif
 
 /* This now IS in some kind of include file...	*/
 

===================================================================


This BitKeeper patch contains the following changesets:
1.846
## Wrapped with gzip_uu ##


begin 664 bkpatch16176
M'XL(`,`V\CT``]V5RXZ;,!2&U_%3'"G+-G!L;`RHB3*7JJVF4J-4LZJZ<&RG
MH!`8`4FG$@]?AW0NBLA$$W73`@OPY??O<[YCAG!;VRH9*+VV9`@?R[I)!KHL
MK&ZRK?)TN?86E>N8EZ7K\--R;?W+&W^=U7K$/$%<UTPU.H6MK>ID0+W@L:7Y
M=6>3P?S]A]O/%W-"QF.X2E7QPWZU#8S'I"FKK<I-/55-FI>%UU2JJ->VZ19M
M'X>V#)&Y6U`9H`A;&B*7K::&4L6I-<AX%'*R\S\]]'V@0AE*RI$&4<N%%))<
M`_4B'@(RGS(?)=`@$6%"^0A9@@B]HO"&P0C))?S=#5P1#244"Y/`,KN'S1VD
M5AD75-"=4OT6LD+G&V-AD:^\%%1A=F_&;KW4S77/15Z7W615P*98J%P5VAH8
MVL)D2W(#7$0HR>PI#63TRHL05$@F)[;^QZ>?9\7FWG=;\M+G08@Y;3$*`FS#
MY2+@`>6<!<L8PR,!/ZK7Y5,(E]&62:3\I#%393M,_45>ZE4GI)\9XXC<?3(I
MVS",9+SD6II81HK%1XP=TSLP)COX>P:?+H.S'9-4I].\;CQCOSTL\?TEP\+I
M,!&TC(41=I5Q6!@\0?I_%L8^25]@5/WL'@?ZK"]?9]3+IR`&1H8/#M_M&>Z,
M3OJ:.]>3#I@>[$\#<W;M]0/S0NGM@7'\N9-T?Y325P.#,*+_*C#\$)B>6)T!
>S+4(@3[]5G5J]:K>K,>QX,M`1)+\!K,R)0NR!P``
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.847.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.847, 2002-12-07 14:07:57-02:00, acme@conectiva.com.br
  o atmtcp: fix struct initialization
  
  Fix this warning:
  drivers/atm/atmtcp.c:324: warning: braces around scalar initializer
  
  Also convert it to C99 style initialization


 atmtcp.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)


diff -Nru a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
--- a/drivers/atm/atmtcp.c	Sat Dec  7 15:58:17 2002
+++ b/drivers/atm/atmtcp.c	Sat Dec  7 15:58:17 2002
@@ -315,15 +315,9 @@
 
 
 static struct atm_dev atmtcp_control_dev = {
-	&atmtcp_c_dev_ops,
-	NULL,		/* no PHY */
-	"atmtcp",	/* type */
-	999,		/* dummy device number */
-	NULL,NULL,	/* pretend not to have any VCCs */
-	NULL,NULL,	/* no data */
-	{ 0 },		/* no flags */
-	NULL,		/* no local address */
-	{ 0 }		/* no ESI, no statistics */
+	.ops		= &atmtcp_c_dev_ops,
+	.type		= "atmtcp",
+	.number		= 999,
 };
 
 

===================================================================


This BitKeeper patch contains the following changesets:
1.847
## Wrapped with gzip_uu ##


begin 664 bkpatch16144
M'XL(`+DV\CT``^U476_:,!1]CG_%52OM926Q'3M?$A,MW9<Z:8BIS\AQ7,@@
M,;(-7:O\^!F88&)L:-4>E_CIG*OC<^\]\B7<6V6*0,A&H4OXH*TK`JE;)5V]
M%J'435@:3XRU]D0TTXV*;NZBIK:R1T../#423LY@K8PM`A+&>\0]+541C-^^
MO_]T/4:HWX?A3+13]44YZ/>1TV8M%I4="#=;Z#9T1K2V46Y[:;<O[2C&U/^<
MI#'F24<2S-).DHH0P8BJ,&59PM#&_^#8]Y$*H3@EG">$=8QG.$6W0,*,I8!I
M1&B$4R"LP&G!TQZF!<9P4A1>$^AA=`/_MH$ADJ!!N,;)90$/]3>PSJRD@[JM
M72T6];-PM6Y]E3_O/.UFM85'8=JZG18>JTR]V4'D):*=3"B+F+)B7P2E$5)9
M$$:OV@JL%`MA#OK*[,2O%U:#[]JK^=N=[Q.&>>[M/"W4L9L[8#S.4S0Z[!;U
M_O)#"`N,WIR9YZGV?AHMPR3SHZ4\[HB@@E9E6C&*%>'T]!I_+[B-28)3+Y6P
MC.-M=$]5GT_QRTVCKU-AGNOYH!%M9<1<6?W@SFCF,<:$)PQWA*99LHTW_R7<
M\9_#'4,O_Q_N'^'>[?\S],SC]OBPCDYZ>4'H;V.208X^QC2!&`6A7MH@Z,.K
MG>1$3BJUGGCPRG.;IW1#7NS(BPW6KII2F0V:Y_G5X2&6,R7G=M7TA:)E&8L2
*?0></[)HY`4`````
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.848.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.848, 2002-12-07 14:11:33-02:00, acme@conectiva.com.br
  o opl3sa2: remove spurious comma


 opl3sa2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
--- a/sound/isa/opl3sa2.c	Sat Dec  7 15:58:09 2002
+++ b/sound/isa/opl3sa2.c	Sat Dec  7 15:58:09 2002
@@ -634,7 +634,7 @@
 	chip->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
 	pdev = chip->dev;
 	if (!pdev){
-		snd_printdd("isapnp OPL3-SA: a card was found but it did not contain the needed devices\n",);
+		snd_printdd("isapnp OPL3-SA: a card was found but it did not contain the needed devices\n");
 		return -ENODEV;
 	}
 	sb_port[dev] = pdev->resource[0].start;

===================================================================


This BitKeeper patch contains the following changesets:
1.848
## Wrapped with gzip_uu ##


begin 664 bkpatch16112
M'XL(`+(V\CT``\6476O;,!2&KZ-?<6AO-H9MR?)'ZI&1?HQNM-"0TJMM#$4Z
MB\UBR4A*V@W_^,E)::'+-C8*LXT%.M*K1Z]>=`@W#FTU$K)%<@COC//52!J-
MTC<;$4O3Q@L;"G-C0B&I38O)R472-DY&:9R34)H)+VO8H'75B,7\H<=_Z[`:
MS=^>WUP>SPF93."T%GJ)U^AA,B'>V(U8*3<5OEX9'7LKM&O1;Q?M'X;V*:5I
M>'-6<IH7/2MH5O:2*<9$QE#1-!L7&1GXIT^YGZBPE)9A>IF7?9;SHY*<`8O'
MV1AHFK`TH26PK&*LXCRB:44I[!6%5PPB2D[@>3=P2B08,-V*.Y%68+$U&P37
MK6UCU@Z"9"O(!01PSLGLT4H2_>5#"!64O($.+=Y-M_]8?N^=66N5-$XD]PRQ
MO"=GG!WQT/9YGK)Q+V@ACD2)18DTHSS=[](O]7:'P!BG?9C.^#88>P8/$7DN
M1"+:Q1V;:C2QM0/@AZ7%Y:??,18T3W/*!\9\%Q26_903^L><L/^6D\':*XCL
M[?8+QS[;Y_(_I.>LX,$`\G[7C$9.J\^=;;17ZL5!$.]T!U>S2QY='U<@0`JK
MX%8X^#*L#HNUA\:#:A1HXP.N]J+1X&L$C:A0@<)-(]%]U`<O7S]>+[)&^=6M
2VTD^SK*L+`KR`[T:K:.Z!```
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.849.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.849, 2002-12-07 14:14:10-02:00, acme@conectiva.com.br
  o gus_wave: remove unused variable 'flags'


 gus_wave.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/sound/oss/gus_wave.c b/sound/oss/gus_wave.c
--- a/sound/oss/gus_wave.c	Sat Dec  7 15:58:03 2002
+++ b/sound/oss/gus_wave.c	Sat Dec  7 15:58:03 2002
@@ -226,8 +226,6 @@
 
 static void gus_poke(long addr, unsigned char data)
 {				/* Writes a byte to the DRAM */
-	unsigned long   flags;
-
 	outb((0x43), u_Command);
 	outb((addr & 0xff), u_DataLo);
 	outb(((addr >> 8) & 0xff), u_DataHi);

===================================================================


This BitKeeper patch contains the following changesets:
1.849
## Wrapped with gzip_uu ##


begin 664 bkpatch16080
M'XL(`*LV\CT``\V436O<,!"&SZM?,9!##L7VC"1_@LLV26DAA2Y;<BZ*K%TO
MM:U@>;T4]./K==ND+-N&?APJZ:097KTS\Z`+N'.F+Q9*MX9=P%OKAF*A;6?T
ML!M5J&T;WO=38&WM%(AJVYKHZC9J=TX'/(S9%%JI0=<PFMX5"PK%X\WP^<$4
MB_7K-W?O7JT9*TNXKE6W-1_,`&7)!MN/JJG<4@UU8[MPZ%7G6C/,C_K'5,\1
M^;1C2@7&B:<$9>HU541*DJF0RRR1[.A_>>K[1(4XII00">%E+(1@-T!A)G-`
M'A&/,`62Q?%@@+Q`A+.B\((@0'8%_[:`:Z;!PG;O/A[4:`KH36M'`_MN[TP%
MH^IWZKXQ<+EIU-9=LEN0<9PA6STUE06_N1A#A>SE,X54_>XXV\C9?5=%WPV&
M^H>Z)&+N25!,7HM-6O%-SKF(XTKP\SWT7\6L<Z>"WV8D,?4219K-W)S+?AZA
MOS/.'@[*Z'IH3+]LE9X5?^H:<YY3-I%%7G))?"8K/>4*TU]SA1#P_X"KN>WO
J(>@/\YDX69V=P!_P=L-Y#OSIT]"UT9_<OBWUU#I)B69?`(H=*FN0!```
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.850.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.850, 2002-12-07 14:27:04-02:00, acme@conectiva.com.br
  ip2main: remove unused variable rc in ip2_init_board


 ip2main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Sat Dec  7 15:57:56 2002
+++ b/drivers/char/ip2main.c	Sat Dec  7 15:57:56 2002
@@ -967,7 +967,7 @@
 static void __init
 ip2_init_board( int boardnum )
 {
-	int i,rc;
+	int i;
 	int nports = 0, nboxes = 0;
 	i2ChanStrPtr pCh;
 	i2eBordStrPtr pB = i2BoardPtrTable[boardnum];

===================================================================


This BitKeeper patch contains the following changesets:
1.850
## Wrapped with gzip_uu ##


begin 664 bkpatch16048
M'XL(`*0V\CT``\U476O<,!!\MG[%0AZ+[94L6XZ+RS5):4L*/:[DJ92@DT4M
M>K8.678I^,='=VF3D%Q[]..ADD"@769G=P:=P-6@715)U6ER`F_LX*M(V5XK
M;R:9*-LE:Q<"*VM#(&UMI].SR[0S@XI9DI,06DJO6IBT&ZJ()MG=B_^VU56T
M>O7ZZMW+%2%U#>>M[#_K#]I#71-OW20WS;"0OMW8/O%.]D.G_;[H?)<Z,T06
M=DY%AGDQTP*YF!5M*)6<Z@89+PM.=OP7CWD_0J$,!2THISCS/"^17`!-RAP!
M64I9B@(HKYBHD,?(*D0X"`K/*,1(SN#?-G!.%)@MZZ3I*W"ZLY.&L1\'W<`D
MG9'KC0874OI=UK7IC;]>6^D:<@F<ER(CR_OQDO@W%R$HD;PXTE+CS$[E5+72
MI=^Y)NI!?QPQGPM:%'QF7"-3_)1QP77!#X_R5XBW8C&!0:PLH\7>0(?SC[OI
M+YB3R3B[Z`)LLAW&1#?CQQ^U/AWASQEF@7O@GP=]=F9C3[V&1[U&_RNO[;5X
M#['[NC_!.\N?R/('+KPX%0B4O+V](M-[,,_O_QC5:O5E&+LZ9W3-M2C)#9L$
&+IN_!```
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.851.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.851, 2002-12-07 14:53:30-02:00, acme@conectiva.com.br
  o zftape: zft_init cannot be static it is used also in lowlevel/ftape-init


 zftape-init.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c	Sat Dec  7 15:57:48 2002
+++ b/drivers/char/ftape/zftape/zftape-init.c	Sat Dec  7 15:57:48 2002
@@ -314,7 +314,7 @@
 /*  Called by modules package when installing the driver or by kernel
  *  during the initialization phase
  */
-static int __init zft_init(void)
+int __init zft_init(void)
 {
 	int i;
 	TRACE_FUN(ft_t_flow);

===================================================================


This BitKeeper patch contains the following changesets:
1.851
## Wrapped with gzip_uu ##


begin 664 bkpatch16016
M'XL(`)PV\CT``\U476O;,!1]CG[%A;YL#-OW2K*=&#*RMF,;'2QD]&F,HLI:
M;6);PY;3KOC'3W'H!Z&0=O1AMN'*NM;5.><>ZPC..]-F$Z5KPX[@L^U<-M&V
M,=J5&Q5J6X>7K4^LK/6)J+"UB8[/HKKL=,##F/G44CE=P,:T73:A4-S/N#^_
M3399??QT_O7#BK'Y'$X*U5R9[\;!?,Z<;3>JRKN%<D5EF]"UJNEJX\9-A_M/
M!X[(_1U3*C!.!DI0IH.FG$A),CER.4TDV^)?[./>JT(<4TIXBG*0<IH*=@H4
M3F,"Y!'Q"%,@F<4B$Q@@SQ#AR:+PCB!`=@RO2^"$:;!P^\LIK]HV7I1-Z4"K
MIK$.+@UT3KE2@Y\K.^@[DX.J.@ME`Y6]KLS&5-&X.-BN8V<@A4Q2MGP0G04O
MO!A#A>S]`:)Y6VY['^E"M3L$T>WC,.()]2,9)&+L7TG@(+@P>C;3%$])2Q$_
M+?F+]MAU.18\&?A,"AR=]\P"AWWYJFR9JE2SJ&YL>]6OPW[=]Z$?^L&/.Q`_
M7T:=>((4I]Y?`HEP-#B)?7_SY*"_Z?_W]ZZYWR!HK\?'^W7YW#[_PZ]P*LCK
JQ[[L0MDXN-@QN*/R9F/+_.W#@:@+H]==7\^EPF1&J69_`<I-3EML!0``
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.852.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.852, 2002-12-07 14:54:11-02:00, acme@conectiva.com.br
  o scx200_gpio: fix up header cleanups: add include <linux/fs.h>


 scx200_gpio.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/char/scx200_gpio.c b/drivers/char/scx200_gpio.c
--- a/drivers/char/scx200_gpio.c	Sat Dec  7 15:57:42 2002
+++ b/drivers/char/scx200_gpio.c	Sat Dec  7 15:57:42 2002
@@ -6,6 +6,7 @@
    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com> */
 
 #include <linux/config.h>
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.852
## Wrapped with gzip_uu ##


begin 664 bkpatch15984
M'XL(`)8V\CT``]54RV[;,!`\FU^Q@(^%I"7UH")4@9NT:(L4J.$BYX*FUA91
M/0Q2<EQ`'Q]9`=PB<5KT=2C)$W<Y.SL[X!QN'=ELIG1-;`[O6M=E,]TVI#NS
M5[YN:W]MQ\"J;<=`4+8U!5<W06V<]H0?LS&T5)TN84_693/NAZ>;[NN.LMGJ
MS=O;#Z]6C.4Y7)>JV=(GZB#/6=?:O:H*MU!=6;6-WUG5N)JZJ>AP2AT$HAAW
MS&6(<3+P!",Y:%YPKB).!8HH32)VY+]XS/L1"A<H>1*'(0Y1&"62O0;NI[$`
M%`$7`4K@419'&><>B@P1SH+""PX>LBOXNPU<,PTM.'T8TS]O=Z;-8&,.T.^@
M)%60!5V1:OJ=RT`5!9A&5WU!\+(R37\(-LXO+]D-C'VE(5M^4YIYO[@80X7L
M$G1IC>O(+N[(-&9+E>]H**PYSCG0I;+!=UQ]_2`P3EW&`H=02"&&M:9$D):*
M;S1=1.OSBOX4]F%N$<H!1ZW"R4O/OSF:ZY^P_S-4/J"XB'$RW1/+H?Q_+7><
MR$?P[-UT1@<M?S"<W_#C^Q0XFY^M?OIK=$GZB^OK'&6L8DDINP>BF+KHV00`
!````
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.853.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.853, 2002-12-07 14:57:03-02:00, acme@conectiva.com.br
  o watchdog/sbc60xxwdt: comment out goto label not being used


 sbc60xxwdt.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Sat Dec  7 15:57:35 2002
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sat Dec  7 15:57:35 2002
@@ -345,7 +345,7 @@
 	release_region(WDT_START,1);
 err_out_region1:
 	release_region(WDT_STOP,1);
-err_out:
+/* err_out: */
 	return rc;
 }
 

===================================================================


This BitKeeper patch contains the following changesets:
1.853
## Wrapped with gzip_uu ##


begin 664 bkpatch15952
M'XL(`(\V\CT``\U476O;,!1]CG[%A;YUQ+Y7EF37D-&U'=OH8"&C3V,,15;C
M++$U9"5MP3^^2M:U71=(]_$PR2#0E<Z]Y]QC'<!%9WTYT*:Q[`#>NBZ4`^-:
M:\)\K1/CFF3J8V#B7`RDM6ML>G*>-O/.#'DB60R-=3`UK*WOR@$EV?U.N/EF
MR\'D]9N+]Z\FC(U&<%KK=F8_V@"C$0O.K_6RZHYUJ)>N38+7;=?8L$W:WQ_M
M.2*/4U*>H50]*11Y;Z@BTH)LA5P42K!-_<=/ZWZ"0AQS4E(0]2(31<;.@))"
M9H`\)9YB#B1*F9>8#9&7B+`3%%X0#)&=P+\E<,H,.+C:*%>Y6=I-C<+KZZLJ
ME!#A&ML&<*L`,Q<<+/74+J%U`:9VWLY@U=F*G8/@E!=L_"`S&_[F8`PULI=[
MJ%5^ONEV:FKM'Q6:F$=4!:+L5<8Y[^4E:9Y'Q:6<TN71T6Y9?T;=H<,=_%T3
M<\0>E2K$UEC[[^YWW%^R8I5>VZ^15F4;UR[L3>+\+%DM/OW(^OG9#(DKY%D1
M4Z$2@F]M2ODO+L6]+J7_T:7;IGV`H;_:?M%TXV?T[P^L?!;_<2#V[ON2'H+U
?_DNLKH3#].'=,K4UBV[5C#*5266%8K?%A?%"$P4`````
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.854.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.854, 2002-12-07 15:03:30-02:00, acme@conectiva.com.br
  o atm/mpc: fix up struct initialization
  
  Fixes this:
  net/atm/mpc.c:752: warning: braces around scalar initializer
  
  Also converts it to C99 struct style initialization


 mpc.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)


diff -Nru a/net/atm/mpc.c b/net/atm/mpc.c
--- a/net/atm/mpc.c	Sat Dec  7 15:57:28 2002
+++ b/net/atm/mpc.c	Sat Dec  7 15:57:28 2002
@@ -736,23 +736,15 @@
 }
 
 static struct atmdev_ops mpc_ops = { /* only send is required */
-	.close =mpoad_close,
-	.send =	msg_from_mpoad
+	.close	= mpoad_close,
+	.send	= msg_from_mpoad
 };
 
 static struct atm_dev mpc_dev = {
-	&mpc_ops,       /* device operations    */
-	NULL,           /* PHY operations       */
-	"mpc",          /* device type name     */
-	42,             /* device index (dummy) */
-	NULL,           /* VCC table            */
-	NULL,           /* last VCC             */
-	NULL,           /* per-device data      */
-	NULL,           /* private PHY data     */
-	{ 0 },          /* device flags         */
-	NULL,           /* local ATM address    */
-	{ 0 }           /* no ESI               */
-	/* rest of the members will be 0 */
+	.ops	= &mpc_ops,
+	.type	= "mpc",
+	.number	= 42,
+	/* members not explicitely initialised will be 0 */
 };
 
 int atm_mpoa_mpoad_attach (struct atm_vcc *vcc, int arg)

===================================================================


This BitKeeper patch contains the following changesets:
1.854
## Wrapped with gzip_uu ##


begin 664 bkpatch15920
M'XL(`(@V\CT``^U46VO;,!1^CG[%H84]=(LMR5+D&#)ZVXT.5C+Z'!19341M
MRTA*+\,_?K*[M4OH5E;V.%M@G>]<_!V=#^W#A=>N&$E5:[0/'ZT/Q4C91JM@
MKF6B;)TL773,K8V.=&UKG1Z?I;7Q:DP3CJ+K7`:UAFOM?#$B2?:`A+M6%Z/Y
MNP\7GX_F",UF<+*6S4I_U0%F,Q2LNY95Z0]E6%>V28*3C:]U&'[:/81V%&,:
M7TY$AOFD(Q/,1*=(28AD1)>8LGS"4,__<)?W3A5"L2`3+G#6,4I$CDZ!)#EG
M@&E*:(H%$%[@K,CP&-,"8WBR*+PF,,;H&/YM`R=(@049ZK1N50&7YA8V+?C@
M-BJ`:4PPLC+?9#"VB9%QO3>WVD-8&U]$J]$A_9&<J$)P6L"-=(UI5@4LG50Q
M5#J[:4KP2E;2/9;4[K[>4>4MQ&;C((,'$V)_<#*=_J3@PUVE=XF<`:,Y%^C\
M<;1H_)</0EAB]/:9X]SJ[Y<C91CCC@O")EVN\FE)\253C!">ET^/[XE*@RZB
M*JCH*,=3-FAU*^QYO;Z`'Y)7;7U8FI6VORE!"&%$Q!WOF,C(=!"LV)4K%7^6
MZP3&A/W7Z[U>[P?\!<;N9EA1?^?;9%X@X%.138&B3W':\3-*5&6]'LV@;JTL
M%X/U)L)>-V6/^M7BTMEZ,;AC,F-`^FS.@<4PV_H8]2J26<1MG]C?I!':B]!>
M;S>;>JE=1!B-9GH`M>X!#XT-H&_;RB@3='7WT+[7)=R8JH*E!@P'Z>.UK=9:
47?E-/:-:JJ44#'T'.'Q]WQ(&````
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.855.patch"

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.855, 2002-12-07 15:07:07-02:00, acme@conectiva.com.br
  o sch_atm: sockfd_put is already defined similarly in linux/net.h


 sch_atm.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/net/sched/sch_atm.c b/net/sched/sch_atm.c
--- a/net/sched/sch_atm.c	Sat Dec  7 15:57:21 2002
+++ b/net/sched/sch_atm.c	Sat Dec  7 15:57:21 2002
@@ -19,9 +19,6 @@
 
 
 extern struct socket *sockfd_lookup(int fd, int *err); /* @@@ fix this */
-#define sockfd_put(sock) fput((sock)->file)	/* @@@ copied because it's
-						   __inline__ in socket.c */
-
 
 #if 0 /* control */
 #define DPRINTK(format,args...) printk(KERN_DEBUG format,##args)

===================================================================


This BitKeeper patch contains the following changesets:
1.855
## Wrapped with gzip_uu ##


begin 664 bkpatch15888
M'XL(`($V\CT``\U4T6K;,!1]CK[B0A^'Y2O9LAV#1]9V;-#!0D:?BRHILXDM
M%4O)%O#'3\U*.]JT964/D^Z3[N7H')V#3N#2F[&>2348<@*?G0_U3#EK5.AV
MDBHWT.LQ-E;.Q4;:NL&DIQ?IT'F5<"I(;"UE4"WLS.CK&:/9_4G8WYAZMOKX
MZ?++AQ4A30-GK;3?S3<3H&E(<.-.]MHO9&A[9VD8I?6#"8=+I_O1B2/RN`4K
M,Q3%Q`K,RTDQS9C,F='(\ZK(R2W_Q6/>CU`8QY*5F&4XY;P2)3D'1BLA`'G*
M>(HE,%%C&2M!7B/"45!XQR!!<@K_5L`94>#`J_9*AJ$&[]1FK:]NM@$Z#[(?
MC=1[T&;=6:/!=T/7R['?0V>A[^SV9VI-H"VY@)S/F2#+A[<FR5\N0E`B>?^*
MOGA?&MD:G=YQINI/I7,QGZ)<7DT\9WPND9DHOHA2C[_JLWAWID7;IHP+41V"
M=&3X]4B]F3'1<F>&A=T&3VUG-Y)&J.<)8W281Q=P*GA1B$/*BB<9RU[.&$*2
M_;<9^VW$5TC&'X>*F5D>\^0-T3OG'+*'7R7BJ8W?#LUUH44NUVOR"\_/QQZQ
#!```
`
end

--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="1.856.patch"
Content-Transfer-Encoding: quoted-printable

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


ChangeSet@1.856, 2002-12-07 15:25:11-02:00, acme@conectiva.com.br
  o dvb/saa7146_core: use pci_[gs]et_drvdata instead of pdev->driver_data
 =20
  Fixes build, also move some zero initialized globals to .bss


 saa7146_core.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/media/dvb/av7110/saa7146_core.c b/drivers/media/dvb/a=
v7110/saa7146_core.c
--- a/drivers/media/dvb/av7110/saa7146_core.c	Sat Dec  7 15:57:14 2002
+++ b/drivers/media/dvb/av7110/saa7146_core.c	Sat Dec  7 15:57:14 2002
@@ -45,14 +45,14 @@
=20
 /* insmod parameter: some programs (e.g. =B4vic=B4) do not allow to
    specify the used video-mode, so you have to tell this to the
-   modules by hand, 0 =3D PAL, 1 =3D NTSC  */
-static int mode =3D 0;
+   modules by hand, 0 =3D PAL (default), 1 =3D NTSC  */
+static int mode;
=20
-/* debug levels: 0 -- no debugging outputs
+/* debug levels: 0 -- no debugging outputs: default
 		 1 -- prints out entering (and exiting if useful) of functions
 		 2 -- prints out very, very detailed informations of what is going on
 		 3 -- both of the above */
-int saa7146_debug =3D 0;	/* insmod parameter */
+int saa7146_debug;	/* insmod parameter */
=20
 #define dprintk		if (saa7146_debug & 1) printk
 #define hprintk		if (saa7146_debug & 2) printk
@@ -796,7 +796,7 @@
 static int saa7146_suspend(struct pci_dev *pdev, u32 state)
 {
         printk("saa7146_suspend()\n");
-	saa7146_core_command(((struct saa7146 *) pdev->driver_data)->i2c_bus,
+	saa7146_core_command(((struct saa7146 *)pci_get_drvdata(pdev))->i2c_bus=
,
 			     SAA7146_SUSPEND, 0);
 	return 0;
 }
@@ -805,7 +805,7 @@
 saa7146_resume(struct pci_dev *pdev)
 {
         printk("saa7146_resume()\n");
-	saa7146_core_command(((struct saa7146 *) pdev->driver_data)->i2c_bus,
+	saa7146_core_command(((struct saa7146 *)pci_get_drvdata(pdev))->i2c_bus=
,
 			     SAA7146_RESUME, 0);
 	return 0;
 }
@@ -839,7 +839,7 @@
 	memset (saa, 0, sizeof (struct saa7146));
=20
 	saa->device =3D pdev;
-	saa->device->driver_data =3D saa;
+	pci_set_drvdata(pdev, saa);
 	saa->card_type =3D card_type;
 	saa->dvb_adapter =3D adap;
=20
@@ -855,7 +855,7 @@
 static
 void __devexit saa7146_remove_one (struct pci_dev *pdev)
 {
-	struct saa7146 *saa =3D pdev->driver_data;
+	struct saa7146 *saa =3D pci_get_drvdata(pdev);
=20
 	dprintk("saa7146_remove_one()\n");
=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


This BitKeeper patch contains the following changesets:
1.856
## Wrapped with gzip_uu ##


begin 664 bkpatch15853
M'XL(`'HV\CT``]U56V_3,!1^KG_%D7AIQY+8;M)<IDZ#E<LT!-.`)X0J)W;;
M:$E<Q4ZXJ#^>XQ0VJ"8$"/%`;-F6C\]W+M\YR@-X:U2;C411*_(`GFMCLU&A
M&U78LA=3D^H6L_;U%PK34*@HVN5?#X,JA+4WC<CPB*KH0M-M"KUF0CYD]O;^RG
MK<I&UT^>O7WQZ)J0^1S.-Z)9J]?*PGQ.K&Y[44ES)NRFTHUO6]&86MG!Z.[V
MZ8Y3RG%$+)[2:+9C,QK&NX))QD3(E*0\3&8A<?Z?'?I]@,(XC5E,<>Q"GK*(
M+(#Y230#R@/&`QH#BS(>98QYE&>4PKV@\)"!1\EC^+L!G),"-,@^#XP0,0MG
MRT*W*H/.*-@6Y?+=3DVKQ7=3DBG;7@HKH&R,54*"7L%6JMX[E6V)%"R=3D$)%P/BT_
M*@-Y5U;R&$1E--2Z5V"00?BL6HT0I2U%57Y6$M:5SO$-Q@1^;@RYA)!S-B-7
M=3DYP1[S<_0JB@Y!1MB^:L^JC;=3D7?C=3DS=3D=3DY^,1#^^^)?#];N^\"6HE2Q&X)(@^
M9HS^D`N_V+-(><)YF%*^H]-9'.]8GJQD2%=3DAE"K!97X_;;]G8Z@4'F&E1%,V
M8T/U_B*`J^U_'3(1&R&P$,NV%F7E-\K^J257J2%+7>`T3?G0(N%A@]#XYPV2
M@)?\]PVR+XQ7X+4?AHD%?_6K-?('O;0($^#D(DQQ!4!795<Y]S\!YA$#H#"'
MJT<O8"S52G25G1P#PZN7;UZ?`QP%Q%AARP)CLDY7G9!%Q("1BV$-CD"JO%M#
MI7I5F0S1/`\:O;]=3DE\T:=3D&>WG4715WS4CP9]MSK4;Q$.*B<CA$0*T!1L12N0
M=3D=3D4Z-Q9QFCJU_3;Z/BVXU#7&,AZ/C6V[XA82CB:.X/4=3DNV-'Z63BG9:\6.:=3D
M.2:+A"8.=3D[_]3=3DR0#[C#-G+OS<'[8X<WP80FT=3DZ%:._"@2T\(!_W&CRY^XT6
6&U7<F*Z>KP2/IS%/R1=3D+S.FRH@<`````
`
end

--DocE+STaALJfprDB--

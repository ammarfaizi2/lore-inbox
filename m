Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264436AbSIQSCd>; Tue, 17 Sep 2002 14:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264440AbSIQSCd>; Tue, 17 Sep 2002 14:02:33 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:19651 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264436AbSIQSCa>; Tue, 17 Sep 2002 14:02:30 -0400
Date: Tue, 17 Sep 2002 11:01:57 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [BK patch 1] console changes
Message-ID: <Pine.LNX.4.33.0209171100010.17550-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   Since my consoel change is large I'm trying to send you small pieces at
a time. This patch fixes a few drivers that missed the handle_sysrq
changes. Of course you can grab the patch from

bk://linuxconsole.bkbits.net/stable

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.541, 2002-09-17 10:30:14-07:00, jsimmons@maxwell.earthlink.net
  These files missed the handle_sysrq change.


 mips/au1000/common/serial.c |    2 +-
 ppc/4xx_io/serial_sicc.c    |    2 +-
 ppc/8xx_io/uart.c           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/arch/mips/au1000/common/serial.c b/arch/mips/au1000/common/serial.c
--- a/arch/mips/au1000/common/serial.c	Tue Sep 17 10:53:02 2002
+++ b/arch/mips/au1000/common/serial.c	Tue Sep 17 10:53:02 2002
@@ -433,7 +433,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}
diff -Nru a/arch/ppc/4xx_io/serial_sicc.c b/arch/ppc/4xx_io/serial_sicc.c
--- a/arch/ppc/4xx_io/serial_sicc.c	Tue Sep 17 10:53:02 2002
+++ b/arch/ppc/4xx_io/serial_sicc.c	Tue Sep 17 10:53:02 2002
@@ -462,7 +462,7 @@
 #ifdef SUPPORT_SYSRQ
         if (info->sysrq) {
             if (ch && time_before(jiffies, info->sysrq)) {
-                handle_sysrq(ch, regs, NULL, NULL);
+                handle_sysrq(ch, regs, NULL);
                 info->sysrq = 0;
                 goto ignore_char;
             }
diff -Nru a/arch/ppc/8xx_io/uart.c b/arch/ppc/8xx_io/uart.c
--- a/arch/ppc/8xx_io/uart.c	Tue Sep 17 10:53:02 2002
+++ b/arch/ppc/8xx_io/uart.c	Tue Sep 17 10:53:02 2002
@@ -481,7 +481,7 @@
 			if (break_pressed && info->line == sercons.index) {
 				if (ch != 0 && time_before(jiffies,
 							break_pressed + HZ*5)) {
-					handle_sysrq(ch, regs, NULL, NULL);
+					handle_sysrq(ch, regs, NULL);
 					break_pressed = 0;
 					goto ignore_char;
 				} else

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch17532
M'XL(`/YKAST``]666T_;,!3'G^M/88F73:/).8[M7*9.;#!MT]"&V'A&KF-(
M1M)T<<IERH>?FXX64$L+`FDXD:PFZ;G^_B?9HD?6U$GOE\W+LAI9LD4_5[9)
M>J6ZO#!%X1E5-UF1C\Z\D6G<W<.J<G?]B:U]6VM?N_]4A>G;1@T+0]P#!ZK1
M&3TWM4UZZ`7S*\W5V"2]PX^?CO;?'Q(R&-#=3(U.S0_3T,&`-%5]KHK4[BCG
MKAIY3:U&MC2-\G15MO-'6P;`W"$P#$#(%B7PL-68(BJ.)@7&(\G)=3H[2].X
M:R[&$&7``]Z*&,*`[%'T!$<*S(?8QY`B)`$DR/L0)@#T?NOT34#[0#[0ITUI
MEVCZ,S/6T).\,):6N;4FI4UFJ+.4%N;87MGZ-]6=78]\I9*%D2`'BSJ3_@,7
M(:"`O*/C:0>7IZ%JG?EE/K:^FB``."*FM?$=5;DJ/#W/CH&K<MAB!''8FC12
M*A1#)@(F4..:DF[H9=K'D$DN6P`IT`5^?PLZJ^.Q]J/+R^.\\B?.YXV(,>3`
M1,MX"+(5H%48#&,7L(PW"G>%X1M!,B%X5]U),;$[C>M2Y<U^>-6?0@W=5I\N
MC/&9L5G.QS;7>AXL`DY/UG(9\;@]&:HXY3R-4FD4QL.-XUWM8A&V9"S&3L#K
MNC+5];.C\S0>`A$S;`&!LT[^_);XF4RXW%#\2/OX/XC?\?^=]NN+[G12/EC;
MKD>,AST>2(KDRVSKN74SG%<ZVZ:U.;7;]-O1_O[KMPMJ5L$V0^:Y]?"/&:O*
MH=K49@P<(9!!X`0@HQDEP8NGI-/R,DY6%>-1D$C10=)M],YZ`#"WINGZCX9'
MC_?5>"R;YW,N@,5<=%R@>.E@=*^F55S<JL*C@(AX!T2W]388&]<?D3HS^LQ.
1RH$*4]<I9.0OM'(5R<$*````
`
end


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbSIRQnG>; Wed, 18 Sep 2002 12:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbSIRQnG>; Wed, 18 Sep 2002 12:43:06 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:12416 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267450AbSIRQnC>; Wed, 18 Sep 2002 12:43:02 -0400
Date: Wed, 18 Sep 2002 09:42:38 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [BK PATCH] The rest of the handle_sysrq bugs
Message-ID: <Pine.LNX.4.33.0209180941190.24031-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  I found more handle_sysrq bugs. I scanned the entire tree and this is it
now.

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


ChangeSet@1.546, 2002-09-18 09:28:18-07:00, jsimmons@maxwell.earthlink.net
  More handle_sysrq fixes. That is all of them now.


 arch/um/kernel/um_arch.c     |    2 +-
 drivers/s390/char/ctrlchar.c |    2 +-
 drivers/tc/zs.c              |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
--- a/arch/um/kernel/um_arch.c	Wed Sep 18 09:39:01 2002
+++ b/arch/um/kernel/um_arch.c	Wed Sep 18 09:39:01 2002
@@ -336,7 +336,7 @@
 		      void *unused2)
 {
 #ifdef CONFIG_SYSRQ
-	handle_sysrq('p', &current->thread.regs, NULL, NULL);
+	handle_sysrq('p', &current->thread.regs, NULL);
 #endif
 	machine_halt();
 	return(0);
diff -Nru a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
--- a/drivers/s390/char/ctrlchar.c	Wed Sep 18 09:39:01 2002
+++ b/drivers/s390/char/ctrlchar.c	Wed Sep 18 09:39:01 2002
@@ -26,7 +26,7 @@

 static void
 ctrlchar_handle_sysrq(struct tty_struct *tty) {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, NULL, tty);
+	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
 #endif

diff -Nru a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c	Wed Sep 18 09:39:01 2002
+++ b/drivers/tc/zs.c	Wed Sep 18 09:39:01 2002
@@ -443,7 +443,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch24129
M'XL(`"6LB#T``]U674_;,!1]KG^%):2Q:6WB:SM?G8K88-JFL0VQ\8R,8TAI
MFC#;!3KEQ\])*8526M8Q:5M:U6EBGYQ[[SG7V<"'1NENZ\STA\.R,&@#OR^-
M[;:&XNI2Y;FGA+99WB\&7J&LNWM0ENZN/S+:-UKZTJTI<]4Q5ASG"KD)^\+*
M#%\H;;HM\-C-%3L^5]W6P=MWAWNO#Q#J]?!.)HI3]559W.LA6^H+D:=F6[C'
ME85GM2C,4%GAR7)8W4RM*"'4?0*(&`G""D+"HTI""B`XJ)10'H<<3</97AC&
M/%P",7#&`E8Q&L<)VL7@!3S$A/HD\2'&).G2N`MQAT1=0O!R=/R2X0Y!;_#3
MAK2#)/Y4:H7=NC171V9L]'=\TK]2QL/?,F%QWV"1Y[@\P3930UR4EQ[ZB%D8
M`47[LVRCSB\>"!%!T!8^K^NX.)A4]^N*^X8EQ)>9T+ZT.J]//#F++P9"H((D
M"J/J).2IC!BH*$Z(8[@BJ8]X0EW%D,8DJ!A+@IKP\@),$:WT?YC;-"-.(*X`
M"`\JARF(A("ID,@@7E7[Q:`S9B3A$#EF9VE_H+8'0HOQA(S0,O-'0W^@=*%R
M=W947YD!4(AHQ'E%(TJADHJQ])B`C'GH)D2K6*U"G]+C";"P\>9#*VJK/C'Y
M=?%JN@&-&K?2>:^2X)%>!=R!O\:KD_Q_P1U]V7R=]_8?+,4:/MYUSL"`/DR&
MUFUVSS?/-]OXF1QIK0K;V;*95B+UM#HU;?SY<&_OQ:M&&,M\6(OCCS:)WT:O
M?P`JQAF'1CC\_Q#.I./-"6=91M81#VVT0^]+9PH[^7LT4..)9-K8VO&<;JX;
MX^HM?ZWVC%)QH<ZVS<@H+U6+,3AA;@02NVX<D[B1P;V]_M^40;.[/*""ZQRL
L4WCNWH5<Y2=#RQUWJY^U\=TV,7WEDYF2`S,:]ICBJ4NV0C\!T=?@@6\*````
`
end


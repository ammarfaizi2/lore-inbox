Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbSKVAFY>; Thu, 21 Nov 2002 19:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbSKVAFY>; Thu, 21 Nov 2002 19:05:24 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:60676 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267236AbSKVAFR>; Thu, 21 Nov 2002 19:05:17 -0500
Date: Thu, 21 Nov 2002 22:12:13 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] access.h: remove include sched.h, it only needs thread_info.h
Message-ID: <20021122001213.GC31594@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there are just this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.932, 2002-11-21 22:01:05-02:00, acme@conectiva.com.br
  o uaccess.h: remove include sched.h, it only needs thread_info.h


 drivers/parport/daisy.c        |    3 +++
 drivers/parport/ieee1284_ops.c |    1 +
 fs/autofs/autofs_i.h           |    3 +++
 fs/autofs4/autofs_i.h          |    2 ++
 fs/ext2/ioctl.c                |    2 ++
 include/asm-i386/desc.h        |    3 +++
 include/asm-i386/mmu.h         |    1 +
 include/asm-i386/uaccess.h     |    2 +-
 include/pcmcia/mem_op.h        |    1 +
 ipc/msg.c                      |    2 ++
 10 files changed, 19 insertions(+), 1 deletion(-)


diff -Nru a/drivers/parport/daisy.c b/drivers/parport/daisy.c
--- a/drivers/parport/daisy.c	Thu Nov 21 22:01:28 2002
+++ b/drivers/parport/daisy.c	Thu Nov 21 22:01:28 2002
@@ -21,6 +21,9 @@
 
 #include <linux/parport.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
+
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 #define DEBUG /* undef me for production */
diff -Nru a/drivers/parport/ieee1284_ops.c b/drivers/parport/ieee1284_ops.c
--- a/drivers/parport/ieee1284_ops.c	Thu Nov 21 22:01:28 2002
+++ b/drivers/parport/ieee1284_ops.c	Thu Nov 21 22:01:28 2002
@@ -17,6 +17,7 @@
 #include <linux/config.h>
 #include <linux/parport.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 
 #undef DEBUG /* undef me for production */
diff -Nru a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
--- a/fs/autofs/autofs_i.h	Thu Nov 21 22:01:28 2002
+++ b/fs/autofs/autofs_i.h	Thu Nov 21 22:01:28 2002
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
--- a/fs/autofs4/autofs_i.h	Thu Nov 21 22:01:28 2002
+++ b/fs/autofs4/autofs_i.h	Thu Nov 21 22:01:28 2002
@@ -24,6 +24,8 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/wait.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 /* #define DEBUG */
diff -Nru a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
--- a/fs/ext2/ioctl.c	Thu Nov 21 22:01:28 2002
+++ b/fs/ext2/ioctl.c	Thu Nov 21 22:01:28 2002
@@ -9,6 +9,8 @@
 
 #include "ext2.h"
 #include <linux/time.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 
diff -Nru a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	Thu Nov 21 22:01:28 2002
+++ b/include/asm-i386/desc.h	Thu Nov 21 22:01:28 2002
@@ -6,6 +6,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/preempt.h>
+#include <linux/smp.h>
+
 #include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
diff -Nru a/include/asm-i386/mmu.h b/include/asm-i386/mmu.h
--- a/include/asm-i386/mmu.h	Thu Nov 21 22:01:28 2002
+++ b/include/asm-i386/mmu.h	Thu Nov 21 22:01:28 2002
@@ -1,6 +1,7 @@
 #ifndef __i386_MMU_H
 #define __i386_MMU_H
 
+#include <asm/semaphore.h>
 /*
  * The i386 doesn't have a mmu context, but
  * we put the segment information here.
diff -Nru a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	Thu Nov 21 22:01:28 2002
+++ b/include/asm-i386/uaccess.h	Thu Nov 21 22:01:28 2002
@@ -6,7 +6,7 @@
  */
 #include <linux/config.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/thread_info.h>
 #include <linux/prefetch.h>
 #include <asm/page.h>
 
diff -Nru a/include/pcmcia/mem_op.h b/include/pcmcia/mem_op.h
--- a/include/pcmcia/mem_op.h	Thu Nov 21 22:01:28 2002
+++ b/include/pcmcia/mem_op.h	Thu Nov 21 22:01:28 2002
@@ -30,6 +30,7 @@
 #ifndef _LINUX_MEM_OP_H
 #define _LINUX_MEM_OP_H
 
+#include <asm/io.h>
 #include <asm/uaccess.h>
 
 /*
diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Thu Nov 21 22:01:28 2002
+++ b/ipc/msg.c	Thu Nov 21 22:01:28 2002
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
1.932
## Wrapped with gzip_uu ##


begin 664 bkpatch28000
M'XL(`-ASW3T``]V96X^;1A3'GY=/,5(>VX4Y<V'`ZD9NTJJ-4JE1JCRU530>
MA@7%@`5XDTA\^!Z;O6#6&,/V8;7KE6P9Z_"?,[]S&UZ13Y4M%Q?:9-9Y17XO
MJGIQ88K<FCJ]T:XI,G=5XH6/18$7O*3(K/?FO9?F9KV-;'7)7.G@Y0^Z-@FY
ML66UN`"7WW]3?]_8Q<7'7W_[],?/'QWGZHJ\371^;?^R-;FZ<NJBO-'KJ%KJ
M.ED7N5N7.J\R6^]OW-S_M&&4,GQ)4)Q*OP&?"M48B`"T`!M1)@)?.+LU+/O:
M>U8`&#`F)/`&)%6^\PL!-^2,4.8!>`P(8PL*"RHO*7Z@Y*A1\@-0<DF=-^3_
M7<%;QY"";+4QMJK<9$%*FQ4WEMRZFU0FL9&;_$C2FA3Y^CO)K8TJ4B>EU='G
M-(\+-W'>$^"X1N?#@Z^=RXE_CD,U=5Z/+"_=&"^KKEW369Z@E#:4^4HTPBC)
MXS!6T@8K;0=\V;."&X1O%"AK?*I8,"HBKCS[K69>6IAZ?2"%ASQH@(4L;`(F
M5Z%55,5"QR!A0,HQ6QU!`@(AQ[W2;I:GJ^PRY8'O89P8-SD0)M`[0#EO8G2,
MBIE1C.DPU$/"3MD\$,B8/UU@EFT?Z\,M#%@3\P"DST)T(AC0X;GZ'DQVY#')
MS_!?5*:[1.)M=+DIRMJ+=%I][S$&02,X#_V&`X65,2H2?LC%@+I3%COR.*/!
MN#QD1&_KXO[M<]KS'4+'?<PM30"1I%$<&\$P(E=F&+KC!CO2@*D)&[LQF4FU
ME]GL<['IJ9.\82H$U<@XX!`:I544<G\ULK''3!ZX3BIQONO$H._"1M!=[F`K
MB*SE7%DF:.@/<3=LL8L=EPHF8Y=::X$%`M=;/::/*S]`^@(_9IC@(@/6\*'@
M/<-R1RUJI6>DWG[`W1>-?AQCS`%MI(B$XB`C$_NQ#/FY<7QHMBLS5)3O*_I`
M=(W7]R<$NE-_U=OK9%G:*-'U.=9\2KDO`H3?YVQ?]?FCFL].UWS^C$M^F[O^
M))?EU_T_EO`/0SLSHQMXQSC!KNY.U$_K--]^\VZUO7;^Z5Q"=#RS+4N;U[M+
MQP@Y#(#IH,P(36>SZT>?8AX!`BQ?&$D!>GK?-DX%")XQ0&W:&0'HT#-S.(*0
MP#!'.UB.E<-Q1.9792?3>8QY!/=K793Q=KU.8[NS^??='?\]5:(!.S=DPV]H
MP!3?<P'PDC)+VWKTP#CFD%EI)7A"6CE:_">@,KT+<5;7&`[U,DJCO(ZVYHM;
ME->GFA"*5'#)=IL48N#L\5!3Z6#/F(ZVMQJB0SP5#Y^P83S&X.B.<F=A,7V.
M='24KI&))0JI:EO&U;`M'W&0G.\KE*!M#^*_)!;:\?@Q"UU7S*H9,)N"@;EY
MG(8G#?%.EN;7Q=*N:^LFV].V`DYWYU$2L#PI]A(+2'LHT<-BP"=S\#A60C:E
MM=FF/N3C%IQLT]:6HWSLSRUFX#'A"&6,CHZI!S@8IA^QAT.^I*ZS/1$:8V/O
MD3EH\(-F<Y<?*IOI35*4=C!#W*]I!@43A_"C[42G[1R;QBG'89P+BI9#[%?:
MW#%YK$4^X+GRT9XRC/%Q?YL9C/RR&TC>'9M*#K0<PM([#3N?E#DG<Z=&UW&[
M,F2LX32D,._0XSEGC_;4<8".GDMFI0_V*'^D#RS</;8X8_>G/2=Q])=EMC5N
M9+NYH/>4!`(*@-6AP=)R>QX!]"5UD^W3G_[FWGEAUC0AY_61=P\S\9?F2[7-
1KBQZ/,*,[OP'"RHX*3X=````
`
end

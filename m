Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSKOLZp>; Fri, 15 Nov 2002 06:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKOLZp>; Fri, 15 Nov 2002 06:25:45 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:51726 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266108AbSKOLZl>; Fri, 15 Nov 2002 06:25:41 -0500
Date: Fri, 15 Nov 2002 09:32:23 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Kernel Janitors Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] use thread_info.h in uaccess.h
Message-ID: <20021115113223.GN18180@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Janitors Project <kernel-janitor-discuss@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling from:

bk://oops.kerneljanitors.org:hell_header-2.5

	Comments on the changeset, but its fairly trivial. Tested
with 'make allmodconfig' and 'make allyesconfig'.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.851, 2002-11-15 09:05:29-02:00, acme@conectiva.com.br
  o includes: remove include sched.h from asm-i386/uaccess.h
  
  It only needs current_thread_info, so now it includes just
  asm/thread_info.h, this way sched.h will not be included indirectly
  hundreds of times when all that is needed is copy_to_user and friends.


 fs/autofs/autofs_i.h       |    2 ++
 fs/autofs4/autofs_i.h      |    2 ++
 fs/ext2/ioctl.c            |    2 ++
 include/asm-i386/uaccess.h |    2 +-
 ipc/msg.c                  |    2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)


diff -Nru a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
--- a/fs/autofs/autofs_i.h	Fri Nov 15 09:07:06 2002
+++ b/fs/autofs/autofs_i.h	Fri Nov 15 09:07:06 2002
@@ -25,6 +25,8 @@
 #include <linux/wait.h>
 #include <linux/dcache.h>
 #include <linux/namei.h>
+#include <asm/current.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 
 #ifdef DEBUG
diff -Nru a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
--- a/fs/autofs4/autofs_i.h	Fri Nov 15 09:07:06 2002
+++ b/fs/autofs4/autofs_i.h	Fri Nov 15 09:07:06 2002
@@ -24,6 +24,8 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/wait.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 /* #define DEBUG */
diff -Nru a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
--- a/fs/ext2/ioctl.c	Fri Nov 15 09:07:06 2002
+++ b/fs/ext2/ioctl.c	Fri Nov 15 09:07:06 2002
@@ -9,6 +9,8 @@
 
 #include "ext2.h"
 #include <linux/time.h>
+#include <linux/sched.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 
diff -Nru a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	Fri Nov 15 09:07:06 2002
+++ b/include/asm-i386/uaccess.h	Fri Nov 15 09:07:06 2002
@@ -6,7 +6,7 @@
  */
 #include <linux/config.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/thread_info.h>
 #include <linux/prefetch.h>
 #include <asm/page.h>
 
diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Fri Nov 15 09:07:06 2002
+++ b/ipc/msg.c	Fri Nov 15 09:07:06 2002
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
1.851
## Wrapped with gzip_uu ##


begin 664 bkpatch25755
M'XL(`%K5U#T``^V876_;-A2&KZ-?02"7JR5^ZL-8@JSML`4=L"!#KX;!H$DJ
MTB*)@4C'-:`?OR,[=FPGBA-W=XTMV(9$'KXZ?/@>RJ?HJS/M^$2JV@2GZ'?K
M_/A$V<8H7][+4-DZG+9PX=I:N!`5MC;1QR]18:IJ4ABI33NBH0B@Q97TJD#W
MIG7C$Q*RS1F_N#/CD^M??_OZQR_707!VACX5LKDQ?QF/SLX";]M[66EW(7U1
MV2;TK6Q<;?QR[&[3M*,84W@+DC`LXH[$F">=(IH0R8G1F/(TYH_1>J$OQB*$
M"!P31D2'<49X\!F1,!4$81H1$A&!<#;&8DRS$:9CC%&?H8O]S*"?!!KAX"/Z
M?V_C4Z"0166CJIDV;HQ:4]M[LSZ!G"J,#@N4M[9&TM6CDJ5Q-)-*&>?"`CK#
M<>F1;:H%:HS1#JE9VYK&3WS1PJQ-RB:W'Y"SJ+%S5/K-4.C?F?/0&8)&6TW#
MX@/R1>G07"XVH\_+JH+^'DTWRC3\T&4+*:H6$*68-;KM1[<Y\F4-X>>%:9"$
M?KZ0,*I;JNN[@4)[MYAX.YD!CT@V&NZN-(UV8?`%Q3PC++AZ)"<8O?$5!%CB
MX/S`/)5W*JK=3:BVYHECC#M,XX1W7"6"Y5F>")-.I1E@8B]*#QHAF#'1B8R2
M]*"(W$7FFZ=1:2&-.U)8QM*.T(QF74K%-#,)3G(N<QA@0,ISL;8$<9)R\1I!
M<N;MYFM2AL6^*A8+G'0IT0+K/%><PLJ:JF%5SP?<DD8P%\GKI?%!;5G'<3]Y
M=$JT,8PEAG*<Q=DA;4\B;HFC3"3D,$VK11$]7:$["CGO!.,$=X)KGH`A:97'
MN<C8$%XOA]WA+<%L:;G/9?RP^QX_\<'T!@J!O]"E;KR>J=O0MC<OS#O&*>24
M@B/B&#^8,<&[7LS&3+SLQ?3'\&(PQ-7J^!.-VOGR`(.[>G:2CS#*2YH@&IRN
M;_#G?OP'R6%QOG6A*IO9M^@A`>>[G/'C0'O[,CY`VM-5_(@:R0A-EZ@E[Z0-
MD;:RNB'2^/>B%N^@MD?4((,/J&V7ME=!]O:Z&DA=5D#8!0AQWK2Y&XX5`UR"
M,0*F"+L&NB0K?B=KB*S5YN,I6=N)/88I0HYF:KBT'L;K>ZO]LT;V]WK,?PZ6
M?<Q@H\I@MPIE'YQR54+96_$C:$1^#/Q6FZ,]_(:3?`2)GS-$@LO^8Y_&'2T/
MZ*T?&EY!VMN>4@)Y>U<#5C?&]MVWD=I[4,&PK<"9`$)YDH@E0=F[?PT#U#_-
D[0.T3NE1U5`<YUSKOUJ@I;IUL_J,Q(I"#9/!?SP3!.#?$0``
`
end

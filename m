Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313775AbSDHWBm>; Mon, 8 Apr 2002 18:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313777AbSDHWBl>; Mon, 8 Apr 2002 18:01:41 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:57105 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S313775AbSDHWBe>; Mon, 8 Apr 2002 18:01:34 -0400
Date: Tue, 9 Apr 2002 00:01:28 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, dwmw2@redhat.com
Subject: Re: [patch] kernel-api book fixes
Message-ID: <20020408220128.GB1369@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020407184736.GA11467@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aargh, I found out that I created the changeset in my validation tree,
so it doesn't apply cleanly against the linux-2.5 tree :(
Here it is again, this time against the proper tree.


Erik


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.586, 2002-04-08 23:52:33+02:00, erik@arthur.home
  - Fix kernel-api book compile-time bugs due to moved USB source files.
  - Add kernel/context.c, kernel/exit.c, and kernel/timer.c to the list
    of source files and include their information into the kernel-api book.
  - Fix problem with comment not being just before the function in
    kernel/context.c


 Documentation/DocBook/Makefile        |   11 +++++++----
 Documentation/DocBook/kernel-api.tmpl |   11 ++++++++---
 kernel/context.c                      |    5 +++--
 3 files changed, 18 insertions(+), 9 deletions(-)


diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Mon Apr  8 23:57:04 2002
+++ b/Documentation/DocBook/Makefile	Mon Apr  8 23:57:04 2002
@@ -104,8 +104,8 @@
 		$(TOPDIR)/sound/sound_firmware.c \
 		$(TOPDIR)/drivers/net/wan/syncppp.c \
 		$(TOPDIR)/drivers/net/wan/z85230.c \
-		$(TOPDIR)/drivers/usb/hcd.c \
-		$(TOPDIR)/drivers/usb/usb.c \
+		$(TOPDIR)/drivers/usb/core/hcd.c \
+		$(TOPDIR)/drivers/usb/core/usb.c \
 		$(TOPDIR)/drivers/video/fbmem.c \
 		$(TOPDIR)/drivers/video/fbcmap.c \
 		$(TOPDIR)/drivers/video/fbcon.c \
@@ -118,13 +118,16 @@
 		$(TOPDIR)/fs/bio.c \
 		$(TOPDIR)/include/asm-i386/bitops.h \
 		$(TOPDIR)/include/linux/usb.h \
-		$(TOPDIR)/kernel/pm.c \
-		$(TOPDIR)/kernel/ksyms.c \
+		$(TOPDIR)/kernel/context.c \
+		$(TOPDIR)/kernel/exit.c \
 		$(TOPDIR)/kernel/kmod.c \
+		$(TOPDIR)/kernel/ksyms.c \
 		$(TOPDIR)/kernel/module.c \
+		$(TOPDIR)/kernel/pm.c \
 		$(TOPDIR)/kernel/printk.c \
 		$(TOPDIR)/kernel/sched.c \
 		$(TOPDIR)/kernel/sysctl.c \
+		$(TOPDIR)/kernel/timer.c \
 		$(TOPDIR)/lib/string.c \
 		$(TOPDIR)/lib/vsprintf.c \
 		$(TOPDIR)/net/netsyms.c
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Mon Apr  8 23:57:04 2002
+++ b/Documentation/DocBook/kernel-api.tmpl	Mon Apr  8 23:57:04 2002
@@ -47,7 +47,12 @@
      </sect1>
 
      <sect1><title>Delaying, scheduling, and timer routines</title>
-!Ekernel/sched.c
+!Ekernel/context.c
+!Ekernel/timer.c
+     </sect1>
+
+     <sect1><title>Misc functions</title>
+!Ekernel/exit.c
      </sect1>
   </chapter>
 
@@ -282,7 +287,7 @@
     </sect1>
 
     <sect1><title>USB Core APIs</title>
-!Edrivers/usb/usb.c
+!Edrivers/usb/core/usb.c
     </sect1>
 
     <sect1><title>Host Controller APIs</title>
@@ -290,7 +295,7 @@
     most of which implement standard register interfaces such as
     EHCI, OHCI, or UHCI.
     </para>
-!Edrivers/usb/hcd.c
+!Edrivers/usb/core/hcd.c
     </sect1>
 
   </chapter>
diff -Nru a/kernel/context.c b/kernel/context.c
--- a/kernel/context.c	Mon Apr  8 23:57:04 2002
+++ b/kernel/context.c	Mon Apr  8 23:57:04 2002
@@ -112,6 +112,9 @@
 	}
 }
 
+
+static struct tq_struct dummy_task;
+
 /**
  * flush_scheduled_tasks - ensure that any scheduled tasks have run to completion.
  *
@@ -124,8 +127,6 @@
  * The caller should hold no spinlocks and should hold no semaphores which could
  * cause the scheduled tasks to block.
  */
-static struct tq_struct dummy_task;
-
 void flush_scheduled_tasks(void)
 {
 	int count;

===================================================================


This BitKeeper patch contains the following changesets:
1.586
## Wrapped with gzip_uu ##


begin 664 bkpatch2154
M'XL(`#`2LCP``\576U/;.!1^CGZ%.MV'=MK8NOF6!8;2L+L,VRE#ES=F&-E6
ML(DOJ2538/SC5U)""$FX)-O..AE;4HX^GR-]YSO*6W@F13/HB28?@[?PKUJJ
M08\W*FL;)ZM+H<=.ZUJ/N:;G&C,W'O>5D,I-ZZ0M1:6XRNNJ3QP/:.L3KI(,
M7HM&#GK8H?,1=3L1@][IX9]G?W\Z!6!W%W[.>'4IO@D%=W>!JIMK7J1RGZNL
MJ"M'-;R2I5#<2>JRFYMV!"&B/QX.*/+\#ON(!5V"4XPYPR)%A(4^`WP\*??O
M\HF9[/!V>3Y#/J+,)W['(A82,(38\4(?(N(BYJ(0$CKPR(#2#X@,$((FZOV%
M18$?*.PC<`!_KM>?00+[\(_\!HY%4XFBSR<YC.MZ##7:)"]$7^7ZY7%[*6':
M"OUV6-;7(H5GWPZ@K-LF$7"DS:1C@3ZEZ0S(3>I*B1OE)!_O1\1-;KN\FAL9
M\,9)#*S*!"QRJ30.A/7H$;B=DE=)T:;"&.:-[HWJIK0TT.W9_*48G'EPDZ:.
M"U'"'[G*3&2&0K"J%8Q%7EW"JU::ID:T\'#45LD,V;JS'!(XABSTB`=.'A@%
M^AM>`"".P-X+&SI<)+RK>P<Z,/<A4$>5DV)ALQFB04=8$/F=3^,H(AX1GC<*
M$TI6.+4).$,AP1ZFN,.8!/1%OY>7;)&/$8TZ'P41ZA(>QRGGW,/")X3051?7
MXSQX@QA#P9:K^(6/A>'7RO+I-NW".&0>(A[F/@N"('[M\CU&7?#4]TED5>CY
M>2]+T\^(!EQ=\N9.!U3JW&KT5%F/U*O1-3`AF#+6^<S'OE4S'#T6,SR@^$DQ
M"V"?_4(QFV@\(RI/J]2"/"WJTAI!,F*T("PSG&-HM_,K[#<_[%<G],D+.[N%
M1`PQ"B`!1]@L*NCU?GOWS]>3X='I>S=M<E/QW%;&.CL:X69)JAT_?]Y(-ZS1
M$!-L<0E9PEU.N"7$1UJN?],(%.)U)F-Y6\I[&[;>9E+>&P3K#>[WX_R9Q%G2
MJVWS9RM-!2F_%E?[LI7"23<45(HC''FT0R1$>)I"9(,4"F&?_J\I]!\+O<XK
M6UP?@Q_#:7UY56(M+>PV^>4A3;PC???!F\.5.C\?FOD/H+EV7"D2A??`^:P_
M[>ZH7!5B[TLND_D)0NZXT]$'J.GJ@"$)/?/JZ>/-X?I4U681M6;VL<;,IKW-
MCI7,?3$1MBO2EO/E_B2_2[E3Y=58WS7!G@##!/DTI$A7:AH%EN;^!BS7IU[R
M2UA^;-V%,RK='PHES'1PAJ:QF!X+\PJ.&AV3*0.+9\./&D-.3\-V?`ZP,J%H
M978ADTRD;2'2"\7E^-W[.8ZAO#W#+#%^A8N;D_L(8P:I9JDT>:/=54V;**B^
I7\Q::5N6M]:AWX&M":;6S/\^:8^3L6S+7810BE/?!_\"<ZU9\[H-````
`
end



-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

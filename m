Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313414AbSDGSrn>; Sun, 7 Apr 2002 14:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSDGSrm>; Sun, 7 Apr 2002 14:47:42 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:1292 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S313414AbSDGSrl>; Sun, 7 Apr 2002 14:47:41 -0400
Date: Sun, 7 Apr 2002 20:47:36 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, dwmw2@redhat.com
Subject: [patch] kernel-api book fixes
Message-ID: <20020407184736.GA11467@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.536, 2002-04-07 18:52:05+02:00, erik@arthur.home
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
--- a/Documentation/DocBook/Makefile	Sun Apr  7 20:41:08 2002
+++ b/Documentation/DocBook/Makefile	Sun Apr  7 20:41:08 2002
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
--- a/Documentation/DocBook/kernel-api.tmpl	Sun Apr  7 20:41:08 2002
+++ b/Documentation/DocBook/kernel-api.tmpl	Sun Apr  7 20:41:08 2002
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
--- a/kernel/context.c	Sun Apr  7 20:41:08 2002
+++ b/kernel/context.c	Sun Apr  7 20:41:08 2002
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
1.536
## Wrapped with gzip_uu ##


begin 664 bkpatch17260
M'XL(`,22L#P``\57VV[;.!!]-K^"1?>A16N)%UV]29"FSFZ#;-$@W;P%""B)
MCA7KXHI4FA3Z^(YHQW%DYV)OB[4-B:2'1S/DG#/4:WRF9#7HR2J=H-?X4ZGT
MH"<J/:XK:USF$L9.RQ+&[+9GMV9V-.EKJ;0ML[2H;_K,<A&8G0@=C_&UK-2@
M1RV^&-&W4SGHG1[^??;/AU.$=G?QQ[$H+N57J?'N+M)E=2VR1.T+/<[*PM*5
M*%0NM;#B,F\6I@TCA,'7I3XGKM=0CSA^$].$4N%0F1#F!)Z#6O_VE]SO`CC$
MI]3AW&N<@%".AIA:+O<P839Q;.)C&@Q<-B#N.P)7@KMX^!W'?8(.\*]U^R.*
M<1__E=[@B:P*F?7%-,5164XPH$W33/9U"@^/ZDN%DUK"TW%>7LL$GWT]P*JL
MJUCB$9@IRP!]2)(YD!V7A98WVHK?WXW(F]1T1;$P:L$K*VYA]5CB+%4:<#`N
M1P_`S92TB+,ZD:UA6D%O5%:YT&E90'L^OQ.#M0AN6I51)G/\/=7C-K)<%AH7
MI<:13(M+?%6KM@F(!AZ/ZB*>(QMWNB&A8^SXE%!T<I]2J+_A!R$B"-I[9D.'
M95RWWII(;>@=0&#V?:"6SJ?9TF8[A/L-<_S0:SP>A2%SF73=41!SMI)3FX"W
M^>LY`8!3RGS^K-_=)5O.QY"'C4?\D#2QB*)$".%2Z3'&^*J+ZW'NO2$.M+=<
MQ<]B(MO\6ED^:/,FB`+')<REPG-\WX]>NGP/49<\]3P6&AEZ>M[SVO0KHD%7
MEZ+Z`0'EP*T*IJIRI%^,#L",4>XXC>=XU#-J1L,'8N8$`^X_*F8^[CN_4<RF
M@->*RN,JM21/R[JT1I!:,5H2ECG.,3;;^07WJ^_F!X0^>69GMY"((8759.B(
MD@!NO=X?;_[]<C(\.GUK)U7:ECR[5A&PHY+V.$[`\?.GC:!AC(:448/+6`>W
M2[@.X@,MA_\`@6.ZSF2B;G-U9^.LMYGF=P;^>H.[_3A_@C@=O=J6/UMI*DK$
MM;S:5[625K*AH'(:TM#E#6%P(IA1B&U`H0#W^?]*H?]8Z(%7IK@N@P.M9N7E
M1;SJK.LV]'()Y-T17#WTZG"ES"^&YNXCW'YV;"5C3??0^;P_Z^[H5&=R[W.J
MXL4!0NW8L]%[J-GBH"$+W/;1L]NKP_5,!;.0&S-S6V-F6&_(L4+<9WFP78TV
M*9_O3],?B;"*M)C`%?+K$3#*B,<#3J!0\]`W6>YMD.1PZ&6_)<F/C;MXGDIW
M9T*%QQ!<FZ61G)T*TP*/*HBIK0++1\/W@*%FAV$SO@!8F9#5:GRAXK%,ZDPF
M%UJHR9NW"YRVDI@C3"?C5W)Q\^0^@A<.S"%+5<L;<%=7=:RQ_G8Q;R5UGM\:
@A_Y$IB2TI6;Q^@0>QQ-5Y[N<T(A*QM!/["H<`+,-````
`
end

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

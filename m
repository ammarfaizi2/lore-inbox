Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSKUWmT>; Thu, 21 Nov 2002 17:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSKUWmT>; Thu, 21 Nov 2002 17:42:19 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:46604 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265140AbSKUWmP>; Thu, 21 Nov 2002 17:42:15 -0500
Date: Thu, 21 Nov 2002 20:49:10 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/net/wan/lmc: fix up header cleanups: remove unneeded sched.h include
Message-ID: <20021121224910.GX31594@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com,
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

	With the header cleanups there is not anymore a need to
include sched.h in those files.

	Now there are three outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.931, 2002-11-21 20:45:13-02:00, acme@conectiva.com.br
  o drivers/net/wan/lmc: fix up header cleanups: remove uneeded sched.h includes


 lmc_debug.c |    2 +-
 lmc_main.c  |   18 +++++++-----------
 lmc_media.c |   18 +++++++-----------
 lmc_proto.c |   17 ++++++++---------
 4 files changed, 23 insertions(+), 32 deletions(-)


diff -Nru a/drivers/net/wan/lmc/lmc_debug.c b/drivers/net/wan/lmc/lmc_debug.c
--- a/drivers/net/wan/lmc/lmc_debug.c	Thu Nov 21 20:47:55 2002
+++ b/drivers/net/wan/lmc/lmc_debug.c	Thu Nov 21 20:47:55 2002
@@ -1,9 +1,9 @@
 
 #include <linux/types.h>
-#include <linux/sched.h>
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
 #include <linux/version.h>
+
 #include "lmc_ver.h"
 #include "lmc_debug.h"
 
diff -Nru a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
--- a/drivers/net/wan/lmc/lmc_main.c	Thu Nov 21 20:47:55 2002
+++ b/drivers/net/wan/lmc/lmc_main.c	Thu Nov 21 20:47:55 2002
@@ -40,7 +40,7 @@
 
 #include <linux/version.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ptrace.h>
@@ -51,32 +51,28 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-
 #if LINUX_VERSION_CODE < 0x20155
 #include <linux/bios32.h>
 #endif
-
 #include <linux/in.h>
 #include <linux/if_arp.h>
-#include <asm/processor.h>             /* Processor type for cache alignment. */
-#include <asm/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
-#include <net/syncppp.h>
 #include <linux/inet.h>
 
+#include <net/syncppp.h>
+
+#include <asm/processor.h>             /* Processor type for cache alignment. */
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/dma.h>
 #if LINUX_VERSION_CODE >= 0x20200
 #include <asm/uaccess.h>
 //#include <asm/spinlock.h>
 #else				/* 2.0 kernel */
 #define ARPHRD_HDLC 513
 #endif
-
-#include <linux/module.h>
 
 #define DRIVER_MAJOR_VERSION     1
 #define DRIVER_MINOR_VERSION    34
diff -Nru a/drivers/net/wan/lmc/lmc_media.c b/drivers/net/wan/lmc/lmc_media.c
--- a/drivers/net/wan/lmc/lmc_media.c	Thu Nov 21 20:47:55 2002
+++ b/drivers/net/wan/lmc/lmc_media.c	Thu Nov 21 20:47:55 2002
@@ -3,7 +3,6 @@
 #include <linux/version.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ptrace.h>
@@ -12,28 +11,25 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-//#include <asm/smp.h>
-
 #if LINUX_VERSION_CODE < 0x20155
 #include <linux/bios32.h>
 #endif
-
 #include <linux/in.h>
 #include <linux/if_arp.h>
-#include <asm/processor.h>             /* Processor type for cache alignment. */
-#include <asm/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
-#include <net/syncppp.h>
 #include <linux/inet.h>
 
+#include <net/syncppp.h>
+
+#include <asm/processor.h>             /* Processor type for cache alignment. */
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+
 #if LINUX_VERSION_CODE >= 0x20200
 #include <asm/uaccess.h>
-//#include <asm/spinlock.h>
 #endif
 
 #include "lmc_ver.h"
diff -Nru a/drivers/net/wan/lmc/lmc_proto.c b/drivers/net/wan/lmc/lmc_proto.c
--- a/drivers/net/wan/lmc/lmc_proto.c	Thu Nov 21 20:47:55 2002
+++ b/drivers/net/wan/lmc/lmc_proto.c	Thu Nov 21 20:47:55 2002
@@ -21,7 +21,6 @@
 
 #include <linux/version.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ptrace.h>
@@ -30,22 +29,22 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <asm/smp.h>
-
 #include <linux/in.h>
 #include <linux/if_arp.h>
-#include <asm/processor.h>             /* Processor type for cache alignment. */
-#include <asm/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
-#include <net/syncppp.h>
 #include <linux/inet.h>
 #include <linux/workqueue.h>
 #include <linux/proc_fs.h>
+
+#include <net/syncppp.h>
+
+#include <asm/processor.h>             /* Processor type for cache alignment. */
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/smp.h>
 
 #include "lmc_ver.h"
 #include "lmc.h"

===================================================================


This BitKeeper patch contains the following changesets:
1.931
## Wrapped with gzip_uu ##


begin 664 bkpatch3494
M'XL(`)MBW3T``]U7;6_;-A#^'/Z*`_*M@R4>7R5C+K+6PS9TP((,_19@H"7*
MTF*)AE[<!M"/'R6GJ9,:B>WVB^<70N"9Q^>.SST\7\+'QM;3"Y.4EES"[ZYI
MIQ>)JVS2%AL3)*X,%K4WW#CG#6'N2AN^^Q`65;+J4MM,6"")-U^;-LEA8^MF
M>H$!?YQI[]=V>G'SZV\?__SEAI#9#-[GIEK:OVT+LQEI7;TQJ[2Y,FV^<E70
MUJ9J2MN.&_>//^T9I<R_)6I.I>I14:'[!%-$(]"FE(E("3+$</4<^S,OB`P9
M$P)ICT)23>:`0<P1*`L10X;`Z%3(*?()95-*8:]3^$G`A))W\&,#>$\2<)#6
MQ9#(L+)M^,E4X:I,II`5GZ%;0VY-:FM(5M94W;J90FU+M['05=:F-H4FR6T:
MY/#E?,@'0!^E(M=?$T\F1[X(H8:2MZ\$NP?V\/UG7;O6!<E."@2EV,N(Z:AG
M2<8$X]E"6VTR:_:G^R#?#R<K_<DJSA@_&7!IT\+L`:P8BWICZ((I@Y*S189"
M'`EXU_<.8,GC6)T.V!35'KR2*]YK*6,4FL5I(IG.CH7[U?,3M$KHD]&F=M$M
M]\#E7,I>*&-CGJ'*]$*Q5!V)=]?W#F#D6NE1?5Y9^+HF_9"H2&HV]E\?5NJK
MM[JS]X&KET%W=UA<E$:H)&6\1QEK-BH8_T:_Z,OZA3#!,]&O\?#^@DG]:?QX
M/;I^[1Q/D+@Y!R1_*#_<OLB4;4F<3I0CBI4L:[N\NJN=R0]UZ<DA,!(X5*F,
MXBTYD![+#NW9<2;TV(K1@?389NH4=HB1'N-X^;`[_+PJJNYS6+JT6]D@?TOF
M4GC[7$;#J!"D'^-AG490.^L&6,U]E:S7ZV'9[8[)-&7H;[7$-HVKO1%V7^$;
MN/YB&ULKR/Q#8GQ6P*R*957:J@W@3?C,X:)HW;H9MGHZ7[AOY]+2C*'H"-C+
MA;"]RKZC$HZY9\EZZ">_;P/&9<Q9K_R3&@M#_J_K8F@I#JV+;:9.*8Q!,><H
M/5GFC`[/C`^\]QVUYSWGH,^+][<>^A#22\Q_Z#I/9_Y1+3$IBVKIKNRJ]1K3
M'=8*>V\8#Z3KE10\&LFNCB5[!)/X/+B^[?</Y/I#HD[A.AOEW9/:DYWK@>9"
ICM="!-$3-I\!T9].-N4(]/%_N]\PN6NZ<H8+)BQ*2_X#5N(DL"D0````
`
end

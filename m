Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSKRMwU>; Mon, 18 Nov 2002 07:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSKRMwU>; Mon, 18 Nov 2002 07:52:20 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:36868 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262430AbSKRMwM>; Mon, 18 Nov 2002 07:52:12 -0500
Date: Mon, 18 Nov 2002 10:59:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] wdt: fix up header cleanups: add include linux/interrupt.h
Message-ID: <20021118125902.GC2093@conectiva.com.br>
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

	Now there is only this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.890, 2002-11-18 10:38:27-02:00, acme@conectiva.com.br
  o wdt: fix up header cleanups: add include linux/interrupt.h
  
  Also some cleanups removing not needed includes and initializer style.


 eurotechwdt.c |   32 +++++++++++++-----------------
 wdt_pci.c     |   60 +++++++++++++++++++++++++++++-----------------------------
 2 files changed, 44 insertions(+), 48 deletions(-)


diff -Nru a/drivers/char/eurotechwdt.c b/drivers/char/eurotechwdt.c
--- a/drivers/char/eurotechwdt.c	Mon Nov 18 10:55:26 2002
+++ b/drivers/char/eurotechwdt.c	Mon Nov 18 10:55:26 2002
@@ -27,26 +27,26 @@
  */
 
 #include <linux/config.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/smp_lock.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
-#include <asm/io.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
 static int eurwdt_is_open;
 static spinlock_t eurwdt_lock;
  
@@ -256,9 +256,9 @@
         unsigned int cmd, unsigned long arg)
 {
    static struct watchdog_info ident = {
-      options		: WDIOF_CARDRESET,
-      firmware_version	: 1,
-      identity		: "WDT Eurotech CPU-1220/1410"
+	.options	  = WDIOF_CARDRESET,
+	.firmware_version = 1,
+	.identity	  = "WDT Eurotech CPU-1220/1410",
    };
 
    int time;
@@ -396,11 +396,10 @@
         .release        = eurwdt_release,
 };
 
-static struct miscdevice eurwdt_miscdev =
-{
-        WATCHDOG_MINOR,
-        "watchdog",
-        &eurwdt_fops
+static struct miscdevice eurwdt_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &eurwdt_fops
 };
  
 /*
@@ -408,11 +407,8 @@
  *      turn the timebomb registers off.
  */
  
-static struct notifier_block eurwdt_notifier =
-{
-        eurwdt_notify_sys,
-        NULL,
-        0
+static struct notifier_block eurwdt_notifier = {
+	.notifier_call = eurwdt_notify_sys,
 };
  
 /**
diff -Nru a/drivers/char/wdt_pci.c b/drivers/char/wdt_pci.c
--- a/drivers/char/wdt_pci.c	Mon Nov 18 10:55:26 2002
+++ b/drivers/char/wdt_pci.c	Mon Nov 18 10:55:26 2002
@@ -34,29 +34,29 @@
  */
 
 #include <linux/config.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#define WDT_IS_PCI
-#include "wd501p.h"
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
-#include <asm/io.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
-
 #include <linux/pci.h>
 
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#define WDT_IS_PCI
+#include "wd501p.h"
+
 #define PFX "wdt_pci: "
 
 /*
@@ -331,12 +331,12 @@
 static int wdtpci_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
-	static struct watchdog_info ident=
-	{
-		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
-			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT,
-		1,
-		"WDT500/501PCI"
+	static struct watchdog_info ident = {
+		.options	  = WDIOF_OVERHEAT  | WDIOF_POWERUNDER |
+				    WDIOF_POWEROVER | WDIOF_EXTERN1 |
+				    WDIOF_EXTERN2   | WDIOF_FANFAULT,
+		.firmware_version = 1,
+		.identity	  = "WDT500/501PCI",
 	};
 	
 	ident.options&=WDT_OPTION_MASK;	/* Mask down to the card we have */
@@ -481,19 +481,17 @@
 	.release	= wdtpci_release,
 };
 
-static struct miscdevice wdtpci_miscdev=
-{
-	WATCHDOG_MINOR,
-	"watchdog",
-	&wdtpci_fops
+static struct miscdevice wdtpci_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &wdtpci_fops,
 };
 
 #ifdef CONFIG_WDT_501
-static struct miscdevice temp_miscdev=
-{
-	TEMP_MINOR,
-	"temperature",
-	&wdtpci_fops
+static struct miscdevice temp_miscdev = {
+	.minor	= TEMP_MINOR,
+	.name	= "temperature",
+	.fops	= &wdtpci_fops,
 };
 #endif
 
@@ -502,11 +500,8 @@
  *	turn the timebomb registers off. 
  */
  
-static struct notifier_block wdtpci_notifier=
-{
-	wdtpci_notify_sys,
-	NULL,
-	0
+static struct notifier_block wdtpci_notifier = {
+	.notifier_call = wdtpci_notify_sys,
 };
 
 
@@ -594,7 +589,12 @@
 
 
 static struct pci_device_id wdtpci_pci_tbl[] __initdata = {
-	{ PCI_VENDOR_ID_ACCESSIO, PCI_DEVICE_ID_WDG_CSM, PCI_ANY_ID, PCI_ANY_ID, },
+	{
+		.vendor	   = PCI_VENDOR_ID_ACCESSIO,
+		.device	   = PCI_DEVICE_ID_WDG_CSM,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+	},
 	{ 0, }, /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, wdtpci_pci_tbl);

===================================================================


This BitKeeper patch contains the following changesets:
1.890
## Wrapped with gzip_uu ##


begin 664 bkpatch15190
M'XL(`#[CV#T``]U7;6_B1A#^C'_%*)'ZI0%VO;M^0<WI..PDZ"X!$9*T:BMK
M8R_!.K"1O227UOWOG74(>2=WU_3+`<)X9G9>GIEY@&TX*571:<AXKJQM.,A+
MW6G$>:9BG5[*5IS/6^<%*D9YCHKV-)^K]H>/[32+9\M$E4V[)2Q4#Z6.IW"I
MBK+3H"VVENCKA>HT1N'^R:?NR+)V=Z$WE=F%.E8:=G<MG1>7<I:4[Z6>SO*L
MI0N9E7.EZ\#5VK2R";'Q*:C+B'`JZA#N5C%-*)6<JH38W'.X96IX_SCW1UXH
MI1YAPB>B(L)EU`J`MCR?`+';E+:I!Y1TF->QW2:Q.X3`LT[A9QN:Q/H`;UM`
MSXHAAZM$=V"2?H'E`J9*)JJ`>*9DMER4'9!)`BOP899FRR_8"JV*8KG0K2D>
MQU=W5N908J/6QZ!0\_PRS2X@RS5D2B5J[:4$F9F;5*=REOZ%P4I]/5,MZR-P
MQGUK>-<QJ_F-#\LBDECO8&%FX7F(DB(U4]..I[)HJV61:Q5/$8%6O,8,WWSN
M5]SV'5)102;L7/J)%.?*<Y+G^_.:6S,%U&:>S2KF>([`'#=W\H$_]!,MXO1>
MBM3EA+@5H[[C58S;SKGD$TXFPI_$SM>D^-#EO?0$=SU6+\[+)9E-^A\AMN14
M2L0E+>8RG;4RI7^_!>O/UX$F'O5M*A!HUV%NO6[NDV5CFY>-<FA2[T=?MYM)
M'$"SN*I?N#_##5W_CFWLVSY0:_NVH%^>5/3."I@`VPJX#<SJ<Q_X/7-9SMMI
M;JP>RI8RCE59/E64UZ56<R/_PPILX1N?MD/QTFCE"YWF6=D`V(6SH#_8BWK=
M43`*C\/Q#JHG.&U7LE"1J1X-T8H:>9JH3*?ZNCZW=1:,(5R!`KWA29/:-FE3
M3LG6#I;B^R"P"L*PC%)+G<:(=K&,-<S3,D[491HK0%#-]JTDZ/5O##-/L[QH
M8&;=<>\@&.Q'A_VCP<@DD,FY0L76E5FX)+_8JK/-%R4*?UKY,K>((:5U>&H0
M?1@>YR*=I*J(SF=Y_/DVA5OI*H>U42QG,Y3=M[J.$-N=I[RPYI'7OUW_"Z5]
M/24\)K85'8B*,\)Y30>XW=_(!XQ`D_WP7[\WU+^)#];@?@\7,.=5+D`6P!](
MO&8$07!M`^'@YSYNLOM6O+"=J$F:*>2`<=0_CH:]_IWQUE4B"%VTIEN&0!CC
MX&#>S,=+X^%"W6YCE&:3'&J2N-FBYXAF<!J.#L+N&*!:28:#LW!T<A2$(ZCP
M3`.-X;[*G%@;A[^.P]$1?6)Y([?ASNU>]VBO>_+)$-J+C/8,I0E"VE@W0F%8
MC'N\IA'/V\1B.`HX"6_#8BM?YM;$]^TZON]LBH_]7+P0?1P>#I]&-@=4(?6R
M4!N""R),<$'\USAT=>X5#KUOM>+00/@NCGG?7'"NZIFY5%F"N8/I"+8A.@V/
M@L$HZ@=1M]<+CX_[@[IS-[7?F07A:;\7&K.S8#_J'1_65N7R_,;?RJI[]!N:
CW*I6^#U2_;-S]Z\JGJKX<[F<[[I*.-2?N-:_(%TIN;4-````
`
end

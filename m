Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129808AbRBBU7B>; Fri, 2 Feb 2001 15:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130129AbRBBU6w>; Fri, 2 Feb 2001 15:58:52 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:59592 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130214AbRBBU6q>; Fri, 2 Feb 2001 15:58:46 -0500
Date: Fri, 2 Feb 2001 21:42:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
cc: Frank de Lange <frank@unternet.org>, linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
In-Reply-To: <20010202145504.A607@grobbebol.xs4all.nl>
Message-ID: <Pine.GSO.3.96.1010202213824.19076D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Roeland Th. Jansen wrote:

> ok, just loaded 2.4.1 again with Maciej's patch. works fine but here too
> -- flood ping kills the ethernet stuff in a few seconds. in fact, within
> approx 800 interrupts. the god news is that teh system stays alive, just
> as with Alan's -ac1 version.

 Could you please apply the following patch, wait for a lockup, then hit
SysRq+A (you need to have CONFIG_MAGIC_SYSRQ enabled) and send me the
resulting output?  You need to include debug messages, so I recommend to
use `dmesg' for getting the log.

 I'd like to know if the conditions are the same as previously.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.0-test11-pic_debug-0
diff -up --recursive --new-file linux-2.4.0-test11.macro/arch/i386/kernel/io_apic.c linux-2.4.0-test11/arch/i386/kernel/io_apic.c
--- linux-2.4.0-test11.macro/arch/i386/kernel/io_apic.c	Thu Oct  5 21:08:17 2000
+++ linux-2.4.0-test11/arch/i386/kernel/io_apic.c	Sun Nov 26 12:39:01 2000
@@ -692,7 +692,7 @@ void __init UNEXPECTED_IO_APIC(void)
 	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
 }
 
-void __init print_IO_APIC(void)
+void /*__init*/ print_IO_APIC(void)
 {
 	int apic, i;
 	struct IO_APIC_reg_00 reg_00;
diff -up --recursive --new-file linux-2.4.0-test11.macro/drivers/char/sysrq.c linux-2.4.0-test11/drivers/char/sysrq.c
--- linux-2.4.0-test11.macro/drivers/char/sysrq.c	Tue Nov 14 10:24:52 2000
+++ linux-2.4.0-test11/drivers/char/sysrq.c	Sun Nov 26 12:42:11 2000
@@ -72,6 +72,15 @@ void handle_sysrq(int key, struct pt_reg
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq: ");
 	switch (key) {
+	case 'a':
+		printk("\n");
+		printk("print_PIC()\n");
+		print_PIC();
+		printk("print_IO_APIC()\n");
+		print_IO_APIC();
+		printk("print_all_local_APICs()\n");
+		print_all_local_APICs();
+		break;
 	case 'r':					    /* R -- Reset raw mode */
 		if (kbd) {
 			kbd->kbdmode = VC_XLATE;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

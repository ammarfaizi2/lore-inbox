Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSKYTnt>; Mon, 25 Nov 2002 14:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSKYTns>; Mon, 25 Nov 2002 14:43:48 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:5561
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265581AbSKYTnr>; Mon, 25 Nov 2002 14:43:47 -0500
Date: Mon, 25 Nov 2002 14:54:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: e7500 and IRQ assignment
In-Reply-To: <Pine.LNX.4.50.0211251429070.1462-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0211251448420.1462-100000@montezuma.mastecende.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB1994@xch-a.win.zambeel.com>
 <200211251618.28510.gabrielli@roma2.infn.it>
 <Pine.LNX.4.50.0211251038280.1462-100000@montezuma.mastecende.com>
 <200211251934.47959.gabrielli@roma2.infn.it>
 <Pine.LNX.4.50.0211251429070.1462-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Zwane Mwaikambo wrote:

> Please humour me here (you only have 20 IRQ sources and everything looks
> properly wired on IOAPIC#2 ;)

Forgot something (cheers Bill)

Index: linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apicdef.h
--- linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h	18 Nov 2002 01:38:42 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/include/asm-i386/apicdef.h	25 Nov 2002 19:30:45 -0000
@@ -115,7 +115,7 @@
 #ifdef CONFIG_MULTIQUAD
 #define MAX_IO_APICS	32
 #else
-#define MAX_IO_APICS	8
+#define MAX_IO_APICS	1
 #endif

 #define		APIC_BROADCAST_ID_XAPIC		0xFF
Index: linux-2.4.20-rc1-ac4/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mpparse.c
--- linux-2.4.20-rc1-ac4/arch/i386/kernel/mpparse.c	18 Nov 2002 01:39:49 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/arch/i386/kernel/mpparse.c	25 Nov 2002 19:46:59 -0000
@@ -299,7 +299,7 @@
 	if (nr_ioapics >= MAX_IO_APICS) {
 		printk("Max # of I/O APICs (%d) exceeded (found %d).\n",
 			MAX_IO_APICS, nr_ioapics);
-		panic("Recompile kernel with bigger MAX_IO_APICS!.\n");
+		return;
 	}
 	if (!m->mpc_apicaddr) {
 		printk(KERN_ERR "WARNING: bogus zero I/O APIC address"
-- 
function.linuxpower.ca

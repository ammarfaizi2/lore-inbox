Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUBYO31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUBYO31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:29:27 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:55822 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S261339AbUBYO3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:29:18 -0500
Date: Wed, 25 Feb 2004 15:29:14 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH?] 2.6.3 - unresolved isa_* symbols on alpha
Message-ID: <20040225142914.GL16814@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On alpha CONFIG_ISA is set (to y), but isa_virt_to_bus, isa_page_to_bus,
isa_bus_to_virt are not defined, which results in the following
unresolved symbols:

*** Warning: "isa_virt_to_bus" [drivers/scsi/wd7000.ko] undefined!
*** Warning: "isa_page_to_bus" [drivers/scsi/wd7000.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/scsi/wd7000.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/char/tpqic02.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/char/synclink.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/net/ni65.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/ni65.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/net/ni52.ko] undefined!
*** Warning: "isa_virt_to_bus" [net/irda/irda.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/cs89x0.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/net/3c515.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/3c515.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/3c505.ko] undefined!

Because virt_to_bus, page_to_bus, bus_to_virt are defined in
asm-alpha/io.h, I copied three defines from asm-i386/io.h - I'm not sure
if it's correct (and should it be in __KERNEL__ or outside __KERNEL__
part), but at least it avoids these unresolved symbols.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-alpha-isa.patch"

--- linux-2.6.3/include/asm-alpha/io.h.orig	2004-02-18 04:59:27.000000000 +0100
+++ linux-2.6.3/include/asm-alpha/io.h	2004-02-25 13:42:10.000000000 +0100
@@ -131,6 +131,15 @@
 #endif /* !__KERNEL__ */
 
 /*
+ * taken from asm-i386
+ * ("ISA I/O bus memory addresses are 1:1 with the physical address")
+ * is it correct?
+ */
+#define isa_virt_to_bus virt_to_phys
+#define isa_page_to_bus page_to_phys
+#define isa_bus_to_virt phys_to_virt
+
+/*
  * There are different chipsets to interface the Alpha CPUs to the world.
  */
 

--8NvZYKFJsRX2Djef--

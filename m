Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263042AbSJBLTr>; Wed, 2 Oct 2002 07:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263045AbSJBLTr>; Wed, 2 Oct 2002 07:19:47 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:21776 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S263042AbSJBLTq>; Wed, 2 Oct 2002 07:19:46 -0400
Date: Wed, 2 Oct 2002 13:23:52 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 Compile fix for UP-NOAPIC-ACPI
Message-ID: <20021002112352.GD1952@tmathiasen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-OS: Linux 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Seems 2.5.40 won't compile on UP when no local apic is used and ACPI is
enabled.

Not sure attached patch is 100% correct, but it seems to work for me.

Cheers,
Torben

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="up-acpi-compile.diff"

--- linux-2.5.40-vanilla/arch/i386/kernel/mpparse.c	Tue Oct  1 09:06:28 2002
+++ linux-2.5.40/arch/i386/kernel/mpparse.c	Wed Oct  2 13:14:18 2002
@@ -784,6 +784,8 @@
 
 #ifdef CONFIG_ACPI_BOOT
 
+#ifdef CONFIG_X86_LOCAL_APIC 
+
 void __init mp_register_lapic_address (
 	u64			address)
 {
@@ -1127,4 +1129,6 @@
 
 #endif /*CONFIG_X86_IO_APIC*/
 
+#endif /*CONFIG_X86_LOCAL_APIC*/
+
 #endif /*CONFIG_ACPI_BOOT*/

--6sX45UoQRIJXqkqR--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSLQUN5>; Tue, 17 Dec 2002 15:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbSLQUN5>; Tue, 17 Dec 2002 15:13:57 -0500
Received: from poup.poupinou.org ([195.101.94.96]:61191 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267034AbSLQUNz>; Tue, 17 Dec 2002 15:13:55 -0500
Date: Tue, 17 Dec 2002 21:21:42 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] acpi_wakeup fixes
Message-ID: <20021217202142.GB1012@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pavel.

This diff should be OK (I hope)

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_acpi_wakeup.S.fix"

--- linux-2.5.52/arch/i386/kernel/acpi_wakeup.S	2002/12/17 19:15:12	1.1
+++ linux-2.5.52/arch/i386/kernel/acpi_wakeup.S	2002/12/17 20:03:40
@@ -41,7 +41,7 @@
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
-#if 1
+#if 0
 	lcall   $0xc000,$3
 #endif
 #if 0
@@ -69,8 +69,12 @@
 
 	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0
+
+	# flush the prefetch queue.
 	jmp 1f
+1:	jmp 1f
 1:
+
 	movw	$0x0e00 + 'n', %fs:(0x14)
 
 	movl	real_magic - wakeup_code, %eax
@@ -160,11 +164,12 @@
 	ALIGN
 
 
-.org	0x2000
+.org	0x800
 wakeup_stack:
-.org	0x3000
+.org	0x900
 ENTRY(wakeup_end)
-.org	0x4000
+# .org	0x1000
+	.align 4096
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax

--UugvWAfsgieZRqgk--

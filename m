Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268423AbTBNMzZ>; Fri, 14 Feb 2003 07:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268421AbTBNMxW>; Fri, 14 Feb 2003 07:53:22 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:23566 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268410AbTBNMwv>;
	Fri, 14 Feb 2003 07:52:51 -0500
Date: Fri, 14 Feb 2003 15:58:06 +0300
To: linux-kernel@vger.kernel.org
Subject: [PATCH] visws: export boottime gdt descriptor (4/13)
Message-ID: <20030214125806.GD8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This simple patch exports boottime gdt descriptor from trampoline.S.
Visws uses it to initialize bootup cpu before running the rest of head.S

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-boot_gdt

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/kernel/trampoline.S linux-2.5.60/arch/i386/kernel/trampoline.S
--- linux-2.5.60.vanilla/arch/i386/kernel/trampoline.S	Tue Jan 14 12:32:27 2003
+++ linux-2.5.60/arch/i386/kernel/trampoline.S	Fri Feb 14 15:12:28 2003
@@ -46,8 +47,8 @@
 	movl	$0xA5A5A5A5, trampoline_data - r_base
 				# write marker for master knows we're running
 
-	lidt	idt_48 - r_base	# load idt with 0, 0
-	lgdt	gdt_48 - r_base	# load gdt with whatever is appropriate
+	lidt	boot_idt - r_base	# load idt with 0, 0
+	lgdt	boot_gdt - r_base	# load gdt with whatever is appropriate
 
 	xor	%ax, %ax
 	inc	%ax		# protected mode (PE) bit
@@ -57,7 +58,7 @@
 	ljmpl	$__BOOT_CS, $0x00100000
 			# jump to startup_32 in arch/i386/kernel/head.S
 
-idt_48:
+boot_idt:
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
 
@@ -65,8 +66,7 @@
 # NOTE: here we actually use CPU#0's GDT - but that is OK, we reload
 # the proper GDT shortly after booting up the secondary CPUs.
 #
-
-gdt_48:
+ENTRY(boot_gdt)
 	.word	__BOOT_DS + 7			# gdt limit
 	.long	boot_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 

--VdOwlNaOFKGAtAAV--

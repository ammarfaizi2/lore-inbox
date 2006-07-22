Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWGVAFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWGVAFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWGVAFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:05:42 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:24288 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750875AbWGVAFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:05:41 -0400
Subject: [PATCH 2/6] reboot.c to use struct Xgt_desc_struct
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       Pratap <pratap@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1153526643.13699.18.camel@localhost.localdomain>
References: <1153526643.13699.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 22 Jul 2006 10:05:31 +1000
Message-Id: <1153526732.13699.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/reboot.c defines its own struct to describe an ldt
entry: it should use struct Xgt_desc_struct (currently load_ldt is a
macro, so doesn't complain: paravirt patches make it warn).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Index: working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/reboot.c
===================================================================
--- working-2.6.18-rc2-hg-paravirt.orig/arch/i386/kernel/reboot.c	2006-07-22 07:58:11.000000000 +1000
+++ working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/reboot.c	2006-07-22 07:58:34.000000000 +1000
@@ -145,14 +145,10 @@
 	0x000092000100ffffULL	/* 16-bit real-mode 64k data at 0x00000100 */
 };
 
-static struct
-{
-	unsigned short       size __attribute__ ((packed));
-	unsigned long long * base __attribute__ ((packed));
-}
-real_mode_gdt = { sizeof (real_mode_gdt_entries) - 1, real_mode_gdt_entries },
-real_mode_idt = { 0x3ff, NULL },
-no_idt = { 0, NULL };
+static struct Xgt_desc_struct
+real_mode_gdt = { sizeof (real_mode_gdt_entries) - 1, (long)real_mode_gdt_entries },
+real_mode_idt = { 0x3ff, 0 },
+no_idt = { 0, 0 };
 
 
 /* This is 16-bit protected mode code to disable paging and the cache,

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law


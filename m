Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWHCAZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWHCAZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWHCAZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:51 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:43993 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750867AbWHCAZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:50 -0400
Message-Id: <20060803002517.929879494@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:11 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 1/8] Remove locally-defined ldt structure in favour of standard type.
Content-Disposition: inline; filename=001a-reboot-use-struct.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/reboot.c defines its own struct to describe an ldt
entry: it should use struct Xgt_desc_struct (currently load_ldt is a
macro, so doesn't complain: paravirt patches make it warn).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/reboot.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)


===================================================================
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -145,14 +145,10 @@ real_mode_gdt_entries [3] =
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


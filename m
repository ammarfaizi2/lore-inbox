Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbUJ1WSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUJ1WSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUJ1WOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:14:08 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:62080 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263094AbUJ1WLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:11:51 -0400
Date: Fri, 29 Oct 2004 00:11:48 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH[ Export __PAGE_KERNEL_EXEC for modules (vmmon)
Message-ID: <20041028221148.GE24972@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,
  recently support for NX on i386 arrived to 2.6.x kernel, and I have
some problems building code which uses vmap since then - PAGE_KERNEL_EXEC
expands to __PAGE_KERNEL_EXEC, and this one is not accessible to modules.

  Or should I just use __pgprot(__PAGE_KERNEL & ~_PAGE_NX) or
__pgprot(_PAGE_KERNEL_EXEC) instead as pgprot argument to vmap?
						Thanks,
							Petr Vandrovec



--- linux/arch/i386/kernel/i386_ksyms.c	2004-10-27 22:55:58.000000000 +0200
+++ linux/arch/i386/kernel/i386_ksyms.c	2004-10-28 23:59:22.000000000 +0200
@@ -179,6 +179,7 @@
 #endif
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+EXPORT_SYMBOL(__PAGE_KERNEL_EXEC);
 
 #ifdef CONFIG_HIGHMEM
 EXPORT_SYMBOL(kmap);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVKDWHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVKDWHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVKDWHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:07:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750999AbVKDWHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:07:48 -0500
Date: Fri, 4 Nov 2005 17:07:37 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] export ia64_max_cacheline_size
Message-ID: <20051104220737.GA16551@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on ia64, dma_get_cache_alignment() needs ia64_max_cacheline_size,
which isn't exported. This breaks modular compilation of the b44
network driver (and possibly others).

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.14/arch/ia64/kernel/setup.c~	2005-11-04 17:05:23.000000000 -0500
+++ linux-2.6.14/arch/ia64/kernel/setup.c	2005-11-04 17:05:40.000000000 -0500
@@ -92,6 +92,7 @@ extern void efi_initialize_iomem_resourc
 extern char _text[], _end[], _etext[];
 
 unsigned long ia64_max_cacheline_size;
+EXPORT_SYMBOL(ia64_max_cacheline_size);
 unsigned long ia64_iobase;	/* virtual address for I/O accesses */
 EXPORT_SYMBOL(ia64_iobase);
 struct io_space io_space[MAX_IO_SPACES];

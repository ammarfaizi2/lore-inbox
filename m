Return-Path: <linux-kernel-owner+w=401wt.eu-S1750760AbWLLAEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWLLAEW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 19:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWLLAEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 19:04:22 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:46164 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbWLLAEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 19:04:22 -0500
Date: Mon, 11 Dec 2006 19:03:59 -0500
From: Kyle McMartin <kyle@ubuntu.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Whinge in paging_init if noexec is on with a non-PAE kernel
Message-ID: <20061212000359.GB4044@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kyle McMartin <kyle@canonical.com>

diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
index 84697df..fb61709 100644
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -512,6 +512,9 @@ void __init paging_init(void)
 	set_nx();
 	if (nx_enabled)
 		printk("NX (Execute Disable) protection: active\n");
+#else
+	if (!disable_nx)
+		printk("NX (Execute Disable) only supported with CONFIG_HIGHMEM64G\n");
 #endif
 
 	pagetable_init();

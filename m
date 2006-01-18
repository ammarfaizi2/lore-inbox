Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWARACk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWARACk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWARACk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:02:40 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:38824 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964808AbWARACk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:02:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=YTuAAW/MlCBh+KuqXeSEPs8UEuk6McL2COGgK3ew2JYv+8wQ9esbSeWPPxQfcm4yHJFuu+7VpzhFQN0etNeG+fJC+kPE93+s2U1oKifi3IuSuS+ehJh6O/FaxRwv5APSHtywiECoai0vE3xBzOlB1GvsrE4ksDbCWI0niTK/C6k=
Date: Wed, 18 Jan 2006 03:20:00 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix parisc build (flush_tlb_all_local)
Message-ID: <20060118002000.GA24835@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's taking "void *" now.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/parisc/mm/init.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -792,8 +792,6 @@ map_hpux_gateway_page(struct task_struct
 EXPORT_SYMBOL(map_hpux_gateway_page);
 #endif
 
-extern void flush_tlb_all_local(void);
-
 void __init paging_init(void)
 {
 	int i;
@@ -802,7 +800,7 @@ void __init paging_init(void)
 	pagetable_init();
 	gateway_init();
 	flush_cache_all_local(); /* start with known state */
-	flush_tlb_all_local();
+	flush_tlb_all_local(NULL);
 
 	for (i = 0; i < npmem_ranges; i++) {
 		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0 };
@@ -993,7 +991,7 @@ void flush_tlb_all(void)
 	    do_recycle++;
 	}
 	spin_unlock(&sid_lock);
-	on_each_cpu((void (*)(void *))flush_tlb_all_local, NULL, 1, 1);
+	on_each_cpu(flush_tlb_all_local, NULL, 1, 1);
 	if (do_recycle) {
 	    spin_lock(&sid_lock);
 	    recycle_sids(recycle_ndirty,recycle_dirty_array);


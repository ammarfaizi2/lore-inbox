Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbULQTPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbULQTPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbULQTPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:15:38 -0500
Received: from roadrunner-base.egenera.com ([63.160.166.46]:42678 "EHLO
	coyote.egenera.com") by vger.kernel.org with ESMTP id S262124AbULQTPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:15:24 -0500
Date: Fri, 17 Dec 2004 14:14:59 -0500
From: Philip R Auld <pauld@egenera.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Trivial - fix memory leak in free_percpu
Message-ID: <20041217191459.GD20026@vienna.egenera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This fixes a memory leak where the percpu internal structure is 
not freed. Repeated add/remove device illustrates the leak nicely.

Please apply.

Thanks,

	Phil


Signed-off-by: Philip R. Auld <pauld@egenera.com>

diff -rupN linux-2.6.10-rc3-clean/mm/slab.c linux-2.6.10-rc3/mm/slab.c
--- linux-2.6.10-rc3-clean/mm/slab.c	2004-12-03 16:55:13.000000000 -0500
+++ linux-2.6.10-rc3/mm/slab.c	2004-12-17 11:08:45.377108680 -0500
@@ -2573,6 +2573,7 @@ free_percpu(const void *objp)
 			continue;
 		kfree(p->ptrs[i]);
 	}
+	kfree(p);
 }
 
 EXPORT_SYMBOL(free_percpu);


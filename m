Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVIXAFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVIXAFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 20:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVIXAFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 20:05:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35732 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751350AbVIXAFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 20:05:19 -0400
Date: Fri, 23 Sep 2005 17:05:07 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alok Kataria <alokk@calsoftinc.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <433458B6.7000008@calsoftinc.com>
Message-ID: <Pine.LNX.4.62.0509231700310.25804@schroedinger.engr.sgi.com>
References: <433458B6.7000008@calsoftinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch was not send inline. So this is going to look at a bit strange.
Comments on the code:

@@ -2852,6 +2860,8 @@
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
+	if (nodeid == numa_node_id())
+		____cache_alloc(cachep, flags);
 	ptr = __cache_alloc_node(cachep, flags, nodeid);

This should be 

		ptr = ___cache_alloc(cachep, flags)
	else
		ptr = __cache_alloc_node(...)

right?

 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));


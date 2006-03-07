Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWCGR1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWCGR1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWCGR1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:27:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:37564 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751372AbWCGR1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:27:01 -0500
Date: Tue, 7 Mar 2006 11:26:51 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: ak@muc.de
Cc: mulix@mulix.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86-64: free_bootmem_node needs __pa in allocate_aperture
Message-ID: <20060307172651.GA26662@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

free_bootmem_node expects a physical address to be passed in, but
__alloc_bootmem_node returns a virtual one.  That address needs to be
translated to physical.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 5647dfd5ed8a arch/x86_64/kernel/aperture.c
--- a/arch/x86_64/kernel/aperture.c	Tue Mar  7 02:47:07 2006
+++ b/arch/x86_64/kernel/aperture.c	Tue Mar  7 10:59:55 2006
@@ -60,7 +60,7 @@
 		printk("Cannot allocate aperture memory hole (%p,%uK)\n",
 		       p, aper_size>>10);
 		if (p)
-			free_bootmem_node(nd0, (unsigned long)p, aper_size); 
+			free_bootmem_node(nd0, __pa(p), aper_size); 
 		return 0;
 	}
 	printk("Mapping aperture over %d KB of RAM @ %lx\n",

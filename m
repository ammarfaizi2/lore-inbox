Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161561AbWJDQax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161561AbWJDQax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWJDQax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:30:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:61670 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161540AbWJDQav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:30:51 -0400
Message-Id: <20061004161505.407284000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:18 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 08/14] spufs: remove support for ancient firmware
Content-Disposition: inline; filename=spufs-no-spc-devnode.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any firmware that still uses the 'spc' nodes already
stopped running for other reasons, so lets get rid of this.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -791,18 +791,6 @@ static int __init init_spu_base(void)
 			break;
 		}
 	}
-	/* in some old firmware versions, the spe is called 'spc', so we
-	   look for that as well */
-	for (node = of_find_node_by_type(NULL, "spc");
-			node; node = of_find_node_by_type(node, "spc")) {
-		ret = create_spu(node);
-		if (ret) {
-			printk(KERN_WARNING "%s: Error initializing %s\n",
-				__FUNCTION__, node->name);
-			cleanup_spu_base();
-			break;
-		}
-	}
 	return ret;
 }
 module_init(init_spu_base);

--


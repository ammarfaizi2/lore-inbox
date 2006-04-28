Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWD1RAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWD1RAt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWD1RAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:48 -0400
Received: from [198.99.130.12] ([198.99.130.12]:34776 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751739AbWD1RAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:46 -0400
Message-Id: <200604281601.k3SG14wD007517@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Victor V. Vengerov" <Victor.Vengerov@oktetlabs.ru>
Subject: [PATCH 1/6] UML - Fix iomem list traversal
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Apr 2006 12:01:04 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Victor V. Vengerov" <Victor.Vengerov@oktetlabs.ru>

We need to walk the region list properly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/physmem.c	2006-04-03 08:48:13.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/physmem.c	2006-04-05 11:16:38.000000000 -0400
@@ -407,6 +407,8 @@ unsigned long find_iomem(char *driver, u
 			*len_out = region->size;
 			return(region->virt);
 		}
+
+		region = region->next;
 	}
 
 	return(0);


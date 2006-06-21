Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWFUR5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWFUR5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWFUR5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:57:03 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:32165 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1750739AbWFUR5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:57:01 -0400
Date: Wed, 21 Jun 2006 10:57:00 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: akpm@osdl.org
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix "Trying to free nonexistent resource" format string
Message-ID: <20060621175700.GA4620@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.17-mm1, the patch
gregkh-pci-64bit-resource-fix-up-printks-for-resources-in-arch-and-core-code.patch
has some formatting bugs.
 * converts %08x into %16llx, which results in space-padding rather than
   zero-padding.
 * some casts are insufficiently touchy-feely with their castees.

This patch fixes them.

Signed-off-by: Andy Isaacson <adi@hexapodia.org>

Index: q-2.6.17-mm1/kernel/resource.c
===================================================================
--- q-2.6.17-mm1.orig/kernel/resource.c	2006-06-21 10:55:05.000000000 -0700
+++ q-2.6.17-mm1/kernel/resource.c	2006-06-21 10:55:49.000000000 -0700
@@ -558,8 +558,8 @@
 	write_unlock(&resource_lock);
 
 	printk(KERN_WARNING "Trying to free nonexistent resource "
-		"<%16llx-%16llx>\n", (unsigned long long)start,
-		(unsigned long long) end);
+		"<%016llx-%016llx>\n", (unsigned long long)start,
+		(unsigned long long)end);
 }
 
 EXPORT_SYMBOL(__release_region);

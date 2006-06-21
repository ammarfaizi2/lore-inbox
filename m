Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWFUR32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWFUR32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWFUR31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:29:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60355 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750949AbWFUR31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:29:27 -0400
Date: Wed, 21 Jun 2006 13:29:03 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 64bit resources start end value fix
Message-ID: <20060621172903.GC9423@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

While changing 64bit kconfig options to CONFIG_RESOURCES_64BIT, I forgot
to update the values of start and end fields in ioport_resource and
iomem_resource.

Following patch applies on top of your reworked 64 bit patches and
is based on Andrew Morton's patch. Please apply.

http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115087406130723&w=2

Thanks
Vivek



o Update start and end fields for 32bit and 64bit resources.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-1M-vivek/kernel/resource.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN kernel/resource.c~64bit-resources-start-end-value-fix kernel/resource.c
--- linux-2.6.17-1M/kernel/resource.c~64bit-resources-start-end-value-fix	2006-06-21 12:43:43.000000000 -0400
+++ linux-2.6.17-1M-vivek/kernel/resource.c	2006-06-21 12:44:59.000000000 -0400
@@ -23,7 +23,7 @@
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
-	.start	= 0x0000,
+	.start	= 0,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
@@ -32,8 +32,8 @@ EXPORT_SYMBOL(ioport_resource);
 
 struct resource iomem_resource = {
 	.name	= "PCI mem",
-	.start	= 0UL,
-	.end	= ~0UL,
+	.start	= 0,
+	.end	= -1,
 	.flags	= IORESOURCE_MEM,
 };
 
_

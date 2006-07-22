Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWGVQS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWGVQS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWGVQS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:18:26 -0400
Received: from twin.jikos.cz ([213.151.79.26]:35989 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750843AbWGVQS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:18:26 -0400
Date: Sat, 22 Jul 2006 18:15:58 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: len.brown@intel.com
cc: linux-acpi@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
Message-ID: <Pine.LNX.4.58.0607221801240.30557@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

drivers/acpi/pci_link.c::acpi_pci_link_set() sets the GFP_ATOMIC for
kmalloc() allocation for no first-sight obvious reason; as far as I can
see this is always called outside the atomic/interrupt context, so
GFP_KERNEL allocation should be used instead.

If applicable, please apply

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- drivers/acpi/pci_link.c.orig	2006-07-15 21:00:43.000000000 +0200
+++ drivers/acpi/pci_link.c	2006-07-22 17:45:11.000000000 +0200
@@ -318,7 +318,7 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
 	if (!resource)
 		return_VALUE(-ENOMEM);
 
 

-- 
JiKos.

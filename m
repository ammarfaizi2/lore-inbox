Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVLKNIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVLKNIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 08:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVLKNIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 08:08:47 -0500
Received: from smtp07.web.de ([217.72.192.225]:16047 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S1751357AbVLKNIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 08:08:46 -0500
Message-ID: <439C24DB.3050307@web.de>
Date: Sun, 11 Dec 2005 14:08:43 +0100
From: Gregor Jasny <gjasny@web.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce nr of ptr derefs in drivers/pci/hotplug/pciehp_core.c
References: <200512110641.42992.jesper.juhl@gmail.com>
In-Reply-To: <200512110641.42992.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl schrieb:
> --- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/pciehp_core.c	2005-12-04 18:48:04.000000000 +0100
> +++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/pciehp_core.c	2005-12-11 05:46:58.000000000 +0100
@@ -114,59 +117,66 @@ static int init_slots(struct controller
 	slot_number = ctrl->first_slot;

 	while (number_of_slots) {
-		new_slot = kmalloc(sizeof(*new_slot), GFP_KERNEL);
-		if (!new_slot)
+		slot = kmalloc(sizeof(*slot), GFP_KERNEL);
+		if (!slot)
 			goto error;

-		memset(new_slot, 0, sizeof(struct slot));
-		new_slot->hotplug_slot =
-			kmalloc(sizeof(*(new_slot->hotplug_slot)),
+		memset(slot, 0, sizeof(struct slot));
+		slot->hotplug_slot =
+				kmalloc(sizeof(*(slot->hotplug_slot)),

Just one suggestion:

In your patches I've seen a lot of kmalloc + memset calls. Perhaps you
can convert them to kzalloc? This would improve readability even more.

Thanks,
Gregor

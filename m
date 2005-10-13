Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVJMCL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVJMCL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJMCL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:11:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:38286 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932492AbVJMCL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:11:57 -0400
Date: Wed, 12 Oct 2005 19:10:43 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/8] input: register the input class device sooner
Message-ID: <20051013021043.GE31732@kroah.com>
References: <20051013014147.235668000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-register-class_device-sooner.patch"
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed so we can actually use the class device within the input
handlers.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/input.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/input/input.c
+++ gregkh-2.6/drivers/input/input.c
@@ -795,6 +795,9 @@ void input_register_device(struct input_
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node, &input_dev_list);
 
+	if (dev->dynalloc)
+		input_register_classdevice(dev);
+
 	list_for_each_entry(handler, &input_handler_list, node)
 		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
 			if ((id = input_match_device(handler->id_table, dev)))
@@ -802,9 +805,6 @@ void input_register_device(struct input_
 					input_link_handle(handle);
 
 
-	if (dev->dynalloc)
-		input_register_classdevice(dev);
-
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
 #endif

--

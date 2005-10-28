Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVJ1Gkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVJ1Gkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVJ1Gi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:38:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:36842 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965134AbVJ1GbU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:20 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: register the input class device sooner
In-Reply-To: <11304810262190@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <11304810263958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: register the input class device sooner

This is needed so we can actually use the class device within the input
handlers.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9c507854ead3fc14687b2402618b53ce4cea934a
tree fde0b34a166ecfe001929ef81d1c7d603d252d23
parent 3792257a4fef9c098e39d2268fd31faf52b69200
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/input.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 57fbfd9..03c2ca4 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
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


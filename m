Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVJ1GrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVJ1GrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVJ1Gqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:46:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:24810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965114AbVJ1GbH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:07 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: export input_dev_class so that input drivers can use it.
In-Reply-To: <11304810262929@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <11304810263348@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: export input_dev_class so that input drivers can use it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 67f440c4cac8a7073e113a0a7f201089123772a0
tree d7c2ac72d8a55945918ae8347ceb814cb7eacaa5
parent 9c507854ead3fc14687b2402618b53ce4cea934a
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/input.c |    3 ++-
 include/linux/input.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 03c2ca4..b0ede4c 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -40,6 +40,7 @@ EXPORT_SYMBOL(input_accept_process);
 EXPORT_SYMBOL(input_flush_device);
 EXPORT_SYMBOL(input_event);
 EXPORT_SYMBOL(input_class);
+EXPORT_SYMBOL_GPL(input_dev_class);
 
 #define INPUT_DEVICES	256
 
@@ -724,7 +725,7 @@ static void input_dev_release(struct cla
 	module_put(THIS_MODULE);
 }
 
-static struct class input_dev_class = {
+struct class input_dev_class = {
 	.name			= "input_dev",
 	.release		= input_dev_release,
 	.class_dev_attrs	= input_dev_attrs,
diff --git a/include/linux/input.h b/include/linux/input.h
index 3defa29..5de8441 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1075,6 +1075,7 @@ static inline void input_set_abs_params(
 }
 
 extern struct class *input_class;
+extern struct class input_dev_class;
 
 #endif
 #endif


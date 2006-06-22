Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWFVSeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWFVSeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWFVSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:34:35 -0400
Received: from mx1.suse.de ([195.135.220.2]:11402 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161173AbWFVSbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:31:10 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/14] [PATCH] w1: warning fix
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:18 -0700
Message-Id: <1151000885432-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008821893-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com> <11510008623474-git-send-email-greg@kroah.com> <11510008662311-git-send-email-greg@kroah.com> <11510008691087-git-send-email-greg@kroah.com> <1151000872615-git-send-email-greg@kroah.com> <1151000876534-git-send-email-greg@kroah.com> <11510008791727-git-send-email-greg@kroah.com> <11510008821893-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

drivers/w1/w1.c:423: warning: long long unsigned int format, __u64 arg (arg 8)

u64 is not, never has been and never will be "unsigned long long"!

While we're there, fix up some code layout - it looks awful in an 80-col
display.

Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/w1.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index b41366a..de3e979 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -391,7 +391,8 @@ static void w1_destroy_master_attributes
 }
 
 #ifdef CONFIG_HOTPLUG
-static int w1_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+static int w1_uevent(struct device *dev, char **envp, int num_envp,
+			char *buffer, int buffer_size)
 {
 	struct w1_master *md = NULL;
 	struct w1_slave *sl = NULL;
@@ -411,23 +412,28 @@ static int w1_uevent(struct device *dev,
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "Hotplug event for %s %s, bus_id=%s.\n", event_owner, name, dev->bus_id);
+	dev_dbg(dev, "Hotplug event for %s %s, bus_id=%s.\n",
+			event_owner, name, dev->bus_id);
 
 	if (dev->driver != &w1_slave_driver || !sl)
 		return 0;
 
-	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_FID=%02X", sl->reg_num.family);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size,
+			&cur_len, "W1_FID=%02X", sl->reg_num.family);
 	if (err)
 		return err;
 
-	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024LX", (u64)sl->reg_num.id);
+	err = add_uevent_var(envp, num_envp, &cur_index, buffer, buffer_size,
+			&cur_len, "W1_SLAVE_ID=%024LX",
+			(unsigned long long)sl->reg_num.id);
 	if (err)
 		return err;
 
 	return 0;
 };
 #else
-static int w1_uevent(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
+static int w1_uevent(struct device *dev, char **envp, int num_envp,
+			char *buffer, int buffer_size)
 {
 	return 0;
 }
@@ -451,7 +457,8 @@ static int __w1_attach_slave_device(stru
 		 (unsigned int) sl->reg_num.family,
 		 (unsigned long long) sl->reg_num.id);
 
-	dev_dbg(&sl->dev, "%s: registering %s as %p.\n", __func__, &sl->dev.bus_id[0]);
+	dev_dbg(&sl->dev, "%s: registering %s as %p.\n", __func__,
+		&sl->dev.bus_id[0]);
 
 	err = device_register(&sl->dev);
 	if (err < 0) {
-- 
1.4.0


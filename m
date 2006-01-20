Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWATTJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWATTJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWATTFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:26832 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751155AbWATTE7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:04:59 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: minor cleanup forward decls
In-Reply-To: <11377838791361@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:39 -0800
Message-Id: <1137783879871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: minor cleanup forward decls

Minor cleanup. Move structure initializer to bottom of file,
this allows elimination of eyeball-strain-inducing forward
declarations.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3138b8204e439aaa9ee4a6693ed1305ac36e356e
tree 23a367450c47de1dd95aebe43d71676a305be285
parent 170aa7441c7f262b09b85ab21948bd95f3d80887
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:32:58 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpaphp_core.c |   30 +++++++++++-------------------
 1 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index c0e521c..6e79f56 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -56,25 +56,6 @@ MODULE_LICENSE("GPL");
 
 module_param(debug, bool, 0644);
 
-static int enable_slot(struct hotplug_slot *slot);
-static int disable_slot(struct hotplug_slot *slot);
-static int set_attention_status(struct hotplug_slot *slot, u8 value);
-static int get_power_status(struct hotplug_slot *slot, u8 * value);
-static int get_attention_status(struct hotplug_slot *slot, u8 * value);
-static int get_adapter_status(struct hotplug_slot *slot, u8 * value);
-static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
-
-struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
-	.owner = THIS_MODULE,
-	.enable_slot = enable_slot,
-	.disable_slot = disable_slot,
-	.set_attention_status = set_attention_status,
-	.get_power_status = get_power_status,
-	.get_attention_status = get_attention_status,
-	.get_adapter_status = get_adapter_status,
-	.get_max_bus_speed = get_max_bus_speed,
-};
-
 static int rpaphp_get_attention_status(struct slot *slot)
 {
 	return slot->hotplug_slot->info->attention_status;
@@ -455,6 +436,17 @@ static int disable_slot(struct hotplug_s
 	return retval;
 }
 
+struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
+	.owner = THIS_MODULE,
+	.enable_slot = enable_slot,
+	.disable_slot = disable_slot,
+	.set_attention_status = set_attention_status,
+	.get_power_status = get_power_status,
+	.get_attention_status = get_attention_status,
+	.get_adapter_status = get_adapter_status,
+	.get_max_bus_speed = get_max_bus_speed,
+};
+
 module_init(rpaphp_init);
 module_exit(rpaphp_exit);
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbUBIX05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUBIX0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:26:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:3005 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265461AbUBIXWs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:48 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689422659@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:22 -0800
Message-Id: <1076368942698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.19, 2004/02/04 17:23:50-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: mark functions __init/__exit in acpiphp

These functions are only called from places marked __init or __exit, so
we can mark them also.


 drivers/pci/hotplug/acpiphp_core.c |    6 +++---
 drivers/pci/hotplug/acpiphp_glue.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
--- a/drivers/pci/hotplug/acpiphp_core.c	Mon Feb  9 14:58:29 2004
+++ b/drivers/pci/hotplug/acpiphp_core.c	Mon Feb  9 14:58:29 2004
@@ -374,7 +374,7 @@
 }
 
 
-static int init_acpi (void)
+static int __init init_acpi (void)
 {
 	int retval;
 
@@ -426,7 +426,7 @@
  * init_slots - initialize 'struct slot' structures for each slot
  *
  */
-static int init_slots (void)
+static int __init init_slots (void)
 {
 	struct slot *slot;
 	int retval = 0;
@@ -492,7 +492,7 @@
 }
 
 
-static void cleanup_slots (void)
+static void __exit cleanup_slots (void)
 {
 	struct list_head *tmp, *n;
 	struct slot *slot;
diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Mon Feb  9 14:58:29 2004
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Mon Feb  9 14:58:29 2004
@@ -1056,7 +1056,7 @@
  * acpiphp_glue_init - initializes all PCI hotplug - ACPI glue data structures
  *
  */
-int acpiphp_glue_init (void)
+int __init acpiphp_glue_init(void)
 {
 	int num;
 
@@ -1077,7 +1077,7 @@
  *
  * This function frees all data allocated in acpiphp_glue_init()
  */
-void acpiphp_glue_exit (void)
+void __exit acpiphp_glue_exit(void)
 {
 	struct list_head *l1, *l2, *n1, *n2;
 	struct acpiphp_bridge *bridge;
@@ -1124,7 +1124,7 @@
 /**
  * acpiphp_get_num_slots - count number of slots in a system
  */
-int acpiphp_get_num_slots (void)
+int __init acpiphp_get_num_slots(void)
 {
 	struct list_head *node;
 	struct acpiphp_bridge *bridge;


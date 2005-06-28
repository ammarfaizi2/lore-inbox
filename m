Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVF1Fxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVF1Fxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVF1Fti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:49:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:16876 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261734AbVF1Fdh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:37 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi hotplug: fix slot power-down problem with acpiphp
In-Reply-To: <11199367733442@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:54 -0700
Message-Id: <11199367743535@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi hotplug: fix slot power-down problem with acpiphp

Earlier I reported that Matthew's acpiphp rewrite had problem in powering down
slot on my i386 system.  The following patch is needed to get the acpiphp
rewrite properly powering down the slot.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2f523b15901f654a9448bbd47ebe1e783ec3195b
tree 74270f9c16021a5b4accbaadddb50475e3e44701
parent 364d5094a43ff2ceff3d19e40c4199771cb6cb8f
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:55 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:43 -0700

 drivers/pci/hotplug/acpiphp_glue.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -600,7 +600,7 @@ static int power_off_slot(struct acpiphp
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
-		if (func->pci_dev && (func->flags & FUNC_HAS_PS3)) {
+		if (func->flags & FUNC_HAS_PS3) {
 			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
 				warn("%s: _PS3 failed\n", __FUNCTION__);
@@ -615,7 +615,7 @@ static int power_off_slot(struct acpiphp
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		/* We don't want to call _EJ0 on non-existing functions. */
-		if (func->pci_dev && (func->flags & FUNC_HAS_EJ0)) {
+		if (func->flags & FUNC_HAS_EJ0) {
 			/* _EJ0 method take one argument */
 			arg_list.count = 1;
 			arg_list.pointer = &arg;


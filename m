Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFAFAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFAFAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFAE6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 00:58:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:10461 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261256AbVFAE6V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:58:21 -0400
Cc: kaneshige.kenji@jp.fujitsu.com
Subject: [PATCH] PCI Hotplug: shpchp driver doesn't program _HPP values properly
In-Reply-To: <11176025244113@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 31 May 2005 22:08:44 -0700
Message-Id: <11176025241488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: shpchp driver doesn't program _HPP values properly

Current shpchp driver doesn't seem to program _HPP values
properly. The following patch fixes this issue.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7a8cb869f31de525bc34095f51f8c8a43ffcb6a9
tree 952c03852730f328c2b500acb4748d2c4298d2b3
parent 2e3e80c2b75e3815a0160cbd23d4fdb767d66b35
author Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> Mon, 23 May 2005 19:50:32 +0900
committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:37 -0700

 drivers/pci/hotplug/shpchprm_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/shpchprm_acpi.c b/drivers/pci/hotplug/shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c
+++ b/drivers/pci/hotplug/shpchprm_acpi.c
@@ -1626,7 +1626,7 @@ int shpchprm_set_hpp(
 	pci_bus->number = func->bus;
 	devfn = PCI_DEVFN(func->device, func->function);
 
-	ab = find_acpi_bridge_by_bus(acpi_bridges_head, ctrl->seg, ctrl->bus);
+	ab = find_acpi_bridge_by_bus(acpi_bridges_head, ctrl->seg, ctrl->slot_bus);
 
 	if (ab) {
 		if (ab->_hpp) {


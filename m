Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFAE6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFAE6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 00:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFAE6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 00:58:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:9181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261208AbVFAE6U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:58:20 -0400
Cc: kaneshige.kenji@jp.fujitsu.com
Subject: [PATCH] PCI Hotplug: SHPCHP driver doesn't enable PERR and SERR properly
In-Reply-To: <20050601050802.GA26927@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 31 May 2005 22:08:44 -0700
Message-Id: <11176025244113@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: SHPCHP driver doesn't enable PERR and SERR properly

Current shpchp driver doesn't seem to program command register to
enable PERR and SERR properly. The following patch fixes this issue.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2ac2610b26c9da72820443328ff2c56c7b8c87b8
tree 9ca01e869d0c5a958232b7007e3fb48a27b0c5b3
parent 7a8cb869f31de525bc34095f51f8c8a43ffcb6a9
author Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> Fri, 27 May 2005 16:08:14 +0900
committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:37 -0700

 drivers/pci/hotplug/shpchprm_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/shpchprm_acpi.c b/drivers/pci/hotplug/shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c
+++ b/drivers/pci/hotplug/shpchprm_acpi.c
@@ -1681,7 +1681,7 @@ void shpchprm_enable_card(
 		| PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
 	bcmd = bcommand  = bcommand | PCI_BRIDGE_CTL_NO_ISA;
 
-	ab = find_acpi_bridge_by_bus(acpi_bridges_head, ctrl->seg, ctrl->bus);
+	ab = find_acpi_bridge_by_bus(acpi_bridges_head, ctrl->seg, ctrl->slot_bus);
 	if (ab) {
 		if (ab->_hpp) {
 			if (ab->_hpp->enable_perr) {


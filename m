Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWATTG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWATTG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWATTFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:35024 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751174AbWATTFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:04 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] PCI Hotplug/powerpc: module build break
In-Reply-To: <11377838782630@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:38 -0800
Message-Id: <11377838783611@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug/powerpc: module build break

The RPAPHP hoplug driver will not build as a module, because it calls
on pci_claim_resource(), which is not exported. This exports the symbol.
Problem reported by Olaf Hering <olh@suse.de>

A grep indicates that building drivers/parisc/lba_pci.c
would have trouble building as a module for the same reason.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ac71be89ce24827756ab7f725c01c3f83b9b3851
tree af94ca4835ef23ac81974b35ba0dc3edb3894648
parent 6404e7c38021e2e9bed564ee3ede2afe43611c3b
author linas <linas@austin.ibm.com> Tue, 10 Jan 2006 15:15:47 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 drivers/pci/setup-res.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 50d6685..ea9277b 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -112,6 +112,7 @@ pci_claim_resource(struct pci_dev *dev, 
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(pci_claim_resource);
 
 int pci_assign_resource(struct pci_dev *dev, int resno)
 {


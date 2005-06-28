Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVF1GKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVF1GKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVF1GK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:10:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:28140 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261878AbVF1Fdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:40 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Read bridge resources when fixing up the bus
In-Reply-To: <11199367734132@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:53 -0700
Message-Id: <11199367733440@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Read bridge resources when fixing up the bus

Read bridge io/mem/pfmem ranges when fixing up the bus so that bus resources
are tracked.  This is required to properly support pci end device and bridge
hotplug.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f7d473d919627262816459f8dba70d72812be074
tree 8dabcd1eea9369d117962d2d3646032745c596db
parent 542df5de56a23bf2d94b75e2b304ab0e5a5508a8
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:51 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:41 -0700

 arch/ia64/pci/pci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -418,6 +418,10 @@ pcibios_fixup_bus (struct pci_bus *b)
 {
 	struct pci_dev *dev;
 
+	if (b->self) {
+		pci_read_bridge_bases(b);
+		pcibios_fixup_device_resources(b->self);
+	}
 	list_for_each_entry(dev, &b->devices, bus_list)
 		pcibios_fixup_device_resources(dev);
 


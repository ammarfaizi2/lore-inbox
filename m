Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTFJTUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTFJSko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:40:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38813 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262827AbTFJShj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:39 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270971992@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709711559@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:31 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1392, 2003/06/10 10:53:28-07:00, greg@kroah.com

[PATCH] PCI: remove some pci_bus_b() calls in drivers/pci/power.c


 drivers/pci/power.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)


diff -Nru a/drivers/pci/power.c b/drivers/pci/power.c
--- a/drivers/pci/power.c	Tue Jun 10 11:14:55 2003
+++ b/drivers/pci/power.c	Tue Jun 10 11:14:55 2003
@@ -97,12 +97,10 @@
 
 static int pci_pm_save_state(u32 state)
 {
-	struct list_head *list;
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 	int error = 0;
 
-	list_for_each(list, &pci_root_buses) {
-		bus = pci_bus_b(list);
+	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		error = pci_pm_save_state_bus(bus,state);
 		if (!error)
 			error = pci_pm_save_state_device(bus->self,state);
@@ -112,11 +110,9 @@
 
 static int pci_pm_suspend(u32 state)
 {
-	struct list_head *list;
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 
-	list_for_each(list, &pci_root_buses) {
-		bus = pci_bus_b(list);
+	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		pci_pm_suspend_bus(bus,state);
 		pci_pm_suspend_device(bus->self,state);
 	}
@@ -125,11 +121,9 @@
 
 static int pci_pm_resume(void)
 {
-	struct list_head *list;
-	struct pci_bus *bus;
+	struct pci_bus *bus = NULL;
 
-	list_for_each(list, &pci_root_buses) {
-		bus = pci_bus_b(list);
+	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		pci_pm_resume_device(bus->self);
 		pci_pm_resume_bus(bus);
 	}


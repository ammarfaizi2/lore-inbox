Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTFJTUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTFJSkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:40:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36229 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264080AbTFJShh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:37 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709702206@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709703450@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1388, 2003/06/10 10:30:57-07:00, greg@kroah.com

[PATCH] PCI: remove pci_for_each_bus() usage from drivers/pci/pci.c


 drivers/pci/pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Tue Jun 10 11:15:38 2003
+++ b/drivers/pci/pci.c	Tue Jun 10 11:15:38 2003
@@ -55,11 +55,11 @@
 unsigned char __devinit
 pci_max_busnr(void)
 {
-	struct pci_bus* bus;
+	struct pci_bus *bus = NULL;
 	unsigned char max, n;
 
 	max = 0;
-	pci_for_each_bus(bus) {
+	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		n = pci_bus_max_busnr(bus);
 		if(n > max)
 			max = n;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTFEUtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTFEUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:47:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:3766 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265133AbTFEUrV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:47:21 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468772648@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <10548468774019@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1312, 2003/06/05 12:03:40-07:00, greg@kroah.com

[PATCH] PCI: remove direct access of pci_devices from drivers/macintosh/via-pmu68k.c

Yeah, this is commented out code, but just trying to be complete...


 drivers/macintosh/via-pmu68k.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)


diff -Nru a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
--- a/drivers/macintosh/via-pmu68k.c	Thu Jun  5 13:53:06 2003
+++ b/drivers/macintosh/via-pmu68k.c	Thu Jun  5 13:53:06 2003
@@ -839,11 +839,11 @@
 pbook_pci_save(void)
 {
 	int npci;
-	struct pci_dev *pd;
+	struct pci_dev *pd = NULL;
 	struct pci_save *ps;
 
 	npci = 0;
-	for (pd = pci_devices; pd != NULL; pd = pd->next)
+	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL)
 		++npci;
 	n_pbook_pci_saves = npci;
 	if (npci == 0)
@@ -853,7 +853,8 @@
 	if (ps == NULL)
 		return;
 
-	for (pd = pci_devices; pd != NULL && npci != 0; pd = pd->next) {
+	pd = NULL;
+	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
 		pci_read_config_word(pd, PCI_COMMAND, &ps->command);
 		pci_read_config_word(pd, PCI_CACHE_LINE_SIZE, &ps->cache_lat);
 		pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
@@ -867,10 +868,10 @@
 {
 	u16 cmd;
 	struct pci_save *ps = pbook_pci_saves;
-	struct pci_dev *pd;
+	struct pci_dev *pd = NULL;
 	int j;
 
-	for (pd = pci_devices; pd != NULL; pd = pd->next, ++ps) {
+	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
 		if (ps->command == 0)
 			continue;
 		pci_read_config_word(pd, PCI_COMMAND, &cmd);


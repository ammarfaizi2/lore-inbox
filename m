Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVAJRsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVAJRsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVAJRqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:46:52 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:22663 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262351AbVAJRVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:02 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776561347@kroah.com>
Date: Mon, 10 Jan 2005 09:20:56 -0800
Message-Id: <11053776562095@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.46, 2005/01/07 10:33:32-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: use PCI_DEVFN in ibmphp_pci.c

This patch changes ibmphp_pci.c to use the PCI_DEVFN makro where possible
instead of doing the match itself.

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_pci.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	2005-01-10 08:58:49 -08:00
+++ b/drivers/pci/hotplug/ibmphp_pci.c	2005-01-10 08:58:49 -08:00
@@ -414,7 +414,7 @@
 			memset (io[count], 0, sizeof (struct resource_node));
 			io[count]->type = IO;
 			io[count]->busno = func->busno;
-			io[count]->devfunc = ((func->device << 3) | (func->function & 0x7));
+			io[count]->devfunc = PCI_DEVFN(func->device, func->function);
 			io[count]->len = len[count];
 			if (ibmphp_check_resource(io[count], 0) == 0) {
 				ibmphp_add_resource (io[count]);
@@ -452,7 +452,8 @@
 				memset (pfmem[count], 0, sizeof (struct resource_node));
 				pfmem[count]->type = PFMEM;
 				pfmem[count]->busno = func->busno;
-				pfmem[count]->devfunc = ((func->device << 3) | (func->function & 0x7));
+				pfmem[count]->devfunc = PCI_DEVFN(func->device,
+							func->function);
 				pfmem[count]->len = len[count];
 				pfmem[count]->fromMem = FALSE;
 				if (ibmphp_check_resource (pfmem[count], 0) == 0) {
@@ -519,7 +520,8 @@
 				memset (mem[count], 0, sizeof (struct resource_node));
 				mem[count]->type = MEM;
 				mem[count]->busno = func->busno;
-				mem[count]->devfunc = ((func->device << 3) | (func->function & 0x7));
+				mem[count]->devfunc = PCI_DEVFN(func->device,
+							func->function);
 				mem[count]->len = len[count];
 				if (ibmphp_check_resource (mem[count], 0) == 0) {
 					ibmphp_add_resource (mem[count]);
@@ -685,7 +687,8 @@
 			memset (bus_io[count], 0, sizeof (struct resource_node));
 			bus_io[count]->type = IO;
 			bus_io[count]->busno = func->busno;
-			bus_io[count]->devfunc = ((func->device << 3) | (func->function & 0x7));
+			bus_io[count]->devfunc = PCI_DEVFN(func->device,
+							func->function);
 			bus_io[count]->len = len[count];
 			if (ibmphp_check_resource (bus_io[count], 0) == 0) {
 				ibmphp_add_resource (bus_io[count]);
@@ -717,7 +720,8 @@
 				memset (bus_pfmem[count], 0, sizeof (struct resource_node));
 				bus_pfmem[count]->type = PFMEM;
 				bus_pfmem[count]->busno = func->busno;
-				bus_pfmem[count]->devfunc = ((func->device << 3) | (func->function & 0x7));
+				bus_pfmem[count]->devfunc = PCI_DEVFN(func->device,
+							func->function);
 				bus_pfmem[count]->len = len[count];
 				bus_pfmem[count]->fromMem = FALSE;
 				if (ibmphp_check_resource (bus_pfmem[count], 0) == 0) {
@@ -775,7 +779,8 @@
 				memset (bus_mem[count], 0, sizeof (struct resource_node));
 				bus_mem[count]->type = MEM;
 				bus_mem[count]->busno = func->busno;
-				bus_mem[count]->devfunc = ((func->device << 3) | (func->function & 0x7));
+				bus_mem[count]->devfunc = PCI_DEVFN(func->device,
+							func->function);
 				bus_mem[count]->len = len[count];
 				if (ibmphp_check_resource (bus_mem[count], 0) == 0) {
 					ibmphp_add_resource (bus_mem[count]);
@@ -846,7 +851,7 @@
 		memset (io, 0, sizeof (struct resource_node));
 		io->type = IO;
 		io->busno = func->busno;
-		io->devfunc = ((func->device << 3) | (func->function & 0x7));
+		io->devfunc = PCI_DEVFN(func->device, func->function);
 		io->len = amount_needed->io;
 		if (ibmphp_check_resource (io, 1) == 0) {
 			debug ("were we able to add io\n");
@@ -869,7 +874,7 @@
 		memset (mem, 0, sizeof (struct resource_node));
 		mem->type = MEM;
 		mem->busno = func->busno;
-		mem->devfunc = ((func->device << 3) | (func->function & 0x7));
+		mem->devfunc = PCI_DEVFN(func->device, func->function);
 		mem->len = amount_needed->mem;
 		if (ibmphp_check_resource (mem, 1) == 0) {
 			ibmphp_add_resource (mem);
@@ -892,7 +897,7 @@
 		memset (pfmem, 0, sizeof (struct resource_node));
 		pfmem->type = PFMEM;
 		pfmem->busno = func->busno;
-		pfmem->devfunc = ((func->device << 3) | (func->function & 0x7));
+		pfmem->devfunc = PCI_DEVFN(func->device, func->function);
 		pfmem->len = amount_needed->pfmem;
 		pfmem->fromMem = FALSE;
 		if (ibmphp_check_resource (pfmem, 1) == 0) {


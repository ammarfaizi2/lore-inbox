Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTLSWbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 17:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTLSWbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 17:31:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19957 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263661AbTLSWb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 17:31:28 -0500
Date: Fri, 19 Dec 2003 23:31:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net
Subject: [2.4 patch] fix two pcmcia/cardbus.c compile warnings
Message-ID: <20031219223118.GX12750@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile warnings in 2.4.24-pre1:

<--  snip  -->

...
gcc -D__KERNEL__ -I/tmp/linux-2.4.24-pre1/include -Wall 
-Wstrict-prototypes -Wn\
o-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mp\
referred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include 
-DKBUILD\
_BASENAME=cardbus  -c -o cardbus.o cardbus.c
cardbus.c: In function `cb_scan_slot':
...
cardbus.c:226: warning: unused variable `bus'
cardbus.c: In function `program_bridge':
cardbus.c:405: warning: control reaches end of non-void function
...

<--  snip  -->

The patch below does the following:
- remove the unused variable
- make the function without return void (the only caller doesn't check
  the return value)


Please apply
Adrian


--- linux-2.4.24-pre1/drivers/pcmcia/cardbus.c.old	2003-12-19 21:35:52.000000000 +0100
+++ linux-2.4.24-pre1/drivers/pcmcia/cardbus.c	2003-12-19 21:36:49.000000000 +0100
@@ -223,7 +223,6 @@
 
 struct pci_dev *cb_scan_slot(struct pci_dev *temp, struct list_head *list)
 {
-	struct pci_bus *bus = temp->bus;
 	struct pci_dev *dev;
 	struct pci_dev *first_dev = NULL;
 	int func = 0;
@@ -369,7 +368,7 @@
 	return max;
 }
 
-static int program_bridge(struct pci_dev *bridge)
+static void program_bridge(struct pci_dev *bridge)
 {
 	u32 l;
 	


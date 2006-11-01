Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946538AbWKAFtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946538AbWKAFtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946548AbWKAFqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:46:05 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:477 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946523AbWKAFpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:45:49 -0500
Message-Id: <20061101054550.187618000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:37 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Alan Cox <alan@redhat.com>
Subject: [PATCH 57/61] JMB 368 PATA detection
Content-Disposition: inline; filename=jmb-368-pata-detection.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

The Jmicron JMB368 is PATA only so has the PATA on function zero.  Don't
therefore skip function zero on this device when probing

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/ide/pci/generic.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.18.1.orig/drivers/ide/pci/generic.c
+++ linux-2.6.18.1/drivers/ide/pci/generic.c
@@ -242,8 +242,10 @@ static int __devinit generic_init_one(st
 	    (!(PCI_FUNC(dev->devfn) & 1)))
 		goto out;
 
-	if (dev->vendor == PCI_VENDOR_ID_JMICRON && PCI_FUNC(dev->devfn) != 1)
-		goto out;
+	if (dev->vendor == PCI_VENDOR_ID_JMICRON) {
+		if (dev->device != PCI_DEVICE_ID_JMICRON_JMB368 && PCI_FUNC(dev->devfn) != 1)
+			goto out;
+	}
 
 	if (dev->vendor != PCI_VENDOR_ID_JMICRON) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);

--

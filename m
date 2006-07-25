Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWGYQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWGYQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWGYQ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:57:04 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:23259 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932480AbWGYQ47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:56:59 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 7] [x86-64] Calgary IOMMU: break out of
	pci_find_device_reverse if dev not found
X-Mercurial-Node: 4b8fbf25700873a70eff09264e52e9f6c6330c18
Message-Id: <4b8fbf25700873a70eff.1153846593@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:33 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 2 insertions(+)
arch/x86_64/kernel/pci-calgary.c |    2 ++


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153737003 -10800
# Node ID 4b8fbf25700873a70eff09264e52e9f6c6330c18
# Parent  f85ffa73fb99f4796043a8e50bef1180e36fe582
[x86-64] Calgary IOMMU: break out of pci_find_device_reverse if dev not found

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r f85ffa73fb99 -r 4b8fbf257008 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:01:16 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:30:03 2006 +0300
@@ -844,6 +844,8 @@ error:
 		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
 					      PCI_DEVICE_ID_IBM_CALGARY,
 					      dev);
+		if (!dev)
+			break;
 		if (!translate_phb(dev)) {
 			pci_dev_put(dev);
 			continue;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUJ1J4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUJ1J4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUJ1Jx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:53:27 -0400
Received: from fmr06.intel.com ([134.134.136.7]:64979 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262868AbUJ1JwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:52:04 -0400
Date: Thu, 28 Oct 2004 17:34:19 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix e100 suspend/resume w/ 2.6.10-rc1 and above (due to
 pci_save_state change)
Message-ID: <Pine.LNX.4.44.0410281706070.26113-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Recent 2.6.10-rc1 merged the pci_save_state change. This prevents some
drivers from working with suspend/resume. The reason is the
pci_save_state() called in driver's ->suspend doesn't take effect any more,
since pci bus ->suspend will override it. And the two states might be
different in some drivers, i.e. e100. I don't know if there are other
drivers also suffer from it.

Thanks,
-yi


Signed-off-by: Zhu Yi <yi.zhu@intel.com>

--- /tmp/e100.c	2004-10-28 16:31:41.000000000 +0800
+++ drivers/net/e100.c	2004-10-28 16:33:14.000000000 +0800
@@ -2309,9 +2309,7 @@ static int e100_suspend(struct pci_dev *
 
-	pci_save_state(pdev);
 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
-	pci_disable_device(pdev);
 	pci_set_power_state(pdev, state);
 
 	return 0;


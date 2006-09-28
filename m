Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWI1Ggz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWI1Ggz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWI1Ggz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:36:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:44870 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1161039AbWI1Ggz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:36:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,228,1157353200"; 
   d="scan'208"; a="137501789:sNHT34135010"
Subject: Re: pcie_portdrv_restore_config undefined without CONFIG_PM
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Yanmin Zhang <yanmin.zhang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060927194235.GA9894@aepfle.de>
References: <20060927194235.GA9894@aepfle.de>
Content-Type: text/plain
Message-Id: <1159425359.20092.615.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 28 Sep 2006 14:35:59 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 03:42, Olaf Hering wrote:
> PCI-Express AER implemetation: pcie_portdrv error handler
> 
> This patch breaks if CONFIG_PM is not enabled,
> pcie_portdrv_restore_config() will be undefined.
I move the definition of pcie_portdrv_restore_config
out of CONFIG_PM.

Below patch is against 2.6.18-mm1. Could you try it?

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.18_mm1/drivers/pci/pcie/portdrv_pci.c linux-2.6.18_mm1_fix/drivers/pci/pcie/portdrv_pci.c
--- linux-2.6.18_mm1/drivers/pci/pcie/portdrv_pci.c	2006-09-29 07:19:48.000000000 -0600
+++ linux-2.6.18_mm1_fix/drivers/pci/pcie/portdrv_pci.c	2006-09-29 07:21:08.000000000 -0600
@@ -37,7 +37,6 @@ static int pcie_portdrv_save_config(stru
 	return pci_save_state(dev);
 }
 
-#ifdef CONFIG_PM
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
@@ -50,6 +49,7 @@ static int pcie_portdrv_restore_config(s
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int pcie_portdrv_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	int ret = pcie_port_device_suspend(dev, state);

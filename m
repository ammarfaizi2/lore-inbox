Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTIDNLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTIDNLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:11:45 -0400
Received: from mta06bw.bigpond.com ([144.135.24.156]:22516 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP id S264968AbTIDNLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:11:42 -0400
Date: Thu, 04 Sep 2003 23:10:18 +1000
From: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: [PROBLEM] [PATCH] Compilation issue with 2.4.22aa1
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <200309042310.18612.harisri@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

While executing "make modules_install" on 2.4.22aa1, I get this error message:
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22aa1/kernel/drivers/scsi/scsi_mod.o
depmod:         open_softirq

(No error messages while make dep clean bzImage modules AFAIK)

I can provide my complete .config on request. Here is the key .config section:
CONFIG_SCSI=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_PL2303=m

Eventhough I do not know if this is the right way to fix, this patch seems to 
fix it (make modules_install works fine, although I have not boot tested 
it.):
--- ksyms.c.orig	2003-09-04 21:28:06.000000000 +1000
+++ ksyms.c	2003-09-04 22:44:38.000000000 +1000
@@ -630,6 +630,7 @@
 EXPORT_SYMBOL(cpu_raise_softirq);
 EXPORT_SYMBOL(__tasklet_schedule);
 EXPORT_SYMBOL(__tasklet_hi_schedule);
+EXPORT_SYMBOL(open_softirq);
 
 /* init task, for moving kthread roots - ought to export a function ?? */
 

Thanks
-- 
Hari
harisri@bigpond.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUJ3Wsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUJ3Wsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUJ3Wsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:48:35 -0400
Received: from baikonur.stro.at ([213.239.196.228]:24513 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261394AbUJ3Wrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:47:31 -0400
Subject: [patch 8/8]  serial/icom: remove custom 	msleep()
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:47:22 +0200
Message-ID: <E1CO20I-0003Gv-Rq@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Remove custom msleep() to guarantee
the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc1-max/drivers/serial/icom.c |    6 ------
 1 files changed, 6 deletions(-)

diff -puN drivers/serial/icom.c~remove-custom-msleep-drivers_serial_icom drivers/serial/icom.c
--- linux-2.6.10-rc1/drivers/serial/icom.c~remove-custom-msleep-drivers_serial_icom	2004-10-24 17:05:49.000000000 +0200
+++ linux-2.6.10-rc1-max/drivers/serial/icom.c	2004-10-24 17:05:49.000000000 +0200
@@ -140,12 +140,6 @@ static inline void trace(struct icom_por
 static inline void trace(struct icom_port *icom_port, char *trace_pt, unsigned long trace_data) {};
 #endif
 
-static void msleep(unsigned long msecs)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(msecs));
-}
-
 static void free_port_memory(struct icom_port *icom_port)
 {
 	struct pci_dev *dev = icom_port->adapter->pci_dev;
_

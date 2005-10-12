Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVJLWIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVJLWIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVJLWIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 18:08:38 -0400
Received: from h156-az.mvista.com ([65.200.49.156]:40880 "EHLO
	windy.az.mvista.com") by vger.kernel.org with ESMTP id S932382AbVJLWIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 18:08:38 -0400
Date: Wed, 12 Oct 2005 15:10:06 -0700
From: Carlos Sanchez <csanchez@windy.az.mvista.com>
Message-Id: <200510122210.j9CMA6li018530@windy.az.mvista.com>
To: akpm@osdl.org, csanchez@mvista.com, mgreer@mvista.com
Subject: Added a Receive_Abort to the Marvell serial driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Added a Receive_Abort to the Marvell serial driver

Fix occasional input overrun errors on Marvell serial driver
- If the Marvell serial driver is repeatedly  started and then stopped
it will occasionally report an input overrun error when started.
- Added a Receive_Abort to the Marvell serial driver to abort
previously received receive errors when re-starting the receive

Acked-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Carlos Sanchez <csanchez@mvista.com>
--
diff -Naur --exclude=.pc --exclude=patches Pristinelinux-2.6.10/drivers/serial/mpsc.c WorkingF101_USB/drivers/serial/mpsc.c
--- Pristinelinux-2.6.10/drivers/serial/mpsc.c	2005-10-07 09:58:56.000000000 -0700
+++ WorkingF101_USB/drivers/serial/mpsc.c	2005-10-12 07:56:13.279523424 -0700
@@ -1100,6 +1105,8 @@
 {
 	pr_debug("mpsc_start_rx[%d]: Starting...\n", pi->port.line);
 
+	/* Issue a Receive Abort to clear any receive errors */
+	writel(MPSC_CHR_2_RA, pi->mpsc_base + MPSC_CHR_2);
 	if (pi->rcv_data) {
 		mpsc_enter_hunt(pi);
 		mpsc_sdma_cmd(pi, SDMA_SDCM_ERD);

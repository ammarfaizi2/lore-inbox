Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVCNTdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVCNTdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVCNTdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:33:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20104 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261755AbVCNTdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:33:35 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, pfg@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gcc4 fix for sn_serial.c
Date: Mon, 14 Mar 2005 11:32:39 -0800
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XbeNCnKCwUumPYm"
Message-Id: <200503141132.39284.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_XbeNCnKCwUumPYm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The sal_console and sal_console_uart structures have a circular relationship 
since they both initialize member fields to pointers of one another.  The 
current code forward declares sal_console_uart as extern so that sal_console 
can take its address, but gcc4 complains about this since the real definition 
of sal_console_uart is marked 'static'.  This patch just removes the static 
qualifier from sal_console_uart to avoid the inconsistency.  Does it look ok 
to you, Pat?

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_XbeNCnKCwUumPYm
Content-Type: text/plain;
  charset="us-ascii";
  name="sn-serial-gcc4-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sn-serial-gcc4-fix.patch"

===== drivers/serial/sn_console.c 1.12 vs edited =====
--- 1.12/drivers/serial/sn_console.c	2005-03-07 20:41:31 -08:00
+++ edited/drivers/serial/sn_console.c	2005-03-14 10:57:19 -08:00
@@ -801,7 +801,7 @@
 
 #define SAL_CONSOLE	&sal_console
 
-static struct uart_driver sal_console_uart = {
+struct uart_driver sal_console_uart = {
 	.owner = THIS_MODULE,
 	.driver_name = "sn_console",
 	.dev_name = DEVICE_NAME,

--Boundary-00=_XbeNCnKCwUumPYm--

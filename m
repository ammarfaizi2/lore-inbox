Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVBDKTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVBDKTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVBDKTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:19:04 -0500
Received: from ozlabs.org ([203.10.76.45]:13195 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261205AbVBDKSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:18:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.19273.299040.73067@cargo.ozlabs.ibm.com>
Date: Fri, 4 Feb 2005 21:15:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: jimix@watson.ibm.com, anton@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix devfs name for the hvcs driver
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Jimi Xenidis <jimix@watson.ibm.com>.

The hvcs driver does not register a devfs_name resulting in devfs
creating /dev/<NULL>* entries.
The following one line patch remedies the problem.

Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- orig/drivers/char/hvcs.c
+++ mod/drivers/char/hvcs.c
@@ -1363,6 +1363,7 @@
 
 	hvcs_tty_driver->driver_name = hvcs_driver_name;
 	hvcs_tty_driver->name = hvcs_device_node;
+	hvcs_tty_driver->devfs_name = hvcs_device_node;
 
 	/*
 	 * We'll let the system assign us a major number, indicated by leaving

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTFEPsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 11:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbTFEPsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 11:48:23 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:61958 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264722AbTFEPsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 11:48:19 -0400
Date: Fri, 6 Jun 2003 02:01:22 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: pam.delaney@lsil.com
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] compile fix for MPT Fusion driver for 2.5.70 bk
Message-ID: <Mutt.LNX.4.44.0306060154230.2735-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes compilation for the MPT Fusion driver, which broke 
with recent changes to the PCI API.

It seems that the code is trying to detect which version of the API its 
being compiled for, but the macro it was looking for has disappeared.


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff bk.pending/drivers/message/fusion/linux_compat.h bk.w1/drivers/message/fusion/linux_compat.h
--- bk.pending/drivers/message/fusion/linux_compat.h	2003-06-06 00:36:11.000000000 +1000
+++ bk.w1/drivers/message/fusion/linux_compat.h	2003-06-06 01:48:49.000000000 +1000
@@ -147,7 +147,7 @@
 
 
 /* PCI/driver subsystem { */
-#ifndef pci_for_each_dev
+#ifndef pci_for_each_dev_reverse
 #define pci_for_each_dev(dev)		for((dev)=pci_devices; (dev)!=NULL; (dev)=(dev)->next)
 #define pci_peek_next_dev(dev)		((dev)->next ? (dev)->next : NULL)
 #define DEVICE_COUNT_RESOURCE           6


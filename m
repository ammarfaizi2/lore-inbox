Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTLRR3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 12:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbTLRR3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 12:29:39 -0500
Received: from ida.rowland.org ([192.131.102.52]:5124 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265248AbTLRR3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 12:29:35 -0500
Date: Thu, 18 Dec 2003 12:29:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Error notification in device release
Message-ID: <Pine.LNX.4.44L0.0312181227420.1011-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

Now that the driver model includes completions for release notification as 
well as release methods, the conditions for printing the warning message 
in device_release can be relaxed a little...

Alan Stern


===== core.c 1.70 vs edited =====
--- 1.70/drivers/base/core.c	Fri Oct 10 16:44:38 2003
+++ edited/drivers/base/core.c	Thu Dec 18 12:19:25 2003
@@ -80,7 +80,7 @@
 
 	if (dev->release)
 		dev->release(dev);
-	else {
+	else if (!c) {
 		printk(KERN_ERR "Device '%s' does not have a release() function, "
 			"it is broken and must be fixed.\n",
 			dev->bus_id);


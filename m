Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVAWLNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVAWLNK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 06:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAWLNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 06:13:09 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:46832 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261295AbVAWLNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 06:13:05 -0500
Date: Sun, 23 Jan 2005 03:12:58 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Enforce USB interface claims
Message-ID: <20050123111258.GA29513@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

How would you feel about something like this?

Index: cw-current/drivers/usb/core/devio.c
===================================================================
--- cw-current.orig/drivers/usb/core/devio.c	2005-01-19 14:52:27.987890276 -0800
+++ cw-current/drivers/usb/core/devio.c	2005-01-22 18:09:22.753895659 -0800
@@ -417,10 +417,7 @@
 		return -EINVAL;
 	if (test_bit(ifnum, &ps->ifclaimed))
 		return 0;
-	/* if not yet claimed, claim it for the driver */
-	dev_warn(&ps->dev->dev, "usbfs: process %d (%s) did not claim interface %u before use\n",
-	       current->pid, current->comm, ifnum);
-	return claimintf(ps, ifnum);
+	return -EINVAL;
 }
 
 static int findintfep(struct usb_device *dev, unsigned int ep)

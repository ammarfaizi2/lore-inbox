Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTKCWRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 17:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTKCWRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 17:17:31 -0500
Received: from ginger.lcs.mit.edu ([18.26.0.82]:42002 "EHLO ginger.lcs.mit.edu")
	by vger.kernel.org with ESMTP id S263459AbTKCWR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 17:17:29 -0500
Message-Id: <200311032217.hA3MHPWB012429@ginger.lcs.mit.edu>
From: Tim Shepard <shep@alum.mit.edu>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: (2.6.0-test9) usb_storage/uhci_hcd much slower write than linux-2.4 
In-reply-to: Your message of Sat, 01 Nov 2003 23:03:33 -0500.
Date: Mon, 03 Nov 2003 17:17:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Someone sent me a private e-mail message suggesting that I apply this
patch that Matthew Dharm posted to the linux-usb-devel list yesterday
and see if that would restore the write throughput to linux-2.4
levels.

The patch limits the size of the transfers, and can be found at 

	http://sourceforge.net/mailarchive/message.php?msg_id=6429200

or right here:

--- drivers/usb/storage/scsiglue.c.orig	2003-08-09 00:36:46.000000000 -0400
+++ drivers/usb/storage/scsiglue.c	2003-11-03 16:49:42.000000000 -0500
@@ -315,6 +315,9 @@
 	/* lots of sg segments can be handled */
 	.sg_tablesize =			SG_ALL,
 
+	/* limit the total size of a transfer to 120 KB */
+	.max_sectors =			240,
+
 	/* merge commands... this seems to help performance, but
 	 * periodically someone should test to see which setting is more
 	 * optimal.


I am happy to report that this patch has restored the write throughput
to the same speed that it was on linux-2.4.

Problem solved.    Thanks much.

			-Tim Shepard

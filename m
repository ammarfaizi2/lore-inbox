Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbTDUHyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 03:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTDUHyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 03:54:02 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:50901 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP id S263783AbTDUHyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 03:54:01 -0400
Message-ID: <3EA3A6D4.3050104@csse.uwa.edu.au>
Date: Mon, 21 Apr 2003 16:07:48 +0800
From: David Glance <david@csse.uwa.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: PATCH: usb-ohci: interrupt out with urb->interval  0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corrected patch for 2.4.21-pre7

--- usb-ohci.c  2003-04-21 15:53:19.000000000 +0800
+++ usb-ohci.patch.c    2003-04-21 16:03:51.000000000 +0800
@@ -490,6 +490,13 @@
                                usb_pipeout (urb->pipe)
                                        ? PCI_DMA_TODEVICE
                                        : PCI_DMA_FROMDEVICE);
+
+                        if (urb->interval == 0) {
+                               urb_rm_priv (urb);
+                               urb->complete (urb);
+                               break;
+                        }
+
                        urb->complete (urb);
 
                        /* implicitly requeued */



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933046AbWKMT6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWKMT6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933050AbWKMT6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:58:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:21467 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S933046AbWKMT6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:58:17 -0500
Date: Mon, 13 Nov 2006 14:58:15 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: arvidjaar@mail.ru
cc: David Brownell <david-b@pacbell.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI
 wakeup via sysfs
In-Reply-To: <200611130839.11459.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0611131457050.2390-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey:

Try this patch for 2.6.19-rc5.  Although it doesn't make all the changes 
Dave and I have discussed, it ought to fix your problem.

Alan Stern


Index: 2.6.19-rc5/drivers/usb/host/ohci-hub.c
===================================================================
--- 2.6.19-rc5.orig/drivers/usb/host/ohci-hub.c
+++ 2.6.19-rc5/drivers/usb/host/ohci-hub.c
@@ -422,7 +422,8 @@ ohci_hub_status_data (struct usb_hcd *hc
 				ohci->autostop = 0;
 				ohci->next_statechange = jiffies +
 						STATECHANGE_DELAY;
-			} else if (time_after_eq (jiffies,
+			} else if (device_may_wakeup(&hcd->self.root_hub->dev)
+					&& time_after_eq(jiffies,
 						ohci->next_statechange)
 					&& !ohci->ed_rm_list
 					&& !(ohci->hc_control &


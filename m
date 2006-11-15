Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030708AbWKOQ7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030708AbWKOQ7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030709AbWKOQ7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:59:33 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48536 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030708AbWKOQ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:59:32 -0500
Date: Wed, 15 Nov 2006 11:59:28 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] OHCI: disallow autostop when wakeup is disabled
In-Reply-To: <20061114203313.6b3de60f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0611151157260.3219-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as822) prevents the OHCI autostop mechanism from starting
up if the root hub is not able or not allowed to issue wakeup requests.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Tue, 14 Nov 2006, Andrew Morton wrote:

> > Then this should get merged into 2.6.19-rc ASAP ...
> 
> please send final version?

Here it is.  A copy has already been sent to Greg KH.

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


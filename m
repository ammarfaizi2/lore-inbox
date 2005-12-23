Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVLWBFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVLWBFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVLWBFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:05:20 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:3467 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964786AbVLWBFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:05:20 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.15-rc5-mm3
Date: Thu, 22 Dec 2005 17:05:18 -0800
User-Agent: KMail/1.7.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, gcoady@gmail.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051214234016.0112a86e.akpm@osdl.org> <200512181231.55981.rjw@sisk.pl> <20051222174850.GK23837@kroah.com>
In-Reply-To: <20051222174850.GK23837@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O10qDJq/zOZVmPg"
Message-Id: <200512221705.18618.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_O10qDJq/zOZVmPg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> David, care to put a proper header on this and send it to me so I can
> add it to my tree?

Here you go!


--Boundary-00=_O10qDJq/zOZVmPg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ehci-pcd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ehci-pcd.patch"

On some systems, EHCI seems to be getting IRQs too early during driver
setup ... before the root hub is allocated, in particular, making trouble
for any code chasing down root hub pointers!  In this case, it seems to
be safe to just ignore the root hub setting.  Thanks to Rafael J. Wysocki
for getting this properly tested.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/usb/host/ehci-hcd.c	2005-12-22 16:48:57.000000000 -0800
+++ g26/drivers/usb/host/ehci-hcd.c	2005-12-22 16:57:52.000000000 -0800
@@ -617,7 +617,7 @@ static irqreturn_t ehci_irq (struct usb_
 	}
 
 	/* remote wakeup [4.3.1] */
-	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {
+	if (status & STS_PCD) {
 		unsigned	i = HCS_N_PORTS (ehci->hcs_params);
 
 		/* resume root hub? */

--Boundary-00=_O10qDJq/zOZVmPg--

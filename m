Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUIJJ5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUIJJ5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUIJJxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:53:07 -0400
Received: from p5089E239.dip.t-dialin.net ([80.137.226.57]:4868 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S267354AbUIJJug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:50:36 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Re: 2.6.9-rc1-mm4, sub-serial.c, Badness in usb_unlink_urb
Date: Fri, 10 Sep 2004 11:50:34 +0200
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>
References: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409101150.34249.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the deprecated call to usb_unlink_urb in usb-serial.c

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- linux-2.6.9-rc1-mm/drivers/usb/serial/usb-serial.c.orig 2004-09-10 
11:41:16.000000000 +0200
+++ linux-2.6.9-rc1-mm/drivers/usb/serial/usb-serial.c 2004-09-10 
11:41:44.000000000 +0200
@@ -819,15 +819,15 @@ static void port_release(struct device *
 
  dbg ("%s - %s", __FUNCTION__, dev->bus_id);
  if (port->read_urb) {
-  usb_unlink_urb(port->read_urb);
+  usb_kill_urb(port->read_urb);
   usb_free_urb(port->read_urb);
  }
  if (port->write_urb) {
-  usb_unlink_urb(port->write_urb);
+  usb_kill_urb(port->write_urb);
   usb_free_urb(port->write_urb);
  }
  if (port->interrupt_in_urb) {
-  usb_unlink_urb(port->interrupt_in_urb);
+  usb_kill_urb(port->interrupt_in_urb);
   usb_free_urb(port->interrupt_in_urb);
  }
  kfree(port->bulk_in_buffer);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUIJJwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUIJJwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUIJJuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:50:25 -0400
Received: from p5089E239.dip.t-dialin.net ([80.137.226.57]:3332 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S267356AbUIJJsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:48:41 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Re: 2.6.9-rc1-mm4, visor.c, Badness in usb_unlink_urb
Date: Fri, 10 Sep 2004 11:48:37 +0200
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>
References: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409101148.37587.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove the deprecated call to usb_unlink_urb.

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- linux-2.6.9-rc1-mm/drivers/usb/serial/visor.c.orig 2004-09-10 
11:35:11.000000000 +0200
+++ linux-2.6.9-rc1-mm/drivers/usb/serial/visor.c 2004-09-10 
11:35:55.000000000 +0200
@@ -446,9 +446,9 @@ static void visor_close (struct usb_seri
  dbg("%s - port %d", __FUNCTION__, port->number);
     
  /* shutdown our urbs */
- usb_unlink_urb (port->read_urb);
+ usb_kill_urb (port->read_urb);
  if (port->interrupt_in_urb)
-  usb_unlink_urb (port->interrupt_in_urb);
+  usb_kill_urb (port->interrupt_in_urb);
 
  /* Try to send shutdown message, if the device is gone, this will just fail. 
*/
  transfer_buffer =  kmalloc (0x12, GFP_KERNEL);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVCBU6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVCBU6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVCBU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:58:23 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:55720 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262496AbVCBU6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:58:16 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.11: usbnet broken
Date: Wed, 2 Mar 2005 12:58:10 -0800
User-Agent: KMail/1.7.1
Cc: Holger Klawitter <listen@klawitter.de>, linux-kernel@vger.kernel.org
References: <200503021807.11717.listen@klawitter.de>
In-Reply-To: <200503021807.11717.listen@klawitter.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ijiJCwF8WbtjmPZ"
Message-Id: <200503021258.10638.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ijiJCwF8WbtjmPZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 02 March 2005 9:07 am, Holger Klawitter wrote:
> Hi there,
> 
> in 2.6.11 the usbnet module is not being loaded for my Zaurus SL-C860 (Vendor 
> ID = 044d, Product ID = 9031), which used to work in 2.6.10. (as stated in 
> previous post, rc4 and rc5 were also broken).

Hmm, I don't think that post made it near linux-usb-devel ... :)

If the problem is just that the driver isn't loaded, but works if it's
modprobed by hand (or statically linked), then it's a hotplug problem.
Likely the same one that prevents _real_ CDC Ethernet devices from
hotplugging.  See if the attached patch improves things.

Alternatively, I understand that the 2.6 based OpenZaurus code is
starting to work quite well on those models.  You could upgrade
from that old Lineo/Embedix code, and gain the ability to talk to
Windows using RNDIS networking for free!


> Moreover, there seems to be a wrong Product ID in usbnet (already in 2.6.9): 
> is=9050 should be=9031. Hence my Zarus is being recognized as C-750/760 
> (which is fine as 760 and 860 only differ in memsize).

Are you saying Linux is saying something about "750/760"?  Where?
Current usbnet versions only say "Sharp Zaurus, PXA-2xx based".
Maybe the Lineo/Embedix code is mis-identifying itself.

- Dave


--Boundary-00=_ijiJCwF8WbtjmPZ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Diff"

--- 1.184/drivers/usb/core/usb.c	2005-01-20 14:33:35 -08:00
+++ edited/drivers/usb/core/usb.c	2005-03-02 12:47:31 -08:00
@@ -601,7 +601,7 @@
 				usb_dev->descriptor.bDeviceProtocol))
 		return -ENOMEM;
 
-	if (usb_dev->descriptor.bDeviceClass == 0) {
+	if (1) {
 		struct usb_host_interface *alt = intf->cur_altsetting;
 
 		/* 2.4 only exposed interface zero.  in 2.5, hotplug

--Boundary-00=_ijiJCwF8WbtjmPZ--

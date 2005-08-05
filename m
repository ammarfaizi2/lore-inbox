Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVHEPDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVHEPDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVHEOxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:48 -0400
Received: from fep17.inet.fi ([194.251.242.242]:36590 "EHLO fep17.inet.fi")
	by vger.kernel.org with ESMTP id S262501AbVHEOvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:51:21 -0400
Subject: [PATCH 4/8] USB: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7je.odev85.el9izpk1g38nfy240a6ur3v2s.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7j4.hxsbqg.dfp7ughpn3jgy3088i6y0e84l.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:51:20 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 atm/usbatm.c       |    2 +-
 core/hcd.c         |    2 +-
 host/ehci-sched.c  |    2 +-
 host/isp116x-hcd.c |    2 +-
 host/sl811-hcd.c   |    2 +-
 input/acecad.c     |    2 +-
 input/itmtouch.c   |    2 +-
 input/pid.c        |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

Index: 2.6/drivers/usb/atm/usbatm.c
===================================================================
--- 2.6.orig/drivers/usb/atm/usbatm.c
+++ 2.6/drivers/usb/atm/usbatm.c
@@ -960,7 +960,7 @@ int usbatm_usb_probe(struct usb_interfac
 			intf->altsetting->desc.bInterfaceNumber);
 
 	/* instance init */
-	instance = kcalloc(1, sizeof(*instance) + sizeof(struct urb *) * (num_rcv_urbs + num_snd_urbs), GFP_KERNEL);
+	instance = kzalloc(sizeof(*instance) + sizeof(struct urb *) * (num_rcv_urbs + num_snd_urbs), GFP_KERNEL);
 	if (!instance) {
 		dev_dbg(dev, "%s: no memory for instance data!\n", __func__);
 		return -ENOMEM;
Index: 2.6/drivers/usb/core/hcd.c
===================================================================
--- 2.6.orig/drivers/usb/core/hcd.c
+++ 2.6/drivers/usb/core/hcd.c
@@ -1669,7 +1669,7 @@ struct usb_hcd *usb_create_hcd (const st
 {
 	struct usb_hcd *hcd;
 
-	hcd = kcalloc(1, sizeof(*hcd) + driver->hcd_priv_size, GFP_KERNEL);
+	hcd = kzalloc(sizeof(*hcd) + driver->hcd_priv_size, GFP_KERNEL);
 	if (!hcd) {
 		dev_dbg (dev, "hcd alloc failed\n");
 		return NULL;
Index: 2.6/drivers/usb/host/ehci-sched.c
===================================================================
--- 2.6.orig/drivers/usb/host/ehci-sched.c
+++ 2.6/drivers/usb/host/ehci-sched.c
@@ -637,7 +637,7 @@ iso_stream_alloc (unsigned mem_flags)
 {
 	struct ehci_iso_stream *stream;
 
-	stream = kcalloc(1, sizeof *stream, mem_flags);
+	stream = kzalloc(sizeof *stream, mem_flags);
 	if (likely (stream != NULL)) {
 		INIT_LIST_HEAD(&stream->td_list);
 		INIT_LIST_HEAD(&stream->free_list);
Index: 2.6/drivers/usb/host/isp116x-hcd.c
===================================================================
--- 2.6.orig/drivers/usb/host/isp116x-hcd.c
+++ 2.6/drivers/usb/host/isp116x-hcd.c
@@ -715,7 +715,7 @@ static int isp116x_urb_enqueue(struct us
 	}
 	/* avoid all allocations within spinlocks: request or endpoint */
 	if (!hep->hcpriv) {
-		ep = kcalloc(1, sizeof *ep, mem_flags);
+		ep = kzalloc(sizeof *ep, mem_flags);
 		if (!ep)
 			return -ENOMEM;
 	}
Index: 2.6/drivers/usb/host/sl811-hcd.c
===================================================================
--- 2.6.orig/drivers/usb/host/sl811-hcd.c
+++ 2.6/drivers/usb/host/sl811-hcd.c
@@ -835,7 +835,7 @@ static int sl811h_urb_enqueue(
 
 	/* avoid all allocations within spinlocks */
 	if (!hep->hcpriv)
-		ep = kcalloc(1, sizeof *ep, mem_flags);
+		ep = kzalloc(sizeof *ep, mem_flags);
 
 	spin_lock_irqsave(&sl811->lock, flags);
 
Index: 2.6/drivers/usb/input/acecad.c
===================================================================
--- 2.6.orig/drivers/usb/input/acecad.c
+++ 2.6/drivers/usb/input/acecad.c
@@ -152,7 +152,7 @@ static int usb_acecad_probe(struct usb_i
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
 
-	acecad = kcalloc(1, sizeof(struct usb_acecad), GFP_KERNEL);
+	acecad = kzalloc(sizeof(struct usb_acecad), GFP_KERNEL);
 	if (!acecad)
 		return -ENOMEM;
 
Index: 2.6/drivers/usb/input/itmtouch.c
===================================================================
--- 2.6.orig/drivers/usb/input/itmtouch.c
+++ 2.6/drivers/usb/input/itmtouch.c
@@ -166,7 +166,7 @@ static int itmtouch_probe(struct usb_int
 	interface = intf->cur_altsetting;
 	endpoint = &interface->endpoint[0].desc;
 
-	if (!(itmtouch = kcalloc(1, sizeof(struct itmtouch_dev), GFP_KERNEL))) {
+	if (!(itmtouch = kzalloc(sizeof(struct itmtouch_dev), GFP_KERNEL))) {
 		err("%s - Out of memory.", __FUNCTION__);
 		return -ENOMEM;
 	}
Index: 2.6/drivers/usb/input/pid.c
===================================================================
--- 2.6.orig/drivers/usb/input/pid.c
+++ 2.6/drivers/usb/input/pid.c
@@ -263,7 +263,7 @@ int hid_pid_init(struct hid_device *hid)
 	struct hid_ff_pid *private;
 	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
 
-	private = hid->ff_private = kcalloc(1, sizeof(struct hid_ff_pid), GFP_KERNEL);
+	private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
 	if (!private)
 		return -ENOMEM;
 

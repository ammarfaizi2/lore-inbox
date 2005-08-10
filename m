Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVHJA0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVHJA0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVHJA0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:26:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21757 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750952AbVHJA0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:26:39 -0400
Subject: Re: BUG: Real-Time Preemption 2.6.13-rc5-RT-V0.7.52-16
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <200508092158.j79LwlmM010246@cichlid.com>
References: <200508092158.j79LwlmM010246@cichlid.com>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 09 Aug 2005 17:26:28 -0700
Message-Id: <1123633588.13135.27.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This may fix the warning , but I doubt it does anything for any hangs..

--- linux-2.6.12.orig/drivers/usb/core/hcd.c    2005-08-09 22:41:18.000000000 +0000
+++ linux-2.6.12/drivers/usb/core/hcd.c 2005-08-10 00:23:16.000000000 +0000
@@ -540,8 +540,7 @@ void usb_hcd_poll_rh_status(struct usb_h
        if (length > 0) {

                /* try to complete the status urb */
-               local_irq_save (flags);
-               spin_lock(&hcd_root_hub_lock);
+               spin_lock_irqsave(&hcd_root_hub_lock, flags);
                urb = hcd->status_urb;
                if (urb) {
                        spin_lock(&urb->lock);







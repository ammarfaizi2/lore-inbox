Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWCLQ0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWCLQ0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWCLQ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:26:36 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:8904
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751368AbWCLQ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:26:36 -0500
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
From: Paul Fulghum <paulkf@microgate.com>
To: Bob Copeland <email@bobcopeland.com>
Cc: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <b6c5339f0603111221k2d0afce5hcfd485713ba17338@mail.gmail.com>
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
	 <1142011340.3220.4.camel@amdx2.microgate.com>
	 <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>
	 <1142018709.26063.5.camel@amdx2.microgate.com>
	 <20060311150908.GA4872@hash.localnet>
	 <1142099765.3241.3.camel@x2.pipehead.org>
	 <b6c5339f0603111221k2d0afce5hcfd485713ba17338@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 10:26:29 -0600
Message-Id: <1142180789.4360.2.camel@x2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob, if you are still willing, please try this patch
with the slab debug turned on and see if it still oops.

Thanks,
Paul

-- 
Paul Fulghum
Microgate Systems, Ltd

--- linux-2.6.16-rc5/drivers/usb/class/cdc-acm.c	2006-02-27 09:24:29.000000000 -0600
+++ b/drivers/usb/class/cdc-acm.c	2006-03-12 10:22:21.000000000 -0600
@@ -980,7 +980,7 @@ skip_normal_probe:
 	usb_driver_claim_interface(&acm_driver, data_interface, acm);
 
 	usb_get_intf(control_interface);
-	tty_register_device(acm_tty_driver, minor, &control_interface->dev);
+	tty_register_device(acm_tty_driver, minor, NULL);
 
 	acm_table[minor] = acm;
 	usb_set_intfdata (intf, acm);



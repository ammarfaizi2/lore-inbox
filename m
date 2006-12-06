Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937620AbWLFU1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937620AbWLFU1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937619AbWLFU1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:27:34 -0500
Received: from atlantis.8hz.com ([212.129.237.78]:62165 "EHLO atlantis.8hz.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937620AbWLFU1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:27:33 -0500
Date: Wed, 6 Dec 2006 20:27:32 +0000
From: Sean Young <sean@mess.org>
To: Greg KH <gregkh@suse.de>, Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH][STABLE 2.6.19] Fix oops in PhidgetServo
Message-ID: <20061206202732.GA91199@atlantis.8hz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

The PhidgetServo causes an Oops when any of its sysfs attributes are read
or written too, making the driver useless.

Signed-off-by: Sean Young <sean@mess.org>
---
Please consider this for inclusion in the next -stable, this issue is 
affecting users.

--- linux-2.6.19/drivers/usb/misc/phidgetservo.c.orig	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/drivers/usb/misc/phidgetservo.c	2006-12-04 21:01:40.000000000 +0000
@@ -282,6 +282,7 @@ servo_probe(struct usb_interface *interf
 		dev->dev = NULL;
 		goto out;
 	}
+	dev_set_drvdata(dev->dev, dev);
 
 	servo_count = dev->type & SERVO_COUNT_QUAD ? 4 : 1;
 

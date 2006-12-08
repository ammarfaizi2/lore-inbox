Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1761297AbWLIAAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761297AbWLIAAR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbWLIAAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:00:02 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37544 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947537AbWLHX7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:51 -0500
Message-Id: <20061209000128.086305000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:11 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Sean Young <sean@mess.org>,
       linux-usb-devel@lists.sourceforge.net,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/32] USB: Fix oops in PhidgetServo
Content-Disposition: inline; filename=usb-fix-oops-in-phidgetservo.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Sean Young <sean@mess.org>

The PhidgetServo causes an Oops when any of its sysfs attributes are read
or written too, making the driver useless.

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/usb/misc/phidgetservo.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19.orig/drivers/usb/misc/phidgetservo.c
+++ linux-2.6.19/drivers/usb/misc/phidgetservo.c
@@ -282,6 +282,7 @@ servo_probe(struct usb_interface *interf
 		dev->dev = NULL;
 		goto out;
 	}
+	dev_set_drvdata(dev->dev, dev);
 
 	servo_count = dev->type & SERVO_COUNT_QUAD ? 4 : 1;
 

--

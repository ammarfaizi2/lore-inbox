Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264783AbTFESNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbTFESNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:13:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8366 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264783AbTFESNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:13:14 -0400
Date: Thu, 5 Jun 2003 11:26:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] typo in new class_device_release
Message-Id: <20030605112641.7cb00f93.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in the current 2.5.70 bk version of class_device_release that
was not there in my original patch.  By confusing the class and the class_device,
the release function oops.  cd->release is always the function itself (class_device_release),
cls->release is the one setup for the class (net_class in my case).

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Thu Jun  5 11:21:42 2003
+++ b/drivers/base/class.c	Thu Jun  5 11:21:42 2003
@@ -191,7 +191,7 @@
 	pr_debug("device class '%s': release.\n",cd->class_id);
 
 	if (cls->release)
-		cd->release(cd);
+		cls->release(cd);
 }
 
 static struct kobj_type ktype_class_device = {

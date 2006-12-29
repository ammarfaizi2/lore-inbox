Return-Path: <linux-kernel-owner+w=401wt.eu-S1754826AbWL2GpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbWL2GpP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbWL2GpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:45:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39088 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827AbWL2GpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:45:14 -0500
Date: Fri, 29 Dec 2006 01:45:11 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: compile fix for via-pmu-backlight
Message-ID: <20061229064511.GC23251@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is right. I just copied the other conversions.
Given every other driver added a 'NULL' too, I'm a bit suspicious
but I lack the hardware to test this.

drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_init':
drivers/macintosh/via-pmu-backlight.c:150: error: too few arguments to function 'backlight_device_register'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.19.noarch/drivers/macintosh/via-pmu-backlight.c~	2006-12-29 01:41:24.000000000 -0500
+++ linux-2.6.19.noarch/drivers/macintosh/via-pmu-backlight.c	2006-12-29 01:41:28.000000000 -0500
@@ -147,7 +147,7 @@ void __init pmu_backlight_init()
 
 	snprintf(name, sizeof(name), "pmubl");
 
-	bd = backlight_device_register(name, NULL, &pmu_backlight_data);
+	bd = backlight_device_register(name, NULL, NULL, &pmu_backlight_data);
 	if (IS_ERR(bd)) {
 		printk("pmubl: Backlight registration failed\n");
 		goto error;
-- 
http://www.codemonkey.org.uk

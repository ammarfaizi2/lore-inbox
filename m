Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUHTIAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUHTIAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUHTIAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:00:55 -0400
Received: from main.gmane.org ([80.91.224.249]:64979 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264113AbUHTIAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:00:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: swsusp: avoid emergency disk parking in "platform" mode
Date: Fri, 20 Aug 2004 09:50:37 +0200
Message-ID: <4125AD4D.7090102@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010704060102000900070006"
X-Complaints-To: usenet@sea.gmane.org
Cc: Pavel Machek <pavel@suse.cz>
X-Gmane-NNTP-Posting-Host: charybdis-ext.suse.de
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010704060102000900070006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

although the issue seems fixed on normal shutdown and with swsusp in
"shutdown" mode, i still get the ugly "clunk" of my emergency-parking
disk in platform mode.
The attached patch fixes this for me, although i am not sure this is the
correct way to do. Probably some device_suspend(SOMETHING) would be
better and maybe the device_power_down is no longer needed, but
something needs to be done at this point.

   Stefan

--------------010704060102000900070006
Content-Type: text/x-patch;
 name="platform_device_shutdown.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platform_device_shutdown.diff"

diff -ru --exclude '*.o' linux-orig/kernel/power/disk.c linux/kernel/power/disk.c
--- linux-orig/kernel/power/disk.c	2004-08-17 19:56:33.000000000 +0200
+++ linux/kernel/power/disk.c	2004-08-20 09:40:40.581304056 +0200
@@ -49,6 +49,7 @@
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
+		device_shutdown();
 		device_power_down(PM_SUSPEND_DISK);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;

--------------010704060102000900070006--


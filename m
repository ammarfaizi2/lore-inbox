Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUBVRkg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUBVRkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:40:35 -0500
Received: from [212.50.18.217] ([212.50.18.217]:8965 "EHLO gw.zaxl.net")
	by vger.kernel.org with ESMTP id S261711AbUBVRkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:40:21 -0500
Date: Sun, 22 Feb 2004 19:40:13 +0200 (EET)
From: Alexander Atanasov <alex@ssi.bg>
X-X-Sender: alex@mars.home.zaxl.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH] runtime PM deadlock
Message-ID: <Pine.LNX.4.58.0402221908540.13861@mars.home.zaxl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	echo -n 3 > /sys/.../power/state; echo -n 2 > /sys/.../power/state

	dpm_runtime_suspend holds dpm_sem and calls
dpm_runtime_resume which deadlocks, instead
directly call runtime_resume.

-- 
have fun,
alex

===== drivers/base/power/runtime.c 1.2 vs edited =====
--- 1.2/drivers/base/power/runtime.c	Wed Aug 20 09:23:32 2003
+++ edited/drivers/base/power/runtime.c	Sun Feb 22 18:26:42 2004
@@ -51,7 +51,7 @@
 		goto Done;

 	if (dev->power.power_state)
-		dpm_runtime_resume(dev);
+		runtime_resume(dev);

 	if (!(error = suspend_device(dev,state)))
 		dev->power.power_state = state;

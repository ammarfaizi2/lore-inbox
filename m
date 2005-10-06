Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVJFVQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVJFVQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVJFVQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:16:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29653 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751357AbVJFVQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:16:59 -0400
Date: Thu, 6 Oct 2005 23:14:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Get rid of the obsolete tri-level suspend/resume callbacks (was: Re: [PATCH/RFC 1/2] simple SPI framework)
Message-ID: <20051006211433.GB27711@elf.ucw.cz>
References: <20051005143946.7D9C9EE8EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20051006182349.7430.qmail@web33007.mail.mud.yahoo.com> <20051006182938.GA5312@flint.arm.linux.org.uk> <20051006190234.GB5312@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006190234.GB5312@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's a patch to illustrate what I mean.

Nice, _very_ nice. It broke compilation at two places... Here are fixes.

							Pavel


diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -48,7 +48,7 @@ static int i2c_bus_suspend(struct device
 	int rc = 0;
 
 	if (dev->driver && dev->driver->suspend)
-		rc = dev->driver->suspend(dev,state,0);
+		rc = dev->driver->suspend(dev,state);
 	return rc;
 }
 
@@ -57,7 +57,7 @@ static int i2c_bus_resume(struct device 
 	int rc = 0;
 	
 	if (dev->driver && dev->driver->resume)
-		rc = dev->driver->resume(dev,0);
+		rc = dev->driver->resume(dev);
 	return rc;
 }
 
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -1292,7 +1292,7 @@ static void nodemgr_suspend_ne(struct no
 
 		if (ud->device.driver &&
 		    (!ud->device.driver->suspend ||
-		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND, 0)))
+		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND)))
 			device_release_driver(&ud->device);
 	}
 	up_write(&ne->device.bus->subsys.rwsem);
@@ -1315,7 +1315,7 @@ static void nodemgr_resume_ne(struct nod
 			continue;
 
 		if (ud->device.driver && ud->device.driver->resume)
-			ud->device.driver->resume(&ud->device, 0);
+			ud->device.driver->resume(&ud->device);
 	}
 	up_read(&ne->device.bus->subsys.rwsem);
 


-- 
if you have sharp zaurus hardware you don't need... you know my address

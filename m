Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752125AbWIXFfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWIXFfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 01:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbWIXFfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 01:35:06 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:25560 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1752125AbWIXFfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 01:35:05 -0400
Date: Sat, 23 Sep 2006 23:35:04 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dev_printk() is now GPL-only
Message-ID: <20060924053503.GA30273@parisc-linux.org>
References: <20060807025723.GK4379@parisc-linux.org> <20060807030958.GA638@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807030958.GA638@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 08:09:58PM -0700, Greg KH wrote:
> Care to send me a patch to fix it up?

Sorry for the delay ...

Make dev_printk usable from non-GPL modules again

dev_printk now calls dev_driver_string.  We want even proprietary modules
to be calling dev_printk, so the export of dev_driver_string needs to be
non-GPL-only.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/base/core.c b/drivers/base/core.c
index be6b5bc..426be09 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -42,7 +42,7 @@ const char *dev_driver_string(struct dev
 	return dev->driver ? dev->driver->name :
 			(dev->bus ? dev->bus->name : "");
 }
-EXPORT_SYMBOL_GPL(dev_driver_string);
+EXPORT_SYMBOL(dev_driver_string);
 
 #define to_dev(obj) container_of(obj, struct device, kobj)
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)

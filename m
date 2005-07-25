Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVGYEJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVGYEJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 00:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVGYEJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 00:09:06 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:7130 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261186AbVGYEJE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 00:09:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qWTzerc5QQWr/Yz7JpXURCEnmzXlux5ctyXYgo8sTLhpwGosaSLMm28fMdpKeTCgb6feMdcLxyxVt7IR/NL6qBQFpefI4O1ChbV3fXeaTXwcfdG3FgvlzGb2c+cHCkJzHmo0RLCMVnzRLsILFB2dkZC93GnybACWrTeZ/4cREs0=
Message-ID: <9e47339105072421095af5d37a@mail.gmail.com>
Date: Mon, 25 Jul 2005 00:09:04 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just pulled from GIT to test bind/unbind. I couldn't get it to work;
it isn't taking into account the CR on the end of the input value of
the sysfs attribute.  This patch will fix it but I'm sure there is a
cleaner solution.

-- 
Jon Smirl
jonsmirl@gmail.com


diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -137,9 +137,11 @@ decl_subsys(bus, &ktype_bus, NULL);
 static int driver_helper(struct device *dev, void *data)
 {
        const char *name = data;
-
-       if (strcmp(name, dev->bus_id) == 0)
+printk(KERN_ERR "unbind: %s %s\n", name, dev->bus_id);
+       if (strncmp(name, dev->bus_id, strlen(dev->bus_id)) == 0) {
+printk(KERN_ERR "match\n");
                return 1;
+       }
        return 0;
 }

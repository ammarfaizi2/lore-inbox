Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUEKOBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUEKOBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264738AbUEKOBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:01:32 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:53632 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264746AbUEKOA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:00:58 -0400
Subject: Re: [PATCH] fix dev_printk to work even in the absence of am
	attached driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040422220756.GA2479@kroah.com>
References: <1082407198.1804.35.camel@mulgrave> 
	<20040422220756.GA2479@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 May 2004 09:00:47 -0500
Message-Id: <1084284048.2305.6.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 17:07, Greg KH wrote: 
> But doesn't this cause the string "(unbound)" to be created for every
> dev_printk() call in the code?  I don't think gcc can optimize that very
> well.  How about making a global string just for that, otherwise the
> size police will come after me for adding such a patch :)

OK, I can't find an elegant way of making it global, so I think the best
thing to do is just leave it blank for no driver (gcc can optimise that
case). 

James 

===== include/linux/device.h 1.117 vs edited =====
--- 1.117/include/linux/device.h	Mon Apr 12 12:54:25 2004
+++ edited/include/linux/device.h	Tue May 11 08:58:44 2004
@@ -400,7 +400,7 @@
 
 /* debugging and troubleshooting/diagnostic helpers. */
 #define dev_printk(level, dev, format, arg...)	\
-	printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , ## arg)
+	printk(level "%s %s: " format , (dev)->driver ? (dev)->driver->name : "" , (dev)->bus_id , ## arg)
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\


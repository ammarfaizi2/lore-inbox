Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTDMUdk (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 16:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbTDMUdj (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 16:33:39 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:65031
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261916AbTDMUdh 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 16:33:37 -0400
Subject: Re: 2.5.67-mm2
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Alistair Strachan <alistair@devzero.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20030413130543.081c80fd.akpm@digeo.com>
References: <200304132059.11503.alistair@devzero.co.uk>
	 <20030413130543.081c80fd.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050266723.767.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 16:45:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 16:05, Andrew Morton wrote:

> It's a bk bug.  This might make it boot:

Yah, I needed a similar patch to make 2.5.67-mm2 boot.  Not sure if its
hiding the real problem or not, but it works.

Note the difference between mine and your's, though.  I think you need
it.

	Robert Love


 drivers/base/class.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -urN linux-2.5.67/drivers/base/class.c linux/drivers/base/class.c
--- linux-2.5.67/drivers/base/class.c	2003-04-07 13:33:00.000000000 -0400
+++ linux/drivers/base/class.c	2003-04-13 16:32:52.000000000 -0400
@@ -103,12 +105,12 @@
 	struct device_class * cls = get_devclass(drv->devclass);
 	int error = 0;
 
-	if (cls) {
+	if (cls && &cls->subsys) {
 		down_write(&cls->subsys.rwsem);
 		pr_debug("device class %s: adding driver %s:%s\n",
 			 cls->name,drv->bus->name,drv->name);
 		error = devclass_drv_link(drv);
-		
+
 		if (!error)
 			list_add_tail(&drv->class_list,&cls->drivers.list);
 		up_write(&cls->subsys.rwsem);




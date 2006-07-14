Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWGNQaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWGNQaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWGNQaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:30:25 -0400
Received: from mo32.po.2iij.net ([210.128.50.17]:28454 "EHLO mo32.po.2iij.net")
	by vger.kernel.org with ESMTP id S1161142AbWGNQaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:30:24 -0400
Date: Sat, 15 Jul 2006 01:30:11 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Lexington Luthor <Lexington.Luthor@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fixed add_bind_files() definition
Message-Id: <20060715013011.044be9ad.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <e9833o$er9$1@sea.gmane.org>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<e9833o$er9$1@sea.gmane.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Jul 2006 13:36:06 +0100
Lexington Luthor <Lexington.Luthor@gmail.com> wrote:

> Hi,
> 
> I get a compile error trying to build this release:
>    CC      drivers/base/bus.o
> drivers/base/bus.c: In function 'bus_add_driver':
> drivers/base/bus.c:523: error: void value not ignored as it ought to be

When CONFIG_HOTPLUG is n, add_bind_files() definition is wrong.
This patch has fixed it.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X linux-2.6.18-rc1-mm2/Documentation/dontdiff linux-2.6.18-rc1-mm2-orig/drivers/base/bus.c linux-2.6.18-rc1-mm2/drivers/base/bus.c
--- linux-2.6.18-rc1-mm2-orig/drivers/base/bus.c	2006-07-14 15:27:18.006967000 +0900
+++ linux-2.6.18-rc1-mm2/drivers/base/bus.c	2006-07-14 16:33:17.075226250 +0900
@@ -485,7 +485,7 @@ static void remove_bind_files(struct dev
 	driver_remove_file(drv, &driver_attr_unbind);
 }
 #else
-static inline void add_bind_files(struct device_driver *drv) {}
+static inline int add_bind_files(struct device_driver *drv) { return 0; }
 static inline void remove_bind_files(struct device_driver *drv) {}
 #endif
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTDMTxx (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 15:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTDMTxx (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 15:53:53 -0400
Received: from [12.47.58.73] ([12.47.58.73]:63738 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261826AbTDMTxw (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 15:53:52 -0400
Date: Sun, 13 Apr 2003 13:05:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alistair Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm2
Message-Id: <20030413130543.081c80fd.akpm@digeo.com>
In-Reply-To: <200304132059.11503.alistair@devzero.co.uk>
References: <200304132059.11503.alistair@devzero.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 20:05:35.0244 (UTC) FILETIME=[0B780CC0:01C301F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Strachan <alistair@devzero.co.uk> wrote:
>
> > EIP is at devclass_add_driver+0x34/0x8a
> ...
> 
> I get the same thing on an mm2 boot. Are you certain it isn't a -bk4 
> bug? kobject, bus_add_driver and friends have all been touched by greg 
> in bk, and I can't see anything immediately obvious in the new -mm 
> patches (-mm1 works fine).
> 
> I'll try with just the linus drop now.

It's a bk bug.  This might make it boot:

 drivers/base/class.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/base/class.c~a drivers/base/class.c
--- 25/drivers/base/class.c~a	2003-04-13 13:04:47.000000000 -0700
+++ 25-akpm/drivers/base/class.c	2003-04-13 13:04:52.000000000 -0700
@@ -105,7 +105,7 @@ int devclass_add_driver(struct device_dr
 	struct device_class * cls = get_devclass(drv->devclass);
 	int error = 0;
 
-	if (cls) {
+	if (cls && cls->subsys) {
 		down_write(&cls->subsys.rwsem);
 		pr_debug("device class %s: adding driver %s:%s\n",
 			 cls->name,drv->bus->name,drv->name);

_


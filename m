Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWCKPLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWCKPLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWCKPLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:11:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16905 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751161AbWCKPLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:11:47 -0500
Date: Sat, 11 Mar 2006 16:11:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: tim@cyberelk.net, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/paride/pd.c: fix an off-by-one error
Message-ID: <20060311151146.GQ21864@stusta.de>
References: <20060311034253.GI21864@stusta.de> <20060310200350.11127467.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310200350.11127467.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 08:03:50PM -0800, Randy.Dunlap wrote:
> On Sat, 11 Mar 2006 04:42:53 +0100 Adrian Bunk wrote:
> 
> > The Coverity checker found this off-by-one error.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c.old	2006-03-11 02:07:21.000000000 +0100
> > +++ linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c	2006-03-11 02:07:50.000000000 +0100
> > @@ -275,7 +275,7 @@
> >  	int i;
> >  
> >  	printk("%s: %s: status = 0x%x =", disk->name, msg, status);
> > -	for (i = 0; i < 18; i++)
> > +	for (i = 0; i < 17; i++)
> >  		if (status & (1 << i))
> >  			printk(" %s", pd_errs[i]);
> >  	printk("\n");
> 
> Please use ARRAY_SIZE(pd_errs)
> and #include <linux/kernel.h>

Sounds reasonable, updated patch below.

> ~Randy

cu
Adrian


<--  snip  -->


The Coverity checker found this off-by-one error.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/paride/pd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c.old	2006-03-11 02:07:21.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c	2006-03-11 15:36:00.000000000 +0100
@@ -151,6 +151,7 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_GEO,
 #include <linux/cdrom.h>	/* for the eject ioctl */
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
+#include <linux/kernel.h>
 #include <asm/uaccess.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
@@ -275,7 +276,7 @@ static void pd_print_error(struct pd_uni
 	int i;
 
 	printk("%s: %s: status = 0x%x =", disk->name, msg, status);
-	for (i = 0; i < 18; i++)
+	for (i = 0; i < ARRAY_SIZE(pd_errs); i++)
 		if (status & (1 << i))
 			printk(" %s", pd_errs[i]);
 	printk("\n");


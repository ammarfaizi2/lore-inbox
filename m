Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVIBXYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVIBXYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVIBXYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:24:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41228 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751007AbVIBXYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:24:14 -0400
Date: Sat, 3 Sep 2005 01:24:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/nbd.c: don't defer compile error to runtime
Message-ID: <20050902232403.GD3657@stusta.de>
References: <20050902221059.GY3657@stusta.de> <20050902192047.A5879@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902192047.A5879@mail.kroptech.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 07:20:47PM -0400, Adam Kropelin wrote:
> Adrian Bunk wrote:
> > If we can detect a problem at compile time, the compilation should
> > fail.
> 
> [...] 
> 
> >  	if (sizeof(struct nbd_request) != 28) {
> > -		printk(KERN_CRIT "nbd: sizeof nbd_request needs to be 28 in order to work!\n" );
> > -		return -EIO;
> > +		extern void nbd_request_wrong_size(void);
> > +		nbd_request_wrong_size();
> 
> 	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
> 
> ...perhaps?

Neat, I didn't know about this.

I didn't know about this.

> --Adam

cu
Adrian


<--  snip  -->


If we can detect a problem at compile time, the compilation should fail.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/drivers/block/nbd.c.old	2005-09-02 23:48:27.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/block/nbd.c	2005-09-03 01:08:04.000000000 +0200
@@ -643,10 +643,7 @@
 	int err = -ENOMEM;
 	int i;
 
-	if (sizeof(struct nbd_request) != 28) {
-		printk(KERN_CRIT "nbd: sizeof nbd_request needs to be 28 in order to work!\n" );
-		return -EIO;
-	}
+	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
 
 	if (nbds_max > MAX_NBD) {
 		printk(KERN_CRIT "nbd: cannot allocate more than %u nbds; %u requested.\n", MAX_NBD,


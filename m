Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTIYLDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTIYLDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:03:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15567 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261877AbTIYLDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:03:34 -0400
Date: Thu, 25 Sep 2003 13:03:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix non-modular ftape compile
Message-ID: <20030925110325.GK15696@fs.tum.de>
References: <20030925102309.GI15696@fs.tum.de> <20030925113816.A9693@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925113816.A9693@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:38:16AM +0100, Christoph Hellwig wrote:
> On Thu, Sep 25, 2003 at 12:23:09PM +0200, Adrian Bunk wrote:
> > ftape_proc_destroy is only available #ifdef MODULE, the following patch 
> > fixes the link error:
> 
> I'd suggest to kill the #ifdef MODULE instead and mark it __exit.
> Same result but less ifdef crap..


It increases the kernel size since in 2.6 __exit functions are discarded 
at runtime and not at link time.


Anyway, I agree with your suggestion. The following patch works instead 
of the first patch I sent.


--- linux-2.6.0-test5-mm4-no-smp-2.95/drivers/char/ftape/lowlevel/ftape-proc.c.old	2003-09-25 12:46:18.000000000 +0200
+++ linux-2.6.0-test5-mm4-no-smp-2.95/drivers/char/ftape/lowlevel/ftape-proc.c	2003-09-25 12:46:50.000000000 +0200
@@ -207,11 +207,9 @@
 		ftape_read_proc, NULL) != NULL;
 }
 
-#ifdef MODULE
-void ftape_proc_destroy(void)
+void __exit ftape_proc_destroy(void)
 {
 	remove_proc_entry("ftape", &proc_root);
 }
-#endif
 
 #endif /* defined(CONFIG_PROC_FS) && defined(CONFIG_FT_PROC_FS) */


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


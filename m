Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUH1QeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUH1QeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUH1Qbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:31:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65493 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267486AbUH1Q0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:26:40 -0400
Date: Sat, 28 Aug 2004 18:26:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Message-ID: <20040828162633.GG12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151544.GB12772@fs.tum.de> <098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:05:10PM -0400, Kyle Moffett wrote:
> On Aug 28, 2004, at 11:15, Adrian Bunk wrote:
> >The patch below does BUG -> BUG_ON conversions in ipc/ .
> >--- linux-2.6.9-rc1-mm1-full-3.4/ipc/shm.c.old	2004-08-28 
> >15:55:28.000000000 +0200
> >+++ linux-2.6.9-rc1-mm1-full-3.4/ipc/shm.c	2004-08-28 
> >16:02:56.000000000 +0200
> >@@ -86,8 +86,7 @@
> > static inline void shm_inc (int id) {
> > 	struct shmid_kernel *shp;
> >
> >-	if(!(shp = shm_lock(id)))
> >-		BUG();
> >+	BUG_ON(!(shp = shm_lock(id)));
> 
> This won't work:
> 
> With debugging mode:
> if (unlikely(!(shp = shm_lock(id)))) BUG();
> 
> Without debugging mode:
> do { } while(0)

Where in 2.6.9-rc1-mm1 is this "Without debugging mode" defined?

> Anything you put in BUG_ON() must *NOT* have side effects.
>...

I'd have said exactly the same some time ago, but I was convinced by 
Arjan that if done correctly, a BUG_ON() with side effects is possible  
with no extra cost even if you want to make BUG configurably do nothing.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbSJAKPj>; Tue, 1 Oct 2002 06:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbSJAKPj>; Tue, 1 Oct 2002 06:15:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36480 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261553AbSJAKPi>;
	Tue, 1 Oct 2002 06:15:38 -0400
Date: Tue, 1 Oct 2002 12:20:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, evms-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] EVMS Release 1.2.0
Message-ID: <20021001102043.GD20878@suse.de>
References: <0209301701470A.15956@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0209301701470A.15956@boiler>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30 2002, Kevin Corry wrote:
> The EVMS team is announcing the next stable release of the Enterprise Volume 
> Management System, which will eventually become EVMS 2.0. Package 1.2.0 is 
> now available for download at the project web site:
> http://www.sf.net/projects/evms

[evms.c]

#ifndef CONFIG_SMP
static spinlock_t evms_request_lock = SPIN_LOCK_UNLOCKED;
#endif

...

#ifdef CONFIG_SMP
       blk_dev[EVMS_MAJOR].queue = evms_find_queue;
#else
       blk_init_queue(BLK_DEFAULT_QUEUE(EVMS_MAJOR),
                      evms_do_request_fn, &evms_request_lock);
       blk_queue_make_request(BLK_DEFAULT_QUEUE(EVMS_MAJOR),
                              evms_make_request_fn);
#endif

...

#ifdef CONFIG_SMP
       lv->request_lock = SPIN_LOCK_UNLOCKED;
       blk_init_queue(&lv->request_queue,
                      evms_do_request_fn,
                      &lv->request_lock);
       blk_queue_make_request(&lv->request_queue,
                              evms_make_request_fn);
#endif

What the hell is that about?


-- 
Jens Axboe


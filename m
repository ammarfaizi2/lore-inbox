Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274607AbRITSr4>; Thu, 20 Sep 2001 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274608AbRITSrq>; Thu, 20 Sep 2001 14:47:46 -0400
Received: from [195.223.140.107] ([195.223.140.107]:23540 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274607AbRITSrh>;
	Thu, 20 Sep 2001 14:47:37 -0400
Date: Thu, 20 Sep 2001 20:47:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrew Morton <andrewm@uow.edu.au>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
Message-ID: <20010920204712.T729@athlon.random>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <773660000.1001006393@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <773660000.1001006393@tiny>; from mason@suse.com on Thu, Sep 20, 2001 at 01:19:53PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 01:19:53PM -0400, Chris Mason wrote:
> 
> 
> On Thursday, September 20, 2001 07:08:25 PM +0200 Dieter Nützel
> <Dieter.Nuetzel@hamburg.de> wrote:
> 
> 
> > Please have a look at Robert Love's Linux kernel preemption patches and
> > the  conversation about my reported latency results.
> > 
> 
> Andrew Morton has patches that significantly improve the reiserfs latency,
> looks like the last one he sent me was 2.4.7-pre9.  He and I did a bunch of
> work to make sure they introduce schedules only when it was safe.
> 
> Andrew, are these still maintained or should I pull out the reiserfs bits?

May not help latency but I suspect this could help reiserfs, it should
basically be a noop for ext2.

--- 2.4.10pre12aa2/fs/buffer.c.~1~	Thu Sep 20 20:14:19 2001
+++ 2.4.10pre12aa2/fs/buffer.c	Thu Sep 20 20:45:58 2001
@@ -2506,7 +2506,7 @@
 	spin_unlock(&free_list[isize].lock);
 
 	page->buffers = bh;
-	page->flags &= ~(1 << PG_referenced);
+	page->flags |= 1 << PG_referenced;
 	lru_cache_add(page);
 	UnlockPage(page);
 	atomic_inc(&buffermem_pages);

You may want to give it a spin.

Andrea

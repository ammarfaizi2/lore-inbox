Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTE2RUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTE2RUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:20:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5842 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262422AbTE2RUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:20:03 -0400
Date: Thu, 29 May 2003 19:33:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
Message-ID: <20030529173325.GS845@suse.de>
References: <3ED4681A.738DA3C6@fy.chalmers.se> <20030528074839.GU845@suse.de> <3ED4E70D.1E62D435@fy.chalmers.se> <20030528170347.GC845@suse.de> <3ED6103E.DFDAD2D8@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED6103E.DFDAD2D8@fy.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29 2003, Andy Polyakov wrote:
> > > ... I noticed that DMA is never engaged
> > > on that buffer allocated with kmalloc. The question is if it's
> > > intentional? If answer is yes, then the case is dismissed. If not, then
> > > it should be looked into...
> > 
> > Depends on the lower level driver, for ide-cd yes kmalloc'ed data will
> > not be dma'ed to. We require a valid bio setup for that, usually the bio
> > mapping will fail exactly because the length/alignment isn't correct for
> > ide-cd.
> > 
> > > ... it might be appropriate to retry
> > > bio_map_user on buffer. I'm actually stepping out of my competence
> > > domains here...
> > 
> > It's usually not worth it. If the buffer is < 4 bytes, we don't dma. Big
> > deal.
> 
> Well, I'm concerned rather about cases when user buffer ends up in non
> DMA-able memory than small or misaligned buffers. I mean those who have
> system with loads of RAM didn't do anything wrong, yet they get
> "punished." But I'm not actually insisting! Just saying that it *might*
> be worth reconsidering "ide-cd won't do dma without bio setup" clause or
> retry bio_map_user on kalloc-ed buffer. At least for transfers not
> smaller than say 2K:-)

This is bogus. Applications already dish out the right buffers and in
the right lengths. It's the logical thing to do.

You are making up a problem that doesn't exist.

-- 
Jens Axboe


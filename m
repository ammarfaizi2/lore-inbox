Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTE2NhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 09:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTE2NhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 09:37:23 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:63154 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S262237AbTE2NhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 09:37:22 -0400
Message-ID: <3ED6103E.DFDAD2D8@fy.chalmers.se>
Date: Thu, 29 May 2003 15:50:54 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
References: <3ED4681A.738DA3C6@fy.chalmers.se> <20030528074839.GU845@suse.de> <3ED4E70D.1E62D435@fy.chalmers.se> <20030528170347.GC845@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ... I noticed that DMA is never engaged
> > on that buffer allocated with kmalloc. The question is if it's
> > intentional? If answer is yes, then the case is dismissed. If not, then
> > it should be looked into...
> 
> Depends on the lower level driver, for ide-cd yes kmalloc'ed data will
> not be dma'ed to. We require a valid bio setup for that, usually the bio
> mapping will fail exactly because the length/alignment isn't correct for
> ide-cd.
> 
> > ... it might be appropriate to retry
> > bio_map_user on buffer. I'm actually stepping out of my competence
> > domains here...
> 
> It's usually not worth it. If the buffer is < 4 bytes, we don't dma. Big
> deal.

Well, I'm concerned rather about cases when user buffer ends up in non
DMA-able memory than small or misaligned buffers. I mean those who have
system with loads of RAM didn't do anything wrong, yet they get
"punished." But I'm not actually insisting! Just saying that it *might*
be worth reconsidering "ide-cd won't do dma without bio setup" clause or
retry bio_map_user on kalloc-ed buffer. At least for transfers not
smaller than say 2K:-)

Cheers. A.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269038AbUICOwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269038AbUICOwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUICOwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:52:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6809 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269038AbUICOwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:52:10 -0400
Date: Fri, 3 Sep 2004 16:50:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.dk
Subject: Re: Nasty IDE crasher in 2.6.9rc1
Message-ID: <20040903145054.GQ1631@suse.de>
References: <20040831142335.GA15841@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831142335.GA15841@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(suse.dk is not related to suse.de and it helpfully eats all messages
sent to unknown users. not so great :(

On Tue, Aug 31 2004, Alan Cox wrote:
> You never never issue unknown commands to drives. Thats how Mandrake destroyed 
> CD-ROM drives. I knew this was in -mm and supposed to be getting sorted I was
> somewhat horrified to find it in 2.6.9rc1.
> 
> This patch crashes two of my CF cards (one so badly you have to reformat it
> to get it back) and anything attached to an IT8212 controller. The correct
> fix is to do what the standard actually says and always check for cache
> flush. Contrary to the comment in the patch drives do report this correctly
> its just that some of them nop unknown commands.
> 
> Please fix this patch segment for rc2, its not just wrong, its dangerous.

Ugh, that's bad. I agree with the change, thanks. Linus passed it on.

> Another problem with barrier is that it can take several minutes worst case
> for the command to complete on a large modern drive (timings c/o friendly
> ide drive engineer). That causes two problems I've pointed out to Jens that
> we need to fix before barriers are IMHO production grade

Can you pass me his results?

> 1.	Anything based on fairness and latency is screwed. Throughput 
> 	apparently is up so it makes sense for some users, and probably
> 	for others we should write cache off as Jens suggested.

Yes, it's a tradeoff. The user can decide himself what is most
important. It all depends on the work load, of course.

> 2.	The timeouts on the command issue appear to be too small, and
> 	we will time out and reset the drive in loaded situations. 

You don't seem to address that in your patch?

> Thankfully next generation ATA has both cache bypass writes and tagging.

But the tagging still isn't useful for this. Have they added
WIN_WRITE_DMA_EXT_QUEUED_FUA?

-- 
Jens Axboe


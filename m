Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUFCRHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUFCRHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUFCRHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:07:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52864 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263828AbUFCRDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:03:33 -0400
Date: Thu, 3 Jun 2004 19:03:28 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: submit_bh leaves interrupts on upon return
Message-ID: <20040603170328.GQ1946@suse.de>
References: <40BE93DC.6040501@drdos.com> <20040603085002.GG28915@suse.de> <40BF8E1F.1060009@drdos.com> <20040603165250.GO1946@suse.de> <40BF9124.6080807@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BF9124.6080807@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03 2004, Jeff V. Merkey wrote:
> Jens Axboe wrote:
> 
> >Submitting large numbers of buffer_heads from b_end_io is _nasty_, 2.4
> >io scheduler runtime isn't exactly world champion and you are doing this
> >at hard irq time. Not a good idea. Definitely not the true path to
> >performance, unless you don't care about anything else in the system.
> >
> >At least in 2.6 you have a much faster io scheduler and the additionally
> >large bio, so you wont spend nearly as much time there if you are
> >clever. You still need process context, though, that hasn't changed.
> >
> > 
> >
> Sounds like I need to move to 2.6. I noticed the elevator is coalescing 
> quite well, and since I am posting mostly continguous runs of sectors, 
> what ends up at the adapter level would probably not change much much 
> between 2.4 and 2.6 since I am maxing out the driver request queues as 
> it is (255 pending requests of 32 scatter/gather elements of 256 sector 
> runs). 2.6 might help but I suspect it will only help alleviate the 
> submission overhead, and not make much difference on performance since 
> the 3Ware card does have an upward limit on outstanding I/O requests.

That's correct, it just helps you diminish the submission overhead by
pushing down 256 sector entities in one go. So as long as you're io
bound it won't give you better io performance, of course. If you are
doing 400MiB/sec it should help you out, though.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSFDOzj>; Tue, 4 Jun 2002 10:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFDOzi>; Tue, 4 Jun 2002 10:55:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47079 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313113AbSFDOzh>;
	Tue, 4 Jun 2002 10:55:37 -0400
Date: Tue, 4 Jun 2002 16:55:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020604145528.GQ1105@suse.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de> <20020604142327.GN1105@suse.de> <3CFCC467.7060702@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> >Neil,
> >
> >I tried converting umem to see how it fit together, this is what I came
> >up with. This does use a queue per umem unit, but I think that's the
> >right split anyways. Maybe at some point we can use the per-major
> >statically allocated queues...
> 
> > 
> > /*
> >+ * remove the queue from the plugged list, if present. called with
> >+ * queue lock held and interrupts disabled.
> >+ */
> >+inline int blk_remove_plug(request_queue_t *q)
> 
> 
> Jens - I have noticed some unlikely() tag "optimizations" in
> tcq code too.
> Please tell my, why do you attribute this exported function as inline?
> I "hardly doubt" that it will ever show up on any profile.
> Contrary to popular school generally it only pays out to unroll vector code
> on modern CPUs not decision code like the above.

I doubt it matters much in this case. But it certainly isn't called
often enough to justify the inline, I'll uninline later.

WRT the unlikely(), if you have the hints available, why not pass them
on?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSJYVSp>; Fri, 25 Oct 2002 17:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbSJYVSp>; Fri, 25 Oct 2002 17:18:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4529 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261597AbSJYVSo>;
	Fri, 25 Oct 2002 17:18:44 -0400
Date: Fri, 25 Oct 2002 23:24:38 +0200
From: Jens Axboe <axboe@suse.de>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021025212438.GH1203@suse.de>
References: <45B36A38D959B44CB032DA427A6E10640167D070@cceexc18.americas.cpqcorp.net> <20021025211107.GG1203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025211107.GG1203@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Jens Axboe wrote:
> On Fri, Oct 25 2002, Cameron, Steve wrote:
> > Jens Axboe wrote:
> > > On Fri, Oct 25 2002, Stephen Cameron wrote:
> > > > 
> > > > Add blk_rq_map_sg_one_by_one function to ll_rw_blk.c in order to allow a low 
> > > > level driver to map scatter gather elements from the block subsystem one 
> > > > at a time 
> > [...]
> > > I have to say that I think this patch is ugly, and a complete 
> > > duplicate of existing code. This is always bad, especially in the case of
> > > something not really straight forward (like blk_rq_map_sg()). A hack.
> > 
> > Yes, I sort of figured you'd say that.  I was just trying to get the 
> > ball rolling.
> 
> I was hoping that was the case and you weren't really serious :-). I've
> cut a draft version of this, it's not tested at all though to be
> careful... It should do what you want, yes? I'm not too happy with this
> one, need a bit more time to ponder.

Well no doubt that this is much cleaner. It just needs to be evaluated
for over head... It does incur an extra function call per segment
mapped. On the other hand, we save the conditional and branch. IOW, I'll
probably go with this one.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269498AbUICPRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269498AbUICPRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUICPN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:13:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62879 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269147AbUICPMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:12:21 -0400
Date: Fri, 3 Sep 2004 17:10:53 +0200
From: Jens Axboe <axboe@suse.de>
To: bzolnier@milosz.na.pl
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: fix the barrier IDE detection logic
Message-ID: <20040903151053.GB1717@suse.de>
References: <20040831165046.GA6928@devserv.devel.redhat.com> <200409031554.31057.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409031554.31057.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> On Tuesday 31 August 2004 18:50, Alan Cox wrote:
> > This fixes the logic so we always check for the cache. It also defaults
> > to safer behaviour for the non cache flush case now we have the right bits
> > in the right places. I've also played a bit with timings - the worst case
> > timings I can get for the flush are about 7 seconds (which I'd expect
> > as the engineering worst cases will include retries)
> > 
> > Probably what should happen is that the barrier logic is enabled providing
> > the wcache is disabled. I've not meddled with this as I don't know what
> > the intended semantics and rules are for disabling barrier on a live disk
> > (eg when a user uses hdparm to turn on the write cache). In the current
> > code as with Jens original that cannot occur.
> 
> I think that logic is reversed here, I guess it should be: enable barrier
> if user enables wcache and disable it if user disables wcache.

There's no need for changes, ide_queue_flush_cmd() handles this fine
right now.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTLRHsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTLRHsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:48:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37826 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262848AbTLRHsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:48:04 -0500
Date: Thu, 18 Dec 2003 08:47:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mikem@beardog.cca.cpqcorp.net, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, mike.miller@hp.com, scott.benesh@hp.com
Subject: Re: cciss update for 2.4.24-pre1, 2 of 2
Message-ID: <20031218074749.GO2495@suse.de>
References: <Pine.LNX.4.58.0312161750290.30010@beardog.cca.cpqcorp.net> <20031217225007.GN2495@suse.de> <20031217154919.6ab61960.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217154919.6ab61960.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > +	for (i=0; i < 1200; i++) {
> > > +		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
> > > +		if (scratchpad == 0xffff0000) {
> > > +			ready = 1;
> > > +			break;
> > > +		}
> > > +		set_current_state(TASK_INTERRUPTIBLE);
> > > +		schedule_timeout(HZ / 10); /* wait 100ms */
> > > +	}
> > > +	if (!ready) {
> > > +		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
> > > +		return -1;
> > > +	}
> > 
> > Fine as well, aren't you happy you changed this to schedule_timeout()
> > instead of busy looping? :)
> 
> It will still be a busy loop if this task has a signal pending. 
> TASK_UNINTERRUPTIBLE may be more appropriate...

Agreed, that would be better.

-- 
Jens Axboe


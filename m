Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVKUHzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVKUHzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKUHzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:55:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32278 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932184AbVKUHzY (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 02:55:24 -0500
Date: Mon, 21 Nov 2005 08:56:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 2.6.15-rc2] blk: request poisoning
Message-ID: <20051121075639.GU25454@suse.de>
References: <438182E7.9080809@yahoo.com.au> <20051121073357.GS25454@suse.de> <438189F0.3020004@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438189F0.3020004@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21 2005, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Mon, Nov 21 2005, Nick Piggin wrote:
> >
> >>This patch should make request poisoning more useful
> >>and more easily extendible in the block layer.
> >>
> >>Don't think I have hardware that will trigger a requeue,
> >>but otherwise it has been moderately tested. Comments?
> >
> >
> >I like the idea, but I'm a little worried that it actually introduces
> >more problems than it solves. See the mail from yesterday for instance,
> >perfectly fine code but 'as' poisoning triggered.
> >
> >And the merging bits already look really ugly :/
> >
> >So I guess my question is, did this code ever find any driver problems?
> >
> 
> I think it found a few things here and there. Requeueing had a
> couple of bugs, and I think a couple of things turned up back when
> AS was a new concept to the block layer.
> 
> I think it is useful to try to enforce a coherent usage of the block
> interface by drivers. For example, the IDE thing may have been a non
> issue, but you might imagine some io scheduler or future accounting
> (or something) in the block layer actually does need the request to
> go through elv_set_request / blk_init_request.
> 
> Up to you really. I'm going to rip the code out of as-iosched.c so
> I just thought it may still be useful for the block layer.

Some of the states are definitely useful (you mention requeue, that's
one of them) as it can screw up accounting. The merge checking isn't
very useful and the fact that you have to switch states around it just
indicates to me that it should be dropped.

Also doing the state switching with automatic checks for that transition
being valid would be cleaner, but probably also slower so...

-- 
Jens Axboe


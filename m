Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVJNGyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVJNGyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 02:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVJNGyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 02:54:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54869 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750839AbVJNGyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 02:54:02 -0400
Date: Fri, 14 Oct 2005 08:54:30 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: aviro@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: BLKSECTGET userland API breakage (2.4 and 2.6 incompatible)
Message-ID: <20051014065430.GQ6603@suse.de>
References: <20051013234934.GB6711@devserv.devel.redhat.com> <20051013.210615.81985793.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013.210615.81985793.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2005, David S. Miller wrote:
> From: Alexander Viro <aviro@redhat.com>
> Date: Thu, 13 Oct 2005 19:49:34 -0400
> 
> > all 2.4:      BLKSECTGET takes long * and is supported by several block drivers
> > bio-14-pre9:  Takes BLKSECTGET to drivers/block/blkpg.c, defining it for all
> >               block drivers *AND* making it take unsigned short *
> > 2.5.1-pre2:   bio merge
> > all 2.[56] kernels since then: BLKSECTGET takes unsigned short *
> > 32bit compat: unchanged since 2.4 and thus broken on 2.[56]
> > applications: we have seen ones using 2.6 ABI and getting buggered in
> >               32bit compat.  Most likely there are some using 2.4 ABI...
> > 
> > IMO the least painful variant is to switch 2.6 compat code to match
> > 2.6 native (i.e. use COMPATIBLE_IOCTL()), leave 2.4 as-is and live
> > with the fact of userland ABI change between 2.4 and 2.6...
> 
> Well, what's the userland state and why in the world did this
> happen in the first place?

Given that this change happened over 4 years ago, I cannot remember the
details of it. But it wasn't a conscious decision to change it, must
have been an unfortunate typo when killing maxsectors[].

-- 
Jens Axboe


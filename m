Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268720AbUHaPVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268720AbUHaPVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268693AbUHaPVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:21:45 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:11398 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268724AbUHaPUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:20:38 -0400
Date: Tue, 31 Aug 2004 16:20:15 +0100
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DRM initial function table support.
Message-ID: <20040831152015.GC22978@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408311409530.18657@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408311409530.18657@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 02:11:11PM +0100, Dave Airlie wrote:

 > Okay this is the first driver function table patch for the DRM, something
 > similar has been running in DRM CVS for a month or so (underneath another
 > 5-10 patches removing all the rest of the macros..)

I like this. Lots.
Mostly because of this..

(16:14:11:davej@delerium:~)$ grep ^-# foo.diff  | wc -l
87

It's like someone revoked the drm folks preprocessor license 8-)

 > One thing we've discussed on dri-devel was changing the
 > if (dev->fn_tbl.function)
 >         dev->fn_tbl.function();
 > 
 > to something else but in future patches I've had slightly more complex
 > checks to do and this check looks to be the most obvious from a
 > readability point of view, if the driver supports the function call it..

Looks ok, and pretty much matches similar conventions used in other
parts of the kernel.

 > The other option was to use default noop fns, this also caused issues
 > later on with some places where the code did more than just call the
 > function..
 > 
 > So please any comments on it?

One thing that would make things even nicer would be..

instead of this..

 > +void gamma_driver_register_fns(drm_device_t *dev)
 > +{
 > +	dev->fn_tbl.preinit = gamma_driver_preinit;
 > +	dev->fn_tbl.pretakedown = gamma_driver_pretakedown;
 > +	dev->fn_tbl.dma_ready = gamma_driver_dma_ready;
 > +	dev->fn_tbl.dma_quiescent = gamma_driver_dma_quiescent;
 > +	dev->fn_tbl.dma_flush_block_and_flush = gamma_flush_block_and_flush;
 > +	dev->fn_tbl.dma_flush_unblock = gamma_flush_unblock;
 > +}

having a per-driver struct with regular C99 initialisers..

struct gamma_driver_fntbl {
	.preinit = gamma_driver_preinit,
	.pretakedown = gamma_driver_pretakedown,
	.dma_ready = gamma_driver_dma_ready,
	.dma_quiescent = gamma_driver_dma_quiescent,
	.dma_flush_block_and_flush = gamma_flush_block_and_flush,
	.dma_flush_unblock = gamma_flush_unblock,
};

Thanks for doing this work, it really is starting to look a little more
like a Linux driver 8-)

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967860AbWK3Smz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967860AbWK3Smz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 13:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967861AbWK3Smz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 13:42:55 -0500
Received: from brick.kernel.dk ([62.242.22.158]:3844 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S967860AbWK3Smy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 13:42:54 -0500
Date: Thu, 30 Nov 2006 19:43:18 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Pavel Machek <pavel@ucw.cz>, Christoph Schmid <chris@schlagmichtod.de>,
       linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Message-ID: <20061130184317.GX5400@kernel.dk>
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it> <7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5783fms.fsf@denkblock.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27 2006, Elias Oltmanns wrote:
> Jens Axboe <jens.axboe@oracle.com> wrote:
> > On Tue, Nov 21 2006, Pavel Machek wrote:
> >> Hi!
> >> 
> [...]
> >> > After some googeling and digging in gamne i read that someone said that
> >> > there are plans for some generic support for HD-parking in the kernel
> >> > and thus making such patches obsolete.
> [...]
> >> I'm afraid we need your help with development here. Porting old patch
> >> to 2.6.19-rc6 should be easy, and then you can start 'how do I
> >> makethis generic' debate.
> >
> > 2.6.19 will finally have the generic block layer commands, so this can
> > be implemented properly.
> 
> Eventually, I've ported the patch to 2.6.19-rc6 (attached). However,
> I'll need some gentle guidance by you developers for the next steps,
> I'm afraid. What exactly do you mean by "making this generic".
> Perhaps, you could give me a hint as to which generic block layer
> commands you have in mind that should be used in such a patch.

If you look in <linux/blkdev.h>, you can see the definition of
REQ_TYPE_LINUX_BLOCK and the current sub commands (none are implemented
right now). So you want to add REQ_LB_OPT_PARK (or whatever the name
should be) to implement the freezing operation, and then add support for
the drivers to understand this command and do what they need to do. You
can add block layer helpers to perform the freezing of the actual queue,
to be called when the PARK command completes. You can handle the queue
draining for tagged devices like the barriers do for FUA barriers.


-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbUJYVNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUJYVNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUJYVJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:09:43 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33232 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262010AbUJYVAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:00:09 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 25 Oct 2004 22:53:07 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv hang problem on 2.6.8
Message-ID: <20041025205306.GA3127@bytesex>
References: <20041025150349.GA22915@xi.wantstofly.org> <20041025151841.GA10042@bytesex> <20041025160145.GA23760@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025160145.GA23760@xi.wantstofly.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:01:45PM +0200, Lennert Buytenhek wrote:
> On Mon, Oct 25, 2004 at 05:18:41PM +0200, Gerd Knorr wrote:
> 
> > > When there is a background thread doing VIDIOCSYNC in a loop, issuing
> > > VIDIOCSPICT in the current thread on the same file descriptor causes
> > > it to go into uninterruptable sleep and hang.  This is on kernel 2.6.8
> > > using the bttv driver, and appears easily reproducible.
> > 
> > Don't do that.  bttv serializes ioctls with a lock.  Well, not all of
> > them, but the ones which change the state of the filehandle, and both
> > VIDIOCSYNC + VIDIOCSPICT fall into that group.  You simply can't run
> > them in parallel on the same filehandle.
> 
> OK, even though it worked fine on 2.4 I'll buy that, but it still
> shouldn't result in an unkillable process, should it?

Does it?  That wasn't clear.  One of the two threads (the one waiting
for the lock, probably the one doing VIDIOCSPICT) might be unkillable.
Try killing the other thread as well, that should work.  If it doesn't
I'd like to get stack traces for the deadlock case (sysrq-t).

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)

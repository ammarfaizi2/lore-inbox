Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWCIQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWCIQJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWCIQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:09:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751269AbWCIQJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:09:27 -0500
Date: Thu, 9 Mar 2006 08:08:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <44104EB7.9090103@mbligh.org>
Message-ID: <Pine.LNX.4.64.0603090802350.18022@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com>
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
 <200603062124.42223.jesper.juhl@gmail.com> <20060306203036.GQ4595@suse.de>
 <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com>
 <20060306215515.GE11565@redhat.com> <44104EB7.9090103@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, Martin J. Bligh wrote:
> > 
> > DEBUG_PAGEALLOC in particular is *fantastic* at making bugs hide.
> > I've lost many an hour trying to pin bugs down due to that.
> 
> Is this backwards? We're saying DEBUG_PAGEALLOC is bad?

DEBUG_PAGEALLOC is great for finding the really stupid kinds of bugs, and 
it's definitely worth doing every once in a while.

However, DEBUG_PAGEALLOC makes many things orders of magnitude slower, and 
it eats memory like mad (because it turns some slabs into whole pages - 
but it still doesn't help small allocation debugging that much). So unlike 
DEBUG_SLAB, it's not reasonable to have it on all the time.

IOW, DEBUG_SLAB is something that a distro kernel can reasonably enable 
for users by default (I think fedora-devel does, for example). In 
contrast, DEBUG_PAGEALLOC is more of a "useful for special cases" thing, 
where you want to validate that there's nothing _obviously_ bad going on.

> Do we NOT want to have DEBUG_SLAB and DEBUG_PAGEALLOC both enabled?

I suspect that once DEBUG_PAGEALLOC is on, whether you do DEBUG_SLAB or 
not is a toss-up. The interesting cases tend to be

 - neither: usable for benchmarking
 - DEBUG_SLAB: perfectly usable for normal work
 - DEBUG_PAGEALLOC (with or without DEBUG_SLAB): debugging tool only

At least that's my opinion, maybe others have other experiences.

			Linus

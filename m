Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTJWQQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 12:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTJWQQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 12:16:36 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:26520 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S263627AbTJWQQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 12:16:34 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide write barrier support
Date: Thu, 23 Oct 2003 18:22:36 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031013140858.GU1107@suse.de> <200310210146.35881.phillips@arcor.de> <20031021054044.GC1128@suse.de>
In-Reply-To: <20031021054044.GC1128@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310231822.36023.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 October 2003 07:40, Jens Axboe wrote:
> On Tue, Oct 21 2003, Daniel Phillips wrote:
> > Maybe what you're saying is, there are only two ways to deal with IDE
> > drives with non-disablable writeback cache:
> >
> >   1) flush the cache on every write
> >   2) Implement write barriers, add them to all the journalling
> > filesystems, and flush only on the write barrier
> >
> > and (1) is just too slow.  Correct?
>
> Yes, that is exactly what I'm saying. It's not just that, though.
> Completely disabling write back caching on IDE drives totally kills
> performance typically, they are just not meant to be driven this way.

OK, this is still experimental development in the middle of the stability 
freeze in order to fix a performance bug, but that's a tradition anyway so 
let me join in.

I'm specifically interested in working out the issues related to stacked 
virtual devices, and there are many.  Let me start with an easy one.

Consider a multipath virtual device that is doing load balancing and wants to 
handle write barriers efficiently, not just allow the downstream queues to 
drain before allowing new writes.  This device wants to send a write barrier 
to each of the downstream devices, however, we have only one write request to 
carry the barrier bit.  How do you recommend handling this situation?

Regards,

Daniel


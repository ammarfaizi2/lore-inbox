Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTJWRTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 13:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTJWRTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 13:19:39 -0400
Received: from hockin.org ([66.35.79.110]:27908 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261815AbTJWRTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 13:19:38 -0400
Date: Thu, 23 Oct 2003 10:09:42 -0700
From: Tim Hockin <thockin@hockin.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Ian Kent <raven@themaw.net>, Ingo Oeser <ioe-lkml@rameria.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
Message-ID: <20031023170942.GA2895@hockin.org>
References: <Pine.LNX.4.44.0310232127520.2983-100000@raven.themaw.net> <3F980949.1040201@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F980949.1040201@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 01:00:57PM -0400, Mike Waychison wrote:
> >Would a GFP_ATOMIC make a difference to the analysis?
 
> Yes, sleeping within a spinlock is bad practice because it may 
> eventually deadlock.  Pretend that the lock is taken, the call to 
> kmalloc is made, the mm system doesn't have any immidiately free memory 
> and through some flow of execution requires that a some pseudo-block 
> device backed filesystem needs to be mounted -> deadlock.  I have no 
> idea if this is currently a likely scenario, however not sleeping within 
> a lock is 'The Right Thing' and should be avoided at all costs. 

it's worse than that.  It's forbidden.  It's a VERY likely deadlock scenario
in the general sense, even if this particular case is not.  If you need to
lock something and you need to sleep holding that lock, use a semaphore.

-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?


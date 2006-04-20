Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWDTVhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWDTVhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWDTVhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:37:19 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:4255 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751337AbWDTVhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:37:17 -0400
Subject: Re: Linux 2.6.17-rc2
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Jens Axboe <axboe@suse.de>
Cc: Piet Delaney <piet@bluelane.com>, "David S. Miller" <davem@davemloft.net>,
       torvalds@osdl.org, diegocg@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060420193430.GH4717@suse.de>
References: <20060419200001.fe2385f4.diegocg@gmail.com>
	 <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
	 <20060420145041.GE4717@suse.de>
	 <20060420.122647.03915644.davem@davemloft.net>
	 <20060420193430.GH4717@suse.de>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Thu, 20 Apr 2006 14:37:11 -0700
Message-Id: <1145569031.25127.64.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2006 21:37:15.0106 (UTC) FILETIME=[9746A420:01C664C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 21:34 +0200, Jens Axboe wrote:

> > Anyways, I'm just stabbing in the dark.  It would be useful, because
> > there is no real clan way to use sendfile() for zero copy of anonymous
> > user data, and this vmsplice() thing seems like it could bridge that
> > gap if we do it right.
> 
> It should be able to, yes. Seems to me it should just work like regular
> splicing, with the difference that you'd have to wait for the reference
> count to drop before reusing. One way would be to do as Linus suggests
> and make the vmsplice call block or just return -EAGAIN if we are not
> ready yet. With that pollable, that should suffice?

What about marking the pages Read-Only while it's being used by the
kernel and if the user tries to write into them letting the VM dup 
the page with the COW code? Often you can use a FILO memory allocator 
in user space to minimize the odds of trying to reuse the page while 
the kernel is using it.

FreeBSD folks developed a ZERO_COPY_SOCKET facility that uses COW; 
code looked great.

-piet

-- 
---
piet@bluelane.com


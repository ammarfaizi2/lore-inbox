Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWCGBfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCGBfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWCGBfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:35:20 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:2024 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751230AbWCGBfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:35:19 -0500
Message-ID: <440CE336.3080504@cfl.rr.com>
Date: Mon, 06 Mar 2006 20:34:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bcrl@kvack.org, drepper@gmail.com, da-x@monatomic.org,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
References: <20060306211854.GM20768@kvack.org> <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com> <20060306233300.GR20768@kvack.org> <20060306.162444.107249907.davem@davemloft.net>
In-Reply-To: <20060306.162444.107249907.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> 
> I think something like net channels will be more effective on receive.
> 

What is this "net channels"?  I'll do some googling but if you have a 
direct reference it would be helpful.

> We shouldn't be designing things for the old and inefficient world
> where the work is done in software and hardware interrupt context, it
> should be moved as close as possible to the compute entities and that
> means putting the work all the way into the app itself, if not very
> close.
> 
> To me, it is not a matter of if we put the networking stack at least
> partially into some userland library, but when.
> 

Maybe you should try using a microkernel then like mach?  The Linux way 
of doing things is to leave critical services that most user mode code 
depends on, such as filesystems and the network stack, in the kernel.  I 
don't think that's going to change.

> Eveyone has their brains wrapped around how OS support for networking
> has always been done, and assuming that particular model is erroneous
> (and net channels show good hard evidence that it is) this continued
> thought process merely continues the error.
> 

Have you taken a look at bsd's kqueue and NT's IO completion port 
approach?  They allow virtually all of the IO to be offloaded to 
hardware DMA, and there's no reason Linux can't do the same with aio and 
O_DIRECT.  There's no need completely throw out the stack and start 
over, let alone in user mode, to get there.

> I really dislike it when non-networking people work on these
> interfaces.  They've all frankly stunk, and they've had several
> opportunities to try and get it right.
> 

I agree, the old (non) blocking IO style interfaces have all sucked, 
which is why it's time to move on to aio.  NT has been demonstrating for 
10 years now ( that's how long ago I wrote an FTPd using IOCPs on NT ) 
the benefits of async IO.  It has been a long time coming, but once the 
Linux kernel is capable of zero copy aio, I will be quite happy.

> I want a bonafide networking person to work on any high performance
> networking API we every decide to actually use.
> 
> This is why I going to sit and wait patiently for Van Jacobson's work
> to get published and mature, because it's the only light in the tunnel
> since Multics.
> 
> Yes, since Multics, that's how bad the existing models for doing these
> things are.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWCGAr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWCGAr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWCGAr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:47:56 -0500
Received: from kanga.kvack.org ([66.96.29.28]:8131 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932536AbWCGAr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:47:56 -0500
Date: Mon, 6 Mar 2006 19:42:37 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: drepper@gmail.com, da-x@monatomic.org, linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
Message-ID: <20060307004237.GT20768@kvack.org>
References: <20060306211854.GM20768@kvack.org> <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com> <20060306233300.GR20768@kvack.org> <20060306.162444.107249907.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306.162444.107249907.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 04:24:44PM -0800, David S. Miller wrote:
> > Oh?  I've always envisioned that network AIO would be able to use O_DIRECT 
> > style zero copy transmit, and something like I/O AT on the receive side.  
> > The in kernel API provides a lightweight event mechanism that should work 
> > ideally for this purpose.
> 
> I think something like net channels will be more effective on receive.

Perhaps, but we don't necessarily have to go to that extreme to get the 
value of the approach.  One way of doing network receive that would let 
us keep the same userland API is to have the kernel perform the receive 
portion of TCP processing in userspace as a vsyscall.  The whole channel 
would then be a concept internal to the kernel.  Once that works and the 
internals have settled down, it might make sense to export an API that 
allows us to expose parts of the channel to the user.

Unfortunately, I think that the problem of getting the packets delivered 
to the right user is Hard (especially with incoming filters and all the 
other features of the stack).

...
> I want a bonafide networking person to work on any high performance
> networking API we every decide to actually use.

I'm open to suggestions. =-)  So far my thoughts have mostly been limited 
to how to make tx faster, at which point you have to go into the kernel 
somehow to deal with the virtual => physical address translation (be it 
with a locked buffer or whatever) and kicking the hardware.  Rx has been 
much less interesting simply because the hardware side doesn't offer as 
much.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.

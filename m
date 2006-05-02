Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWEBEMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWEBEMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 00:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWEBEMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 00:12:53 -0400
Received: from wilma.widomaker.com ([204.17.220.5]:62471 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S932361AbWEBEMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 00:12:52 -0400
Date: Tue, 2 May 2006 00:12:18 -0400
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
Message-ID: <20060502041218.GA5691@widomaker.com>
References: <1143510828.1792.353.camel@mindpipe> <20060327195905.7f666cb5.akpm@osdl.org> <20060405144716.GA10353@widomaker.com> <44342CE2.208@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44342CE2.208@tmr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, 05 Apr 2006 @ 16:47 -0400, Bill Davidsen said:

Sorry for the late reply, and if this is a duplicate.

> >I shouldn't be suffering from swap storms.
> 
> Agreed, does meminfo show that you are? 

meminfo?

procinfo and other tools show a lot swapping, if that's what you mean, and you
can see it in disk I/O to the swap drives as well.

> The reason I ask is that I have noted that large memory machines and CD/DVD
> image writing suffer from some interesting disk write patterns. The image
> being built gets cached but not written, then the file is closed. At some
> point the kernel notices several GB of old unwritten data and decides to
> write it. This makes everything pretty slow for a while, even if you have
> 100MB/s disk system.

I see that kind of behavior quite a lot. Not just for DVD/CD images either.
Basically any large data processing fills memory with cached file data at the
expense of other programs and data.

> In theory you should be able to tune this, but in practice I see what
> you do. On small memory machines it's less noticable, oddly.

I tried putting swapiness down to 30. It helped, most of the time, but still
I saw way too much useless file data being cached.

I would personally rather just limit how much file data can be cached. I don't
mind agressive swapping, I just hate seeing a ton of file data being cached
that isn't going to be used again.

I'm also trying the ck kernels just to see how they run. So far they work
better.

-- 
shannon "AT" widomaker.com -- ["All of us get lost in the darkness,
dreamers turn to look at the stars" -- Rush ]

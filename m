Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbUK0ESp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbUK0ESp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUK0EF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:05:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262290AbUKZTUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:20:49 -0500
Date: Fri, 26 Nov 2004 15:54:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041126155443.GA9341@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <1101455756.4343.106.camel@desktop.cunninghams> <20041126123847.GD1028@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041126123847.GD1028@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 01:38:48PM +0100, Pavel Machek wrote:
> > Again, when you're running on limited time, twice as fast is still twice
> > as fast.
> 
> My machine suspends in 7 seconds, and that's swsusp1. According to
> your numbers, suspend2 should suspend it in 1 second and LZE
> compressed should be .5 second.
> 
> I'd say "who cares". 7 seconds seems like fast enough for me. And I'm
> *not* going to add 2000 lines of code for 500msec speedup during
> suspend.

Yupp.  Premature optimization is the roo of all evil.  swsusp is

 a) an absolute slowpath compared to any normal kernel operation,
    and called extremly seldomly
 b) only usefull for a small subset of all linux instances

hacking core code (fastpathes) for speedups there is a really bad idea.
If you can speed it up without beeing intrusive all power to you.

> > I'm trying not to make assumptions about how we're writing the image,
> > either. If you want to pipe your image over a network to some server,
> > you should be able to, and not have to implement compression again in
> > the writer for that.
> 
> Suspend-over-network is obscure-enough
> feature. Compressed-suspend-over-network is even worse.
> 
> BTW my feeling is that if you want to do suspend-over-network, you
> should just modify nbd to work with suspend2 and stop adding
> special-purpose code to suspend.

Honestly I think it's a feature so obscure that we wouldn't ever want to
merge it unless it just happens to work as a fallout of a more important
feature.


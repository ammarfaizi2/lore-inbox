Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUIZSje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUIZSje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 14:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUIZSje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 14:39:34 -0400
Received: from gprs214-244.eurotel.cz ([160.218.214.244]:47488 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261724AbUIZSjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 14:39:32 -0400
Date: Sun, 26 Sep 2004 20:39:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Kevin Fenzi <kevin@scrye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040926183915.GD28810@elf.ucw.cz>
References: <20040924021956.98FB5A315A@voldemort.scrye.com> <20040924143714.GA826@openzaurus.ucw.cz> <20040924210958.A3C5AA2073@voldemort.scrye.com> <1096069216.3591.16.camel@desktop.cunninghams> <20040925014546.200828E71E@voldemort.scrye.com> <1096113235.5937.3.camel@desktop.cunninghams> <20040926161816.GA27702@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926161816.GA27702@logos.cnet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > What causes memory to be so fragmented? 
> > 
> > Normal usage; the pattern of pages being freed and allocated inevitably
> > leads to fragmentation. The buddy allocator does a good job of
> > minimising it, but what is really needed is a run-time defragmenter. I
> > saw mention of this recently, but it's probably not that practical to
> > implement IMHO.
> 
> I think it is possible to have a defragmenter: allocate new page, 
> invalidate mapped pte's, invalidate radix tree entry (and block radix lookups),`
> copy data from oldpage to newpage, remap pte's, insert radix tree
> entry, free oldpage.
> 
> The memory hotplug patches do it - I'm trying to implement a similar version
> to free physically nearby pages and form high order pages.

Well, swsusp is kind of special case. If it is possible to swap that
page out or discard, it is swapped out/discarded already. What remains
are things like kmalloc(), and you can't move them...

Anyway solution for swsusp is to avoid using such big pages, it is
less complex than doing defragmenter.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

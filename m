Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbUKZXTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbUKZXTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbUKZTsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:48:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61890 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262385AbUKZT0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:26:46 -0500
Date: Fri, 26 Nov 2004 14:31:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041126133115.GB1687@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <20041126043203.GA2713@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041126043203.GA2713@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ok, I got it.  I think making LRU safe must sure 
>  1: LRU can't change after saved.
>  2: LRU memory can't change after saved.
> The first one is done, the second we can't sure in current design, can
> we using COW do it?

Userspace processes should be stopped at that point, and you really
can't do COW to kernel users.

> > swsusp1 is more self-contained. As long as drivers stop the DMA and
> > NMI does nothing wrong, atomic snapshot will indeed be atomic.
> Here is my current patch still relative with your bit diff, only core
> part here.
>  1: adding a collide bitmap for speedup collide check, I can't sure
>     four pages is enough, pavel please check.
>  2: swith list_for_xxx style
>  3: corrent calc_nums.

Heh, can you try this after resume?

cat `cat [0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null

It should have very similar effect to saving LRU, just in one line of
code ;-).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

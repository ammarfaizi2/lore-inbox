Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbUK3KVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbUK3KVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 05:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbUK3KVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 05:21:09 -0500
Received: from gprs214-203.eurotel.cz ([160.218.214.203]:34944 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262032AbUK3KVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 05:21:07 -0500
Date: Tue, 30 Nov 2004 11:19:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041130101947.GA1057@elf.ucw.cz>
References: <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <1101455756.4343.106.camel@desktop.cunninghams> <20041126123847.GD1028@elf.ucw.cz> <1101680972.4343.300.camel@desktop.cunninghams> <20041128235530.GB2856@elf.ucw.cz> <1101698428.4343.336.camel@desktop.cunninghams> <20041129130336.GC3291@elf.ucw.cz> <1101767970.4343.446.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101767970.4343.446.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm not sure if I want to do full page-cache saving (and without that,
> > half-of-memory limit does not bite too badly). "Everything is swapped
> > out" problem is actually not limited to swsusp, updatedb overnight
> > tends to have the same effect. Perhaps more generic solution is
> > needed...
> 
> Would increases in the amount of memory machines have make this bite
> more and more over time?

Actually, it should bite less and less, because ammount of memory
actually used does not seem to grow as fast as ammount of memory
available. On 4MB machine, I could imagine kernel using >2MB memory
and "half-memory-free" trick not working at all. On 1GB
machine... well kernel will never use >512MB of memory, so we are safe. 

> I guess the more generic solution would be to abandon using bio calls
> and have your own device driver that could write the whole image to disk
> without having to do the atomic copy. You'd have to write a lot of
> support for drivers, though. I'd find it hard to imagine it being worth
> the effort.

That would mean rewriting half of kernel.

> > cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null
> 
> What does this do?

Attempts to load all the binaries into memory. Poor man's "make
machine responsive after swsusp".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268090AbTB1Ssy>; Fri, 28 Feb 2003 13:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268096AbTB1Ssy>; Fri, 28 Feb 2003 13:48:54 -0500
Received: from ns.suse.de ([213.95.15.193]:43013 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268090AbTB1Ssv>;
	Fri, 28 Feb 2003 13:48:51 -0500
Date: Fri, 28 Feb 2003 19:59:10 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       lse-tech@projects.sourceforge.net
Subject: Re: [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030228185910.GA5694@wotan.suse.de>
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <Pine.LNX.4.44.0302281039570.3177-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302281039570.3177-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 10:47:38AM -0800, Linus Torvalds wrote:
> Right now the dcache hash is often something like 17 bits - and we could
> easily make it so that roughly "half" the bits would be based purely on
> the directory. That would still give each directory ~8 bits worth of
> "local hashing", which is fairly reasonable.

Ok I will see if that helps.
> 
> > I believe my patch with a bit more tweaking (my current 64K hash table
> > seems to be too small) is suitable even for an soon to be stable
> > kernel.
> 
> Quite frankly, right now the only report I've seen about your patch is 
> that it made things slightly _slower_.

Actually that's not quite true. The report had a completely different
profile (lots of other functions had different percentages), so it likely
wasn't a comparable workload. I also don't think the NUMAQs are a good test
platform for this because they have 2MB of fast cache per CPU, while
the typical linux multiprocessor machine has much less. Yes you can 
fit an 1MB hash table into a 2 MB cache....

I'll generate some new numbers here locally over the weekend on P4,
but I only have a dual to test on and see how it performs.

-Andi

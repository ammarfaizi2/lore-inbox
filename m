Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUKNLQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUKNLQC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 06:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUKNLQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 06:16:02 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:31241 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261284AbUKNLP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 06:15:56 -0500
Date: Sun, 14 Nov 2004 12:15:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] __init in mm/slab.c
Message-ID: <20041114111551.GA8680@pclin040.win.tue.nl>
References: <E1CTDXF-0006mU-00@bkwatch.colorfullife.com> <419714B8.3030804@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419714B8.3030804@colorfullife.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 09:18:00AM +0100, Manfred Spraul wrote:

> g_cpucache_up is NONE during bootstrap and FULL after boot. Thus the 
> initarray is never accessed after boot.
> 
> Andries, why did you propose this change? Does the current code trigger 
> an automatic test?

Yes. I was a bit more explicit in the timer patch:

"The i386 timers use a struct timer_opts that has a field init
pointing at a __init function. The rest of the struct is not __init.
Nothing is wrong, but if we want to avoid having references to init stuff
in non-init sections, some reshuffling is needed."

So yesterday's series of __init patches is not because there were
bugs, but because it is desirable to have the situation where
static inspection of the object code shows absence of references
to .init stuff. Much better than having to reason that there is
a reference but that it will not be used.

Where the memory win is important the code should be rewritten a bit.

Andries

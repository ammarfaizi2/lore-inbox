Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263371AbVCEAHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbVCEAHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbVCEAEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:04:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26053 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263371AbVCDW4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:56:20 -0500
Date: Fri, 4 Mar 2005 23:55:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, mjg59@scrf.ucam.org, hare@suse.de,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: allow resume from initramfs
Message-ID: <20050304225556.GA2647@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz> <20050304030410.3bc5d4dc.akpm@osdl.org> <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net> <1109971327.3772.280.camel@desktop.cunningham.myip.net.au> <20050304214329.GD2385@elf.ucw.cz> <1109973035.3772.291.camel@desktop.cunningham.myip.net.au> <20050304220709.GE2385@elf.ucw.cz> <1109975474.3772.305.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109975474.3772.305.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hmm, bitmaps? Okay, then low-level code needs to stay separate. (And
> > thats bad, I wanted that one to be shared most).
> 
> Mmm. As you might remember, I used extents from 1.0 to save space. The
> feedback from the last submission to LKML about getting rid of the
> page_alloc.c hooks made me re-examine the use of the memory pool, which
> made me re-examine the format in which the data was stored. Switching to
> bitmaps meant that after saving the LRU pages, I can recalculate what
> remains to be saved without ever changing the result in the process.
> (Using extents, there was a small chance that the recalculated metadata
> would require an extra extent on an extra page, which means you have to
> recalculate everything again :<. With discontiguous bitmaps, I get
> efficient storage, no need for > order zero allocations and no feedback
> whatsoever when recalculating image metadata. Besides removing the
> memory pool code, I've already removed some more, and am about to
> simplify the code for the remaining extents (for storage metadata). I
> hope to also be able to further simplify the image preparation code too.
> 
> All that to say "Bitmaps were a definite win!". Perhaps I can sell you
> on the advantages of using them :>

Not sure, if one bit goes wrong you put everything in the wrong places
:-). Linklist seems just okay to me, no > 4K allocations. I'm not sure
why recalculation is that big problem.

> By the way, did you see the effect of the memory eating patch? I didn't
> think about it until someone emailed me, but the improvement was 50x
> speed in the best case!

Well, more interesting was that you actually freed much more memory
with your patch. *You actually made memory freeing to work*. So yes, I
like that one.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

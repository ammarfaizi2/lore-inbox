Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSFEUT5>; Wed, 5 Jun 2002 16:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316372AbSFEUT4>; Wed, 5 Jun 2002 16:19:56 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13984 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316339AbSFEUTR>;
	Wed, 5 Jun 2002 16:19:17 -0400
Date: Wed, 5 Jun 2002 13:22:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/18] mark swapout pages PageWriteback()
Message-ID: <20020605112254.GA1567@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0205311559330.13043-100000@penguin.transmeta.com> <Pine.LNX.4.21.0206010649080.1316-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In short the same way MAP_ANON must pageout correctly, also MAP_SHARED
> > > must swapout correctly with very vm intensive conditions.
> 
> I strongly agree with Andrea on that.  Swap fault without page lock
> was a step forward, reinstating it in the light of observed degradation
> in one workload was right decision for that particular tail of release,
> but it's a shame to have stayed that way.
> 
> > That is true, but it is ignoring the fact that there _are_ real technical 
> > differences between swap cache mappings and regular shared mappings.
> > 
> > One major difference is the approach to the last user: a last use of a 
> > shared mapping still needs to write out dirty state, while the last use of 
> > a swap page is better off noticing that it should just optimize away the 
> > write, and we can just turn the page back into a dirty anonymous page.
> 
> Poor example: isn't last use of swap page just like last use of
> shared mapping of an _unlinked_ file?

Eh? Suppose I have two different shared mappings of (unlinked:3). It
may be last use of swap page in first mapping, but what prevents me
from seeking and trying to read what I wrote?
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

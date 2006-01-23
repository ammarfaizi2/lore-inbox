Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWAWRAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWAWRAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWAWRAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:00:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29839 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964813AbWAWRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:00:04 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       mtk-manpages@gmx.net
In-Reply-To: <20060123165415.GA32178@merlin.emma.line.org>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 18:00:02 +0100
Message-Id: <1138035602.2977.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > 4. Is the default hard limit of 32 kB initialized by the kernel or
> > 
> > the kernel has a relatively low default. The reason is simple: allow too
> > much mlock and the user can DoS the machine too easy. The kernel default
> > should be safe, the admin / distro can very easily override anyway.
> 
> This doesn't appear to happen for SUSE 10.0, which causes trouble with
> some of the "multimedia apps" BTW... apparently the limit was lowered at
> the same time as the root restrictions were relaxed.

yes the behavior is like this

                 root                non-root
before        about half of ram      nothing
after         all of ram             by default small, increasable


> Such changes in behavior aren't adequate for 2.6.X, there are way too
> many applications that can't be bothered to check the patchlevel of the
> kernel, and it's totally unintuitive to users, too. 

there is NO fundamental change here other than a *general* relaxing.
This is important to note: Apps that could mlock before STILL can mlock.
Only apps that would depend on mlock failing with a security check, and
only those who do small portions, break now because suddenly the mlock
succeeds. Big deal... those would have broken when run as root already

> No, I'm not doing that. I rather wonder why it's so low, or whom a certain
> percentage such as RAM >> 5 (that's 3.125 %) would hurt. A

because it's generally a PER PROCESS limit, so fork 60 times and kaboom
things explode. (You can argue  you can forkbomb anyway, but that's
where the process count rlimit comes in)

> Allowing
> unlimited memory allocation while at the same time allowing only 32 kB
> of mlock()ed memory seems disproportionate to me.

it's not. Normal memory is swapable. And thus a far less rare commodity
than precious pinned down memory.

What application do you have in mind that broke by this relaxing of
rules?




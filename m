Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWAWQy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWAWQy0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWAWQy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:54:26 -0500
Received: from mail.gmx.net ([213.165.64.21]:17305 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964804AbWAWQyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:54:25 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 17:54:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       mtk-manpages@gmx.net
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060123165415.GA32178@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	mtk-manpages@gmx.net
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138014312.2977.37.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Arjan van de Ven wrote:

> `
> > 
> > 1. What is the reason we're having special treatment
> >    for the super-user here?
> 
> it's quite common to allow root (or more specific, the right capability)
> to override rlimits. Many such security check behave that way so it's
> only "just" to treat this one like that as well.

Why is RLIMIT_MEMLOCK special enough to warrant special treatment like
this? The right capability should be able to override with setrlimit(2)
anyways, right?

> > 2. Why is it the opposite of what 2.6.8.1 and earlier did?
> 
> the earlier behavior didn't really make sense, and gave cause to
> multimedia apps running as root only to be able to mlock etc etc. Now
> this can be dynamically controlled instead.

Quoting the manpage: "In Linux kernels before 2.6.9, this limit
controlled the amount of memory that could be locked by a privileged
process."

This is nonsense, and it appears as though 2.6.8 and earlier didn't
apply the limit to unprivileged processes. Should the behavior stay as
inconsistent as it's now, I'd suggest to reword this to "...before
2.6.9, this limit controlled the amount of memory that could be locked
by /any/ process." or something even better if someone can think of
such. (manpages maintainer Cc'd)

> > 4. Is the default hard limit of 32 kB initialized by the kernel or
> 
> the kernel has a relatively low default. The reason is simple: allow too
> much mlock and the user can DoS the machine too easy. The kernel default
> should be safe, the admin / distro can very easily override anyway.

This doesn't appear to happen for SUSE 10.0, which causes trouble with
some of the "multimedia apps" BTW... apparently the limit was lowered at
the same time as the root restrictions were relaxed.

Such changes in behavior aren't adequate for 2.6.X, there are way too
many applications that can't be bothered to check the patchlevel of the
kernel, and it's totally unintuitive to users, too. Aside from the fact
that most distros have settled on one kernel.

> You may ask: why is it not zero?

No, I'm not doing that. I rather wonder why it's so low, or whom a certain
percentage such as RAM >> 5 (that's 3.125 %) would hurt. Allowing
unlimited memory allocation while at the same time allowing only 32 kB
of mlock()ed memory seems disproportionate to me.

-- 
Matthias Andree

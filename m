Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUKZXtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUKZXtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUKZTpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:45:36 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262434AbUKZT13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:29 -0500
Date: Fri, 26 Nov 2004 00:22:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message when suspending
Message-ID: <20041125232247.GH2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294838.5805.245.camel@desktop.cunninghams> <20041125181529.GE1417@openzaurus.ucw.cz> <1101419381.27250.38.camel@desktop.cunninghams> <20041125215641.GH2488@elf.ucw.cz> <1101422779.27250.102.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101422779.27250.102.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Agreed. I wasn't seriously suggesting changing everywhere to be
> > > GFP_NOWARN. Perhaps I should be more explicit in what I'm saying here.
> > > The problem isn't just suspend trying to allocate memory. It's
> > > _ANYTHING_ that might be running trying to allocate memory while we're
> > > eating memory. (Remember that we don't just call shrink_all_memory, but
> > > also allocate that memory so other processes don't grab it and stop us
> > > making forward progress). As a result, they're going to scream when they
> > > can't allocate a page.
> > 
> > Hmm, that does not look too healthy. That means that userland programs
> > will see all kinds of weird error conditions that normally
> > "almost-can't-happen" during normal usage.
> 
> Failure to allocate memory should be something any caller to get_*_page 
> deals with, so if they don't, are we to be blamed?

Well, you'll have things like select() returning -ENOMEM. Applications
will not be too happpy. We can probably live with that, but it is not
nice.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

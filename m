Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbUKZTzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbUKZTzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbUKZTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:54:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262476AbUKZTbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:14 -0500
Date: Thu, 25 Nov 2004 22:56:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message when suspending
Message-ID: <20041125215641.GH2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294838.5805.245.camel@desktop.cunninghams> <20041125181529.GE1417@openzaurus.ucw.cz> <1101419381.27250.38.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101419381.27250.38.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > While eating memory, we will potentially trigger this a lot. We
> > > therefore disable the message when suspending.
> > 
> > You should only trigger this while eating memory, so *one* GFP_NOWARN should be
> > enough. And shrink_all_memory should fix it anyway.
> 
> Agreed. I wasn't seriously suggesting changing everywhere to be
> GFP_NOWARN. Perhaps I should be more explicit in what I'm saying here.
> The problem isn't just suspend trying to allocate memory. It's
> _ANYTHING_ that might be running trying to allocate memory while we're
> eating memory. (Remember that we don't just call shrink_all_memory, but
> also allocate that memory so other processes don't grab it and stop us
> making forward progress). As a result, they're going to scream when they
> can't allocate a page.

Hmm, that does not look too healthy. That means that userland programs
will see all kinds of weird error conditions that normally
"almost-can't-happen" during normal usage.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

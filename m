Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751948AbWAFWYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWAFWYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbWAFWYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:24:24 -0500
Received: from iabervon.org ([66.92.72.58]:54794 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751948AbWAFWYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:24:23 -0500
Date: Fri, 6 Jan 2006 17:25:57 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
In-Reply-To: <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0601061705320.25300@iabervon.org>
References: <20060106173547.GR12131@stusta.de>
 <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Jesper Juhl wrote:

> On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> > Do not allow people to create configurations with CONFIG_BROKEN=y.
> >
> > The sole reason for CONFIG_BROKEN=y would be if you are working on
> > fixing a broken driver, but in this case editing the Kconfig file is
> > trivial.
> >
> > Never ever should a user enable CONFIG_BROKEN.
> >
> I disagree (slightly) with this patch for a few reasons:
> 
> - It's very convenient to be able to enable it through menuconfig.
> 
> - Being able to easily enable it in menuconfig, then browse through
> the menus to look for something matching your hardware is nice, even
> if that something is marked BROKEN at least you've then found a place
> to start working on. A lot simpler than digging through directories.

It might be nice if you could enable "show BROKEN" options, and have them 
appear in the list without being able to select them...

> - Some things marked BROKEN may not be 100% broken and may actually
> work for some specific things, so if you know that it works for your
> use, then being able to easily enable BROKEN and then whatever it is
> you need is nice.

But then you can accidentally enable something else that really is broken 
in the way you're going to use it. What you really want is to be able to 
override the BROKEN marking on individual options, not to override all 
BROKEN markings. Perhaps there should be a way to enable an option with 
unmet dependencies, such that the dependencies are treated as enabled for 
the purpose of building, but not for the purpose of making options that 
also depend on the same things available. This would also be nice for the 
case where you don't generally want EXPERIMENTAL drivers, but you do want 
a particular one that you've personally found to be stable.

	-Daniel
*This .sig left intentionally blank*

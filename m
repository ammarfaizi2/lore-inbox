Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVEBQdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVEBQdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEBQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:30:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:61670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbVEBQ3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:29:17 -0400
Date: Mon, 2 May 2005 09:31:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Andrea Arcangeli <andrea@suse.de>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <42764C0C.8030604@tmr.com>
Message-ID: <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
References: <20050429203959.GC21897@waste.org><20050429203959.GC21897@waste.org>
 <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 May 2005, Bill Davidsen wrote:
> > -#!/usr/bin/python
> > +#!/usr/bin/env python

> Could you explain why this is necessary or desirable? I looked at what 
> env does, and I am missing the point of duplicating bash normal 
> behaviour regarding definition of per-process environment entries.

It's not about environment.

It's about the fact that many people have things like python in
/usr/local/bin/python, because they compiled it themselves or similar.

Pretty much the only path you can _really_ depend on for #! stuff is 
/bin/sh.

Any system that doesn't have /bin/sh is so fucked up that it's not worth
worrying about. Anything else can be in /bin, /usr/bin or /usr/local/bin
(and sometimes other strange places).

That said, I think the /usr/bin/env trick is stupid too. It may be more 
portable for various Linux distributions, but if you want _true_ 
portability, you use /bin/sh, and you do something like

	#!/bin/sh
	exec perl perlscript.pl "$@"

instead.
		Linus

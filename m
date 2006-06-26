Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWFZRWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWFZRWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFZRWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:22:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23741 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbWFZRWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:22:08 -0400
Date: Mon, 26 Jun 2006 10:21:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, pavel@suse.cz
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
In-Reply-To: <20060626095702.8b23263d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org>
References: <1151060089.30819.2.camel@lappy> <20060626095702.8b23263d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jun 2006, Andrew Morton wrote:
> 
> AFAICS, the main downside of simply increasing MAX_ARG_PAGES is that
> fixed-size array in `struct linux_binprm'.  You've solved that via kmalloc,
> so can we avoid the sysctl?  We can now increase MAX_ARG_PAGES to something
> ridiculous with basically no cost?  It's swappable memory and should be
> limited by the RLIMIT_RSS which we don't implement ;)

It's _not_ swappable memory, sadly. It's swappable before it hits 
linux_binprm, and it's swappable after it's mapped into the destination, 
but it is _not_ swappable while it's held in the bprm->page[] array ;/

I totally re-organized how execve() allocates the new mm at an execve 
several years ago (it used to re-use the old MM if it could), and that was 
so that we count just remove the brpm->page array, and just install the 
pages directly into the destination.

That was in 2002. I never actually got around to doing it ;(.

		Linus

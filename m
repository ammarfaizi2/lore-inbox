Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVAMCaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVAMCaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 21:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVAMCaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 21:30:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:31944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261182AbVAMCaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 21:30:12 -0500
Date: Wed, 12 Jan 2005 18:28:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davej@redhat.com, marcelo.tosatti@cyclades.com, greg@kroah.com,
       chrisw@osdl.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-Id: <20050112182838.2aa7eec2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	<Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	<20050112185133.GA10687@kroah.com>
	<Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	<20050112161227.GF32024@logos.cnet>
	<Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	<20050112205350.GM24518@redhat.com>
	<Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Yes, I think delayed disclosure is broken. I think the whole notion of 
>  "vendor update available when disclosure happens" is nothing but vendor 
>  politics, and doesn't help _users_ one whit.
> ...
> 
>  So I think the whole vendor-sec thing is not helping users at all, it's 
>  purely a "vendor embarassment" thing. 

That sounds a bit over-the-top to me, sorry.

AFAIUI, the vendor requirement is that they have time to have an upgraded
kernel package on their servers when the bug becomes public knowledge.

If correct and reasonable, then what is the best way in which we can
support them in this while promptly upgrading the kernel.org kernel?


Also:

I think we need to be more explicit in separating _types_ of security
problems.  This recent controversy over the RLIM_MEMLOCK DoS is plain
silliness.

Look through the kernel changelogs for the past year - we've fixed a huge
number of "fix oops in foo" and "fix deadlock in bar" and "fix memory leak
in zot".  All of these are of exactly the same severity as the rlimit bug,
and nobody cares, nobody is hurt.

The fuss over the rlimit problem occurred simply because some external
organisation chose to make a fuss over it.

IMO, local DoS holes are important mainly because buggy userspace
applications allow remote users to get in and exploit them, and for that
reason we of course need to fix them up.  Even though such an attacker
could cripple the machine without exploiting such a hole.

For the above reasons I see no need to delay publication of local DoS holes
at all.  The only thing for which we need to provide special processing is
privilege escalation bugs.

Or am I missing something?

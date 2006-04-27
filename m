Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWD0DRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWD0DRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWD0DRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:17:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32951 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964906AbWD0DRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:17:53 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	 <1146105458.2885.37.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 04:17:51 +0100
Message-Id: <1146107871.2885.60.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 19:59 -0700, Linus Torvalds wrote:
> Linkages are bad. We _will_ break kernel headers for user space, and 
> that's just a undeniable fact.

Agreed. And distributions and library maintainers _will_ fix them. Are
we to deny those people the tools which will help them to keep track of
our breakage and submit patches to fix it?

The current situation is that they all go off and do their own thing to
work around it, instead of submitting those fixes. We need to do better
than that.

> If this is work to try to make kernel headers generally palatable to user 
> space, I'm not going to apply it at all. Not now, not early in the 2.6.18 
> sequence, not EVER. Because that's not a goal I believe in for a moment.

Kernel headers are never going to be generally palatable to user space.
That's always been clear, and it's a large part of the reason why we
wanted the 'export' step -- so that a _subset_ of headers could be
copied out for use by userspace, rather than a complete tarball as has
been used in the part.

> In contrast, if this is work to make it eventually _easier_ for _library_ 
> people to decide to upgrade their kernel-related information, I'm ok with 
> it. But that "target audience" part really is very very important. The 
> target audience should NOT be applications including kernel headers.
> 
> The target audience should be distributions and library maintainers. 

And those are the people I've been talking to over the last week or so.

All the distributions have their own hacks and patches and scripts which
mangle the kernel headers. Some from a vaguely current copy, some from a
copy which was forked years ago and kept vaguely up to date with
syscalls and new ioctls by hand. The results differ wildly from
distribution to distribution, and the end result for the _user_ is a
steaming inconsistent pile of crap.

What I'm trying to do here is centralise that process and let people
work on it together -- and yes, it still needs to go through
distributions and library maintainers. The point is not to go back to
making symlinks from /usr/include/{linux,asm} to the kernel directories
again -- that would be a retrograde step. The point is that distro and
library maintainers can work from what is provided by the kernel to
achieve a consistent and useful result.

That _is_ needed. It's a quality of implementation issue.

-- 
dwmw2


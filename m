Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUBTABH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267593AbUBTABH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:01:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:24960 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267592AbUBTABC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:01:02 -0500
Date: Fri, 20 Feb 2004 00:00:54 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Tridge <tridge@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040220000054.GA5590@mail.shareable.org>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org> <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The hardest part of caching is not filling the cache - it's knowing when 
> to release it. In other words, forget the filling part, and think about 
> the replacement policy (balacing between the page cache, the directory 
> cache, and regular pages). The kernel already has that.

It's worth noting that Samba already has a dcache in userspace: tridge
mentioned that positive cache-insensitive lookups are cached, so the
replacement policy is already skewed by that.

Will your proposal eliminate Samba's positive cache as well?

> Besides, I really think that we can do this with basically just a few 
> lines of code in the kernel (apart from the actual case comparison, which 
> I'm not even going to worry about - that's totally independent of the 
> cache handling itself, and I don't care about how to write a 
> "windows_equivalent_strncasecmp()".

What I like about my idea is that no windows_equivalent_strncasecmp()
needs to go into the kernel.  I.e. no need for a Samba-specific module.

The other thing I like is that DN_IGNORE_SELF would be useful for
other applications too.

What I like about your idea is that it'll be a bit faster, the dcache
replacement policy will be nicer, and if there are atomicity
conditions we haven't thought of, it'll be easier to handle them.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWDVUNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWDVUNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWDVUNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:13:15 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18633 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751136AbWDVUNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:13:13 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20060422093328.GM19754@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 13:03:03 +0100
Message-Id: <1145707384.16166.181.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 11:33 +0200, Adrian Bunk wrote:
> My thirst thought is:
> Is this really the best approach, or could this be done better?

I think it's the best way to start, although I agree with you entirely
about what we should strive for in the end.

> I'm currently more a fan of a separate kabi/ subdir with headers used by 
> both headers under linux/ and userspace.

I agree -- I'd like to see that too. But Linus doesn't like that
approach very much. 

> Unless I'm misunderstanding this, your changes are giving a result 
> identical result to simply using the current kernel headers (stripping 
> the #ifdef __KERNEL__ stuff doesn't change anything).

It's not quite the same. Some headers which just shouldn't be there at
all are removed -- and others can no longer be abused by defining
__KERNEL__ to get at stuff which shouldn't be there.

Also, if we have an 'exported' set of files which is supposed to be
clean, we can easily _see_ when there's stuff which shouldn't be there.
It makes the cleanup easier, by making the mess more obvious. We can
also take diffs of the output between one kernel and the next, applying
electric shocks as necessary, as you suggest later.

It's a small step, but it's the _first_ step towards the point we want
to reach, and it's something we're likely to get away with.

Ideally, I'd like to proceed by splitting files into user-visible and
kernel-private parts in _separate_ headers, so that the 'unifdef' part
becomes unnecessary (and __KERNEL__ disappears entirely). I've done some
of that already in include/mtd). It would also be nice if we could then
put the user-visible files into a separate directory, so that the
'headers_export' step becomes nothing more than a 'cp -a'. We do need to
do this incrementally though, and I think this is going to be the best
way to do it, and to get it accepted.

> Unless someone can tell me a reason why this wouldn't work (except for 
> being a bit more work than your approach), this is the approach I have 
> in mind for working on.

Your approach is basically what we proposed at last year's Kernel
Summit. It was shot down though, so we're trying to start simple and do
it incrementally. 

The important thing is that we all get our editors out and clean up the
_contents_ our own headers, and actually start to _think_ about the
visibility of any new header-file content we introduce. Let's not
concentrate too much on the implementation details of how we actually
get those to userspace.

-- 
dwmw2


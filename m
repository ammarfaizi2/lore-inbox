Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTIXEOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 00:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTIXEOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 00:14:42 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:31765 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261766AbTIXEOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 00:14:38 -0400
Date: Wed, 24 Sep 2003 00:12:51 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@suse.de>,
       <andrea@kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
In-Reply-To: <Pine.LNX.4.44.0309232051330.27940-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309240007040.17335-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003, Linus Torvalds wrote:

> Yeah, SunOS was nice. But I really think it's the access patterns that 
> changed.

Absolutely.  Garbage collection and object orientation have
obsoleted LRU and related algorithms.

Huge memory sizes also have done their share to obsolete
recency based replacement algorithms.

I suspect we'll want something closer to a frequency based
replacement scheme in the future. Possibly something like 
LIRS or ARC, but adapted to work in a general purpose OS in 
a very light weight way.

The argument that because we have more memory replacement
is no longer as important doesn't quite hold because the
cost of page replacement, measured in cpu cycles, has gone
completely through the roof in the last decades.

Then there's the whole different bag of cookies that is the
caching of filesystem metadata, like our inode and dentry
caches.  I'm not sure what would be a good replacement
strategy for those, but I do know that we'll want a good
algorithm here because hard disks (and the number of files
on them) are growing so much faster than anything else in
our computers...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


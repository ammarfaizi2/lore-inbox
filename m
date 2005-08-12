Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVHLQyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVHLQyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVHLQyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:54:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60899 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbVHLQyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:54:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference  between /dev/kmem and /dev/mem)
References: <1123796188.17269.127.camel@localhost.localdomain.suse.lists.linux.kernel>
	<1123809302.17269.139.camel@localhost.localdomain.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0508120930150.3295@g5.osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Aug 2005 18:54:49 +0200
In-Reply-To: <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org.suse.lists.linux.kernel>
Message-ID: <p73br432izq.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> 
> I'm actually more inclined to try to deprecate /dev/kmem.. I don't think 
> anybody has ever really used it except for some rootkits. 

I don't think that's true.
 
> So I'd be perfectly happy to fix this, but I'd be even happier if we made 
> the whole kmem thing a config variable (maybe even default it to "off").

Acessing vmalloc in /dev/mem would be pretty awkward. Yes it doesn't
also work in mmap of /dev/kmem, but at least in read/write.
There are quite a lot of scripts that use it for kernel debugging
like dumping variables. And for that you really want to access modules
and vmalloc. And it's much easier to parse than /proc/kcore

In fact I have some patches queued to fix it for x86-64 again
(people who used such scripts on i386 are complaining) 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbTLPE4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTLPE4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:56:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:16101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264971AbTLPE4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:56:36 -0500
Date: Mon, 15 Dec 2003 20:56:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Randolph Chung <randolph@tausq.org>
cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Re: Question about cache flushing and fork
In-Reply-To: <20031216044033.GT533@tausq.org>
Message-ID: <Pine.LNX.4.58.0312152049140.3345@home.osdl.org>
References: <20031216044033.GT533@tausq.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Randolph Chung wrote:
>
> Can someone please explain why it is necessary to flush the cache
> during fork()? (i.e. call to flush_cache_mm() in dup_mmap)

I don't know if it is strictly necessary - we might well be able to just
do the right thing in the page fault COW handler. But doing the cache
flush at fork time just means that we should never have a page that is
marked read-only but that may have dirty data in the virtual caches. That
could easily get confusing. In fact, I wouldn't be totally surprised if
some architecture refused to do write-backs through a read-only mapping.

But quite frankly, I suspect that since only a few CPU's have virtually
indexed caches, the cache-flush code hasn't gotten that much testing, and
there may be somewhat of an overkill approach there. As you found out,
it's not _that_ well documented.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUIKRMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUIKRMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIKRMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:12:37 -0400
Received: from [12.177.129.25] ([12.177.129.25]:49859 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268214AbUIKRMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:12:22 -0400
Date: Sat, 11 Sep 2004 14:15:50 -0400
From: Jeff Dike <jdike@addtoit.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/1] uml-update-2.6.8-finish
Message-ID: <20040911181550.GA2966@ccure.user-mode-linux.org>
References: <20040908173855.68F518D0B@zion.localdomain> <200409102028.54580.blaisorblade_personal@yahoo.it> <200409102103.i8AL3b0O004288@ccure.user-mode-linux.org> <200409111740.12121.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409111740.12121.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 05:40:12PM +0200, BlaisorBlade wrote:
> And making it compile with the hash code, rather than the rb_tree one? I know
> ghash.h must be removed, but there is no reason at all to switch to Red-Black
> trees. 

It is not just that ghash.h be removed.  It is that its contents have
to vanish.  That code shouldn't be anywhere.

There are good reasons to switch to rbtrees -
	I need some sort of low-O lookup
	there is no generic hash tree in the kernel
	rbtree is O(lg n) and it's generic
	rbtree is the only generic low-O lookup in the kernel that I see

I'm not in the fancy data structure business, so I'll stick with the
infrastructure that I find in the pool already, and rbtree is about it.

> Even because, later, we will just see "Hey, I get a panic here" + 
> backtrace. 

No, because currently there are no users of this.  We can get this tested
when UML starts mmapping into its page cache.

> Doing things right in first place is better.

And inlining the grunge is right?

				Jeff

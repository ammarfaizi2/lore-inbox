Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbTLVJgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 04:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTLVJgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 04:36:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:37258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264367AbTLVJgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 04:36:14 -0500
Date: Mon, 22 Dec 2003 01:36:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: atomic copy_from_user?
Message-Id: <20031222013613.7e0741f5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312212024230.6448@home.osdl.org>
References: <1072054100.1742.156.camel@cube>
	<Pine.LNX.4.58.0312212024230.6448@home.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> > From some naughty place in the code where might_sleep
>  > would trigger, I'd like to read from user memory.
>  > I'll pretty much assume that mlockall() has been
>  > called. Suppose that "current" is correct as well.
>  > I'd just use a pointer directly, except that:
>  > 
>  > a. it isn't OK for the 4g/4g feature, s390, or sparc64
>  > b. it causes the "sparse" type checker to complain
>  > c. it will oops or worse if the user screwed up
>  > 
>  > If the page is swapped out, I want a failed copy.
> 
>  the sequence
> 
>  	local_bh_disable();
>  	err = get_user(n, ptr);
>  	local_bh_enable();
>  	if (!err)
>  		.. 'n' .. was the value
> 
>  will do this in 2.6.x, except it will complain loudly about the unatomic 
>  access. Other than that, it will do what you ask for.

An explicit inc_preempt_count() would be clearer.  See how ia32's
kmap_atomic() does it.  And filemap_copy_from_user().



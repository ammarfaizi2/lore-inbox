Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTLVEbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 23:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLVEbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 23:31:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:37301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262522AbTLVEbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 23:31:43 -0500
Date: Sun, 21 Dec 2003 20:31:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atomic copy_from_user?
In-Reply-To: <1072054100.1742.156.camel@cube>
Message-ID: <Pine.LNX.4.58.0312212024230.6448@home.osdl.org>
References: <1072054100.1742.156.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Albert Cahalan wrote:
>
> Surely I'm not the only one wanting such a beast...?

I sure as hell hope you are.

> From some naughty place in the code where might_sleep
> would trigger, I'd like to read from user memory.
> I'll pretty much assume that mlockall() has been
> called. Suppose that "current" is correct as well.
> I'd just use a pointer directly, except that:
> 
> a. it isn't OK for the 4g/4g feature, s390, or sparc64
> b. it causes the "sparse" type checker to complain
> c. it will oops or worse if the user screwed up
> 
> If the page is swapped out, I want a failed copy.

the sequence

	local_bh_disable();
	err = get_user(n, ptr);
	local_bh_enable();
	if (!err)
		.. 'n' .. was the value

will do this in 2.6.x, except it will complain loudly about the unatomic 
access. Other than that, it will do what you ask for.

However, I'd still suggest not doing this. It's just broken. I don't see 
any real reason to do this except as a "test if the page is paged out" 
kind of thing..

			Linus

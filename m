Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUGHQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUGHQVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUGHQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:21:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:30628 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264538AbUGHQVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:21:38 -0400
Date: Thu, 8 Jul 2004 09:21:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Timothy Miller <miller@techsource.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <40ED71BC.2030609@techsource.com>
Message-ID: <Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <40ED71BC.2030609@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jul 2004, Timothy Miller wrote:
> 
> Not to be picky, and I realize that we're not using C++ here, and it may 
> not apply, but every C++ text I've read deprecates NULL and says to use 
> 0.  That is, THE WAY that you specify a null pointer in C++ is with a 
> zero.  It's no surprise that C programmers might pick up that habit.

It's a bad habit, and it's one (of many) bad things C++ does. The sad part 
is that C++ does it for all the wrong reasons - there's no reason to not 
realize that ((void *)0) is an even better special case, and indeed last I 
heard at least gcc does allow that in C++ too.

The fact is, when somebody else picks up a mistake, that doesn't make it 
any less of a mistake. And it's not like C++ is the paragon of good taste 
anyway.

I've seen too damn many people mistake NULL and NUL (admit it, you've seen 
it too), and I've seen code like

	char c = NULL;

and any system where that goes through without a warning is totally 
broken. And yes, that includes a _lot_ of C++ braindamages.

		Linus

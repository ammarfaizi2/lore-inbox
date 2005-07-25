Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVGYXOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVGYXOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVGYXOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:14:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261343AbVGYXNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:13:33 -0400
Date: Mon, 25 Jul 2005 16:13:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.13-rc3] i386: clean up user_mode macros
In-Reply-To: <200507251901_MC3-1-A589-A433@compuserve.com>
Message-ID: <Pine.LNX.4.58.0507251608430.6074@g5.osdl.org>
References: <200507251901_MC3-1-A589-A433@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Jul 2005, Chuck Ebbert wrote:
> 
> Recent patches from the Xen group changed the X86 user_mode macros.
> 
> This patch does the following:
> 
>         1. Makes the new user_mode() return 0 or 1 (same as x86_64)

I _really_ prefer

	x != 0

over 

	!!x

since double negation is not only a bad habit in natural languages, it's a 
bad habit in computer languages too, for exactly the same reason. It's 
confusing.

Ask a hundred random C programmers what "!!x" means, versus what "x != 0"
means, and time their replies.

I will bet you $5 USD that even if they all give the right answer (and I
suspect you'll get a few wrogn answers in there too for the !! case),
they'll take a _lot_ longer answering the "!!x" version than they will the 
"x != 0" question.

And guess what? That means that the "!!x" version is worse. It means that
people don't "see" what it means - they have to think about it. And you
shouldn't have to think about something like that, you should write it in 
the obvious way in the first place.

		Linus

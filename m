Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWFPGjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFPGjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWFPGjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:39:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWFPGjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:39:39 -0400
Date: Thu, 15 Jun 2006 23:39:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Goo GGooo <googgooo@gmail.com>
cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm2
In-Reply-To: <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> 
 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> 
 <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
 <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Jun 2006, Goo GGooo wrote:
> 
> Thanks for explanation. Unfortunately I can't use git:// with "git
> pull" (at least in git-1.3.2). First it does some traffic, that
> suddenly stops - I guess the server starts doing *something*, perhaps
> preparing the update for me or whatnot.

Yeah, for a big pull, the server will have to think about the objects it 
is going to send you.

> I suggest adding SO_KEEPALIVE option on the git socket.

Actually, the really irritating thing is that we actually generate all 
these nice status updates, which just makes pulling and cloning a lot more 
comfortable, because you actually see what is going on, and what to 
expect. 

Except they only work over ssh, where we have a separate channel (for 
stderr), and with the native git protocol all that nice status work just 
gets flushed to /dev/null :(

Dang. It's literally the most irritating part of the thing: the protocol 
itself is exactly the same whether you go over ssh:// or over git://, but 
that visual information about what is going on is missing, and it's 
surprisingly important from a usability standpoint.

And in your case, the usability downside actually turned into a real 
accessibility bug.

Oh, well.

		Linus

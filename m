Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWEJUpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWEJUpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWEJUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:45:22 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:48517 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964815AbWEJUpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:45:20 -0400
Date: Wed, 10 May 2006 16:44:51 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Message-ID: <Pine.LNX.4.58.0605101636580.22959@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> 
 <1147257266.17886.3.camel@localhost.localdomain> 
 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> 
 <1147273787.17886.46.camel@localhost.localdomain> 
 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> 
 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>  <20060510162404.GR3570@stusta.de>
  <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com>
 <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Daniel Walker wrote:

>
> There's no code increase when you init something to itself . I could
> convert all the instance of the warning, that I've investigated, to a
> system like this . I think it would be a benefit so we could clearly
> identify any new warnings added over time, and quiet the ones we know
> aren't real errors .
>
> However, from all the responses I'd imagine a patch like this wouldn't
> get accepted ..
>

I really don't see why it couldn't be added.  What's the problem with it?

I mean, I see lots of advantages, and really no disadvantages.

It can be done incrementally such that each change can be scrutinized to
make sure it really isn't a bug.

Once it is determined, not to be a bug, we add the macro to hide the
warning.  That way we lower the noise of warnings and look for places that
do have bugs.

It is a marker to let those, as Alan Cox suggested, look at them once in a
while to see if they are not really bugs.

Think about it.  If you get rid of all places that gcc incorrectly shows
something uninitialized, you can find the places that are truely bugs.
Once we get rid of all warnings, we can then turn off the macro to look
again to make sure none of them are problems.

The only disadvantage is that there's some macro wrapping a variable.  But
hell, that even was one of the advantages.  It's a marker that shows us
that gcc thinks it's not initialized properly.

And I already mentioned, that it wouldn't be too hard to see if any of the
marked variables no longer needs to be marked.

-- Steve


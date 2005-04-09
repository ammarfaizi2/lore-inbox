Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVDIAUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVDIAUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVDIAUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:20:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:39054 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261214AbVDIAUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:20:38 -0400
Date: Sat, 9 Apr 2005 02:23:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, zwane@arm.linux.org.uk, mingo@redhat.com,
       rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] silence spinlock/rwlock uninitialized break_lock member
 warnings
In-Reply-To: <20050408171026.5b822eeb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0504090218500.2455@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504090150520.2455@dragon.hyggekrogen.localhost>
 <20050408171026.5b822eeb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > Any chance this patch could be added to -mm (and possibly mainline)?
> 
> Spose I can stick it in -mm.
> 
> > It removes a bunch of warnings when building with gcc -W, like these:
> > include/linux/wait.h:82: warning: missing initializer
> > include/linux/wait.h:82: warning: (near initialization for `(anonymous).break_lock')
> > include/asm/rwsem.h:88: warning: missing initializer
> > include/asm/rwsem.h:88: warning: (near initialization for `(anonymous).break_lock')
> > so there's less to sift through when looking for real problems with this 
> > patch applied. 
> > I've been using it for a while with no ill effects.
> 
> But I'd rather not add a bunch of even-more-ifdefs to support a compiler
> flag which we're not going to use.  It's easy enough for the `gcc -W' user
> to add the patch himself.
> 
True, it's trivial to just add the patch when needed (aka building with 
-W), but the number of such patches add up and having them in the tree by 
default is less pain (for the -W user).  I'm not on a quest to make the 
tree -W clean, but I find -W useful to find the odd actual problem and a 
number of the warnings that -W spits out can be silenced without harm, 
those are the ones I aim to fix. But I see the point of not adding patches 
to make -W happy if it adds clutter for the non-W case, so I'll see if I 
can come up with a cleaner way to fix this case that will be more 
generally acceptable (perhaps Zwane's suggestion about using named 
initializers could result in something cleaner - I'll look at that)...


-- 
Jesper



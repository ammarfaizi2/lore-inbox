Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVDEUIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVDEUIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVDEUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:05:29 -0400
Received: from host201.dif.dk ([193.138.115.201]:36868 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261858AbVDEUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:00:04 -0400
Date: Tue, 5 Apr 2005 22:01:49 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roland Dreier <roland@topspin.com>
cc: Jesper Juhl <juhl-lkml@dif.dk>, Paulo Marques <pmarques@grupopie.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
In-Reply-To: <521x9pc9o6.fsf@topspin.com>
Message-ID: <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost>
References: <4252BC37.8030306@grupopie.com>
 <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost>
 <521x9pc9o6.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Roland Dreier wrote:

>     > or simply
>     > 	if (!(ptr = kcalloc(n, size, ...)))
>     > 		goto out;
>     > and save an additional line of screen realestate while you are at it...
> 
> No, please don't do that.  The general kernel style is to avoid
> assignments within conditionals.
> 
It may be the prefered style to avoid assignments in conditionals, but in 
that case we have a lot of cleanup to do. What I wrote above is quite 
common in the current tree - a simple  egrep -r "if\ *\(\!\(.+=" *  in 
2.6.12-rc2-mm1 will find you somewhere between 1000 and 2000 cases 
scattered all over the tree.

Personally I don't see why thy should not be used. They are short, not any 
harder to read (IMHO), save screen space & are quite common in userspace 
code as well (so people should be used to seeing them).

If such statements are generally frawned upon then I'd suggest an addition 
be made to Documentation/CodingStyle mentioning that fact, and I wonder if 
patches to clean up current users would be welcome?


-- 
Jesper Juhl


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVFPU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVFPU5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVFPU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:57:13 -0400
Received: from mail.dif.dk ([193.138.115.101]:16829 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261814AbVFPU5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:57:00 -0400
Date: Thu, 16 Jun 2005 23:02:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, davidm@hpl.hp.com, eranian@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in
 efi_range_is_wc()
In-Reply-To: <20050616134126.264d6bd5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0506162254480.2477@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
 <20050616134126.264d6bd5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > I send in the patch below a while back but never recieved any response.
> > Now I'm resending it in the hope that it might be added to -mm.
> 
> There are surely many warnings in the tree, hence I'm not really interested
> in patches which only fix `gcc -W' warnings.
> 

Ok, in that case I won't bother you directly with such patches any more 
but instead let them trickle into maintainers trees when they will take 
them.

And yes, I know it's very trivial stuff and it doesn't make much of a 
difference to the "big picture", but my attitude towards that is that no 
issue is too small to be addressed, and since I'm not able to adress many 
of the larger issues I try to address the smaller ones that I'm able to 
handle, and when I run out of those I start nitpicking with the really 
trivial stuff (like gcc -W warnings) - all with the purpose of helping our 
kernel be the very best it can, even if my contribution might be very 
minor in some cases.


> How many are there?
> 

With the .config I use here a regular build gives me 10 warnings. A build 
with gcc -W of the same config gives me 100177 warnings.


> > It looks to me like a significantly large 'len' passed in could cause the 
> > loop to never end. Isn't it safer to make 'i' an unsigned long as well? 
> 
> Nope.  All operations which mix signed and unsigned types promote the
> signed type to unsigned.
> 
Hmm, right, then the only bennefit of the patch as-is is to silence the 
gcc -W warning. But since it can be done 100% safe and the change to use 
an unsigned value for the counter is (at least to me) the logical and 
obviously correct thing to do, I still think the patch has merrit as a 
purely "for pedantic correctness" fix.


-- 
Jesper



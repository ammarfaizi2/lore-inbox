Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUJXKd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUJXKd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUJXKd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:33:59 -0400
Received: from mail.dif.dk ([193.138.115.101]:26756 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261430AbUJXKd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:33:57 -0400
Date: Sun, 24 Oct 2004 12:42:08 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][resend] small binfmt_elf warning fix (copy_from_user
 return value checking) (fwd)
In-Reply-To: <20041024030151.0c81df8f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410241232250.2919@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410240244050.25721@dragon.hygekrogen.localhost>
 <20041024030151.0c81df8f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> >  diff -up linux-2.6.9-rc3-bk5-orig/fs/binfmt_elf.c linux-2.6.9-rc3-bk5/fs/binfmt_elf.c
> >  --- linux-2.6.9-rc3-bk5-orig/fs/binfmt_elf.c	2004-09-30 05:04:32.000000000 +0200
> >  +++ linux-2.6.9-rc3-bk5/fs/binfmt_elf.c	2004-10-06 23:21:22.000000000 +0200
> >  @@ -1223,7 +1223,7 @@ static void fill_psinfo(struct elf_prpsi
> >   	len = mm->arg_end - mm->arg_start;
> >   	if (len >= ELF_PRARGSZ)
> >   		len = ELF_PRARGSZ-1;
> >  -	copy_from_user(&psinfo->pr_psargs,
> >  +	len -= copy_from_user(&psinfo->pr_psargs,
> >   		       (const char __user *)mm->arg_start, len);
> >   	for(i = 0; i < len; i++)
> >   		if (psinfo->pr_psargs[i] == 0)
> 
> It doesn't matter, really - we've already zeroed out the memory and will
> correctly handle any uncopied data.
> 
Yes, I know, it's mainly to shut up the warning in some resonable way. We 
may be saving a few loop iterations, but we'll be adding a subtraction, so 
performance wise it probably won't make any difference - but it's a very 
cold code path as far as I can see, so it matters little.

> Maybe sticking a (void) in front of the copy_from_user() call will shut the
> warning up.  Although it could possibly break the build, depending on how
> the architecture implements copy_from_user().
> 
Then isn't my way of shutting up gcc more sensible? little to no impact on 
the code and we get rid of the annoying warning in a safe way that won't 
break anything.

I'll prepare patches against a recent Linus kernel for the other things in 
binfmt_elf I have lying here and submit those shortly, those should fix 
more real issues - I hope you won't mind if I also send those your way.

Thank you very much for taking a look.


--
Jesper Juhl



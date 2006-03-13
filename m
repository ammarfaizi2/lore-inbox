Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWCMDgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWCMDgS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 22:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWCMDgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 22:36:18 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:5901 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751292AbWCMDgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 22:36:17 -0500
Date: Mon, 13 Mar 2006 11:35:39 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jiri Slaby <xslaby@informatics.muni.cz>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow [Was: 2.6.16-rc6-mm1]
In-Reply-To: <E1FIYLc-00080b-00@decibel.fi.muni.cz>
Message-ID: <Pine.LNX.4.64.0603131127340.2349@eagle.themaw.net>
References: <E1FIYLc-00080b-00@decibel.fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006, Jiri Slaby wrote:

Thanks Jiri.

Certainly looks like a problem for me.

Puzzling though as this part of the code has been in operation for a long 
long time?

It would be really helpful if you could give a little more information how 
it happened so I can try and reproduce it?

> Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> [snip]
> >+remove-redundant-check-from-autofs4_put_super.patch
> >+autofs4-follow_link-missing-funtionality.patch

Maybe it is related to the error in this patch that Andrew pointed out.
I'm still thinking about how I should deal with that.

> >
> > Update autofs4 patches in -mm.
> Hello, 
> 
> I caught this during ftp browsing autofs-bind-mounted directories. I don't know
> circumstancies and if the patches above are source of problem. I also don't know
> if -rc6-mm1 is the first one.
> 
> BUG: atomic counter underflow at:
>  [<c0104736>] show_trace+0x13/0x15
>  [<c0104873>] dump_stack+0x1e/0x20
>  [<c01d6c97>] autofs4_wait+0x751/0x93a
>  [<c01d543b>] try_to_fill_dentry+0xca/0x11c
>  [<c01d59b3>] autofs4_revalidate+0xe1/0x148
>  [<c0171338>] do_lookup+0x40/0x157
>  [<c0172ec4>] __link_path_walk+0x804/0xe8c
>  [<c017359c>] link_path_walk+0x50/0xe8
>  [<c01738b7>] do_path_lookup+0x10f/0x26d
>  [<c017429c>] __user_walk_fd+0x33/0x50
>  [<c016d226>] vfs_stat_fd+0x1e/0x50
>  [<c016d30d>] vfs_stat+0x20/0x22
>  [<c016d328>] sys_stat64+0x19/0x2d
>  [<c0103127>] syscall_call+0x7/0xb
> 
> regards,
> --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> ~\-/~      jirislaby@gmail.com      ~\-/~
> B67499670407CE62ACC8 22A032CC55C339D47A7E
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWCHItc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWCHItc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWCHItc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:49:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932512AbWCHItb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:49:31 -0500
Date: Wed, 8 Mar 2006 00:46:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: 76306.1226@compuserve.com, torvalds@osdl.org, lee.schermerhorn@hp.com,
       michaelc@cs.wisc.edu, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-Id: <20060308004659.163b6e29.akpm@osdl.org>
In-Reply-To: <440E969B.2080301@yahoo.com.au>
References: <200603080129_MC3-1-BA15-47C9@compuserve.com>
	<440E969B.2080301@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Chuck Ebbert wrote:
> > In-Reply-To: <Pine.LNX.4.64.0603061917330.3573@g5.osdl.org>
> > 
> > On Mon, 6 Mar 2006 19:20:13 -0800, Linus Torvalds wrote:
> > 
> > 
> >>>When someone converted the *buffer* allocation to kzalloc they
> >>>also removed the the memset for the *packet_cmmand* struct.
> >>>
> >>>The
> >>>
> >>>memset(&cgc, 0, sizeof(struct packet_command));
> >>>
> >>>should be added back I think.
> >>
> >>Good eyes. I bet that's it.
> > 
> > 
> > Heh.  This exact fix was posted to linux-kernel by Lee Schermerhorn
> > three weeks ago:
> > 
> >  Date: Wed, 15 Feb 2006 14:07:37 -0500
> >  From: Lee Schermerhorn <lee.schermerhorn@hp.com>
> >  Subject: [PATCH] 2.6.16-rc3-mm1 - restore zeroing of packet_command
> >         struct  in sr_ioctl.c
> >  To: linux-kernel <linux-kernel@vger.kernel.org>
> >  Cc: Andrew Morton <akpm@osdl.org>
> >  Message-ID: <1140030457.6619.3.camel@localhost.localdomain>
> > 
> > 
> 
> It isn't Andrew's job to make sure a patch gets to the right place
> until it is safely in -mm, and even then he's not always going to
> know the severity and importance unless he's told.

Is too!

> If it was a patch to "restore" a regression in behaviour, CCs should
> at least have gone to the author of the patch that broke it, and the
> subsystem maintainers / list / etc as well.

I actually merged Lee's patch into -mm, copied James on it and then I
dropped it when I saw that it spat rejects against an updated version of
James's tree, assuming that it had been merged.

Often I'll check that a patch reverts successfully from the upstream tree
before dropping it, but for an obvious one like that I guess I didn't
bother, and assumed that James had taken it.  Only he hadn't - instead he'd
gone and merged something else, hence the rejects.   Oh well.

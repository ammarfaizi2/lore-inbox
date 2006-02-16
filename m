Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWBPD4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBPD4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWBPD4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:56:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932241AbWBPD4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:56:50 -0500
Date: Wed, 15 Feb 2006 19:55:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Possibly bug in radix_tree_delete, and fix.
Message-Id: <20060215195541.6a3acd67.akpm@osdl.org>
In-Reply-To: <43F3EE8F.8060000@yahoo.com.au>
References: <17395.58244.839605.685011@cse.unsw.edu.au>
	<43F3EE8F.8060000@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Neil Brown wrote:
> > Hi Nick,
> >  I believe there is a bug in radix_tree_delete introduced by:
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d5274261ea46f0aae93820fe36628249120d2f75
> > 
> > The nature of the bug is that if a tag is set on a node that is being
> > deleted, then that tag is unconditionally cleared in the parent of the
> > node, even if the deleted node has siblings with the tag still set.
> > 
> > I don't know what the large-scale consequences of this bug might be,
> > but I'm kinda hoping fixing it will fix a nasty NFS client related
> > oops we are seeing in radix_tree_tag_set ....
> > 
> 
> I think you're right. I was kind of suspecting I might have introduced
> a silly bug somewhere after a couple of radix tree oopses popped up.

Oh fantastic - a filesystem corrupting bug.

> Not sure why it didn't trigger Andrew's test suite, but I guess that's
> something to add.

Could you please do so?  And add in the previous enhancements you made?  I
was never able to sort out the patches you sent.  And test Neil's later
patch (which looks OK to me)?



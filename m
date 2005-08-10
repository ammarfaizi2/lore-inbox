Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVHJRGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVHJRGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbVHJRGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:06:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28368 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965214AbVHJRGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:06:47 -0400
Date: Wed, 10 Aug 2005 10:05:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] remove name length check in a workqueue
Message-Id: <20050810100523.0075d4e8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>
References: <1123683544.5093.4.camel@mulgrave>
	<Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> wrote:
>
> 
> yeah ... cannot remember why i have done it originally :-|
> 

Might it be to do with sizeof(task_struct.comm)?

> 
> On Wed, 10 Aug 2005, James Bottomley wrote:
> 
> > Ingo,
> > 
> > This has been in the workqueue code in day one, for no real reason that
> > I can see.  We just tripped over it in SCSI because the fibre channel
> > transport class creates one workqueue per host with the name scsi_wq_%d
> > which trips this after we get to 100.  Unfortunately we just came across
> > someone with > 100 host adapters ...
> > 
> > I think the solution is just to get rid of the artificial limit.
> > 
> > James
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -308,8 +308,6 @@ struct workqueue_struct *__create_workqu
> >  	struct workqueue_struct *wq;
> >  	struct task_struct *p;
> >  
> > -	BUG_ON(strlen(name) > 10);
> > -
> >  	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
> >  	if (!wq)
> >  		return NULL;
> > 
> > 

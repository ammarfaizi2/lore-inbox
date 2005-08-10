Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVHJOpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVHJOpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVHJOpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:45:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965139AbVHJOpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:45:15 -0400
Date: Wed, 10 Aug 2005 10:45:03 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] remove name length check in a workqueue
In-Reply-To: <1123683544.5093.4.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>
References: <1123683544.5093.4.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yeah ... cannot remember why i have done it originally :-|

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

On Wed, 10 Aug 2005, James Bottomley wrote:

> Ingo,
> 
> This has been in the workqueue code in day one, for no real reason that
> I can see.  We just tripped over it in SCSI because the fibre channel
> transport class creates one workqueue per host with the name scsi_wq_%d
> which trips this after we get to 100.  Unfortunately we just came across
> someone with > 100 host adapters ...
> 
> I think the solution is just to get rid of the artificial limit.
> 
> James
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -308,8 +308,6 @@ struct workqueue_struct *__create_workqu
>  	struct workqueue_struct *wq;
>  	struct task_struct *p;
>  
> -	BUG_ON(strlen(name) > 10);
> -
>  	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
>  	if (!wq)
>  		return NULL;
> 
> 

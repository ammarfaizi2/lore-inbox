Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVHYJP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVHYJP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVHYJP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:15:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21439 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964895AbVHYJP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:15:28 -0400
Date: Thu, 25 Aug 2005 11:15:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@www.linux.org.uk>
cc: geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
In-Reply-To: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0508251107500.24552@scrub.home>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Aug 2005, Al Viro wrote:

>  
> +static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
> +{
> +	*ti = *p->thread_info;
> +}
> +
>  
> -	*ti = *orig->thread_info;
>  	*tsk = *orig;
> +	setup_thread_info(tsk, ti);
>  	tsk->thread_info = ti;
>  	ti->task = tsk;

This introduces a subtle ordering requirement, where setup_thread_info 
magically finds in the new task_struct the pointer to the old thread_info 
to setup the new thread_info.
What is your problem with what I have in CVS? There it completes the basic
task_struct setup and _after_ that it can setup the thread_info.

Al, I would really prefer to merge this one myself, I'm only waiting for 
the 2.6.13 release and since this is not a regression, I don't really 
understand why this must be in 2.6.13.

bye, Roman

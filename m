Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbUDSJJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUDSJJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:09:45 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:55426 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264306AbUDSJJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:09:44 -0400
Date: Mon, 19 Apr 2004 11:09:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rename PF_IOTHREAD.
Message-ID: <20040419090933.GA18158@elf.ucw.cz>
References: <1082357671.2620.10.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082357671.2620.10.camel@laptop-linux.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A few weeks ago, Pavel and I agreed that PF_IOTHREAD should be renamed
> to PF_NOFREEZE. This reflects the fact that some threads so marked
> aren't actually used for IO while suspending, but simply shouldn't be
> frozen. This patch, against 2.6.5 vanilla, applies that change. In the
> refrigerator calls, the actual value doesn't matter (so long as it's
> non-zero) and it makes more sense to use PF_FREEZE so I've used that.
> 
> Please apply.

Patch looks good. [Except that I'm not sure if this hunk will apply;
there were changes for ^Z in this area].
								Pavel


> diff -ruN linux-2.6.5/kernel/power/process.c linux-2.6.5-NoFreeze/kernel/power/process.c
> --- linux-2.6.5/kernel/power/process.c	2004-01-13 14:16:35.000000000 +1100
> +++ linux-2.6.5-NoFreeze/kernel/power/process.c	2004-04-19 16:47:24.000000000 +1000
> @@ -28,7 +28,7 @@
>  static inline int freezeable(struct task_struct * p)
>  {
>  	if ((p == current) || 
> -	    (p->flags & PF_IOTHREAD) || 
> +	    (p->flags & PF_NOFREEZE) || 
>  	    (p->state == TASK_ZOMBIE) ||
>  	    (p->state == TASK_DEAD))
>  		return 0;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

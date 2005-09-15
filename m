Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVIOJ7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVIOJ7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVIOJ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:59:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25014 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932432AbVIOJ7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:59:17 -0400
Date: Thu, 15 Sep 2005 11:58:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Allan Graves <allan.graves@gmail.com>
Subject: Re: [PATCH 1/10] UML - _switch_to code consolidation
Message-ID: <20050915095828.GE7880@elf.ucw.cz>
References: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch moves code that is in both switch_to_tt and
> switch_to_skas to the top level _switch_to function, keeping us from
> duplicating code.  It is required for the stack trace patch to work
> properly.
> 
> Signed-off-by: Allan Graves <allan.graves@gmail.com>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.13/arch/um/kernel/process_kern.c
> ===================================================================
> --- linux-2.6.13.orig/arch/um/kernel/process_kern.c	2005-09-13 16:04:11.000000000 -0400
> +++ linux-2.6.13/arch/um/kernel/process_kern.c	2005-09-13 16:08:18.000000000 -0400
> @@ -113,8 +113,16 @@
>  
>  void *_switch_to(void *prev, void *next, void *last)
>  {
> -	return(CHOOSE_MODE(switch_to_tt(prev, next), 
> -			   switch_to_skas(prev, next)));
> +        struct task_struct *from = prev;
> +        struct task_struct *to= next;
> +
> +        to->thread.prev_sched = from;
> +        set_current(to);
> +
> +	CHOOSE_MODE_PROC(switch_to_tt, switch_to_skas, prev, next);
> +
> +        return(current->thread.prev_sched); 
> +
>  }

I sense a whitespace damage here.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

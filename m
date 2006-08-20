Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWHTP3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWHTP3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWHTP3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:29:15 -0400
Received: from mother.openwall.net ([195.42.179.200]:23488 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750817AbWHTP3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:29:15 -0400
Date: Sun, 20 Aug 2006 19:25:15 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820152515.GA19948@openwall.com>
References: <20060820003840.GA17249@openwall.com> <20060820082602.GB602@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820082602.GB602@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:26:02AM +0200, Willy Tarreau wrote:
> I'm just wondering why you return a SIGSEGV.

I've taken the SIGSEGV from binfmt_elf.c, where it is used on "Unable to
load interpreter", a condition that commonly occurs on OOM.

> When the kernel kills
> tasks on OOM conditions, it sends either SIGTERM or SIGKILL, as we
> can see here in mm/oom_kill.c:__oom_kill_task() :
> 
>         p->flags |= PF_MEMALLOC | PF_MEMDIE;
>         /* This process has hardware access, be more careful. */
>         if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
>                 force_sig(SIGTERM, p);
>         } else {
>                 force_sig(SIGKILL, p);
>         }
> 
> Shouldn't we simply re-use the same code ?

I have no objections.

Thanks,

Alexander

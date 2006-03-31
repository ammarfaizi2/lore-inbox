Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWCaQhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWCaQhR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCaQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:37:16 -0500
Received: from mail.parknet.jp ([210.171.160.80]:36359 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751313AbWCaQhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:37:14 -0500
X-AuthUser: hirofumi@parknet.jp
To: Jes Sorensen <jes@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
References: <yq0sloytyj5.fsf@jaguar.mkp.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 01 Apr 2006 01:37:05 +0900
In-Reply-To: <yq0sloytyj5.fsf@jaguar.mkp.net> (Jes Sorensen's message of "31 Mar 2006 10:38:22 -0500")
Message-ID: <87irpupo3y.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> writes:

>   	struct poll_list *walk;
>  	struct fdtable *fdt;
>  	int max_fdset;
> -	/* Allocate small arguments on the stack to save memory and be faster */
> -	char stack_pps[POLL_STACK_ALLOC];
> +	/* Allocate small arguments on the stack to save memory and be 
> +	   faster - use long to make sure the buffer is aligned properly
> +	   on 64 bit archs to avoid unaligned access */
> +	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
>  	struct poll_list *stack_pp = NULL;

struct poll_list stack_pps[POLL_STACK_ALLOC / sizeof(struct poll_list)];

is more readable, and probably gcc align it rightly?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

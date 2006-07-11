Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWGKKQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWGKKQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWGKKQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:16:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750926AbWGKKQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:16:46 -0400
Date: Tue, 11 Jul 2006 03:16:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, oleg@tv-sign.ru, ioe-lkml@rameria.de
Subject: Re: [PATCH] de_thread: Use tsk not current.
Message-Id: <20060711031635.a6a1f759.akpm@osdl.org>
In-Reply-To: <m1bqrwkb0u.fsf@ebiederm.dsl.xmission.com>
References: <m1bqrwkb0u.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 22:42:25 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> Ingo Oeser pointed out that because current expands to an inline function it
> is more space efficient and somewhat faster to simply keep a cached copy of
> current in another variable.  This patch implements that for the de_thread
> function.
> 
> -	if (thread_group_empty(current))
> +	if (thread_group_empty(tsk))
> -	if (unlikely(current->group_leader == child_reaper))
> -		child_reaper = current;
> +	if (unlikely(tsk->group_leader == child_reaper))
> +		child_reaper = tsk;
> -	zap_other_threads(current);
> +	zap_other_threads(tsk);
>  	read_unlock(&tasklist_lock);
> ...

This saves nearly 100 bytes of text on gcc-4.1.0/i686.

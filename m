Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUIMIGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUIMIGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUIMIGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:06:25 -0400
Received: from holomorphy.com ([207.189.100.168]:51337 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266316AbUIMIGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:06:23 -0400
Date: Mon, 13 Sep 2004 01:05:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Roel van der Made <roel@telegraafnet.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
Message-ID: <20040913080542.GX2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <dev@sw.ru>,
	Roel van der Made <roel@telegraafnet.nl>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145550F.8030601@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 12:06:39PM +0400, Kirill Korotaev wrote:
> --- ./kernel/exit.c.nt	2004-09-13 11:18:26.000000000 +0400
> +++ ./kernel/exit.c	2004-09-13 11:53:23.611075360 +0400
> @@ -848,10 +848,7 @@ asmlinkage long sys_exit(int error_code)
>  task_t fastcall *next_thread(const task_t *p)
>  {
>  #ifdef CONFIG_SMP
> -	if (!p->sighand)
> -		BUG();
> -	if (!spin_is_locked(&p->sighand->siglock) &&
> -				!rwlock_is_locked(&tasklist_lock))
> +	if (!rwlock_is_locked(&tasklist_lock))
>  		BUG();
>  #endif
>  	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);

Hmm, BUG_ON() for whatever users (embedded?) that define BUG()/BUG_ON()
checks to nops may be useful here since no side effects are expected
from rwlock_is_locked().

FWIW I got this once while running initscripts(!) on a 4x logical x86-64
on virgin 2.6.9-rc1-mm4 but couldn't reproduce it.


-- wli

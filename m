Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbSIYUIb>; Wed, 25 Sep 2002 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262101AbSIYUIa>; Wed, 25 Sep 2002 16:08:30 -0400
Received: from crack.them.org ([65.125.64.184]:39179 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262099AbSIYUI3>;
	Wed, 25 Sep 2002 16:08:29 -0400
Date: Wed, 25 Sep 2002 16:13:38 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] exit-fix-2.5.38-E3
Message-ID: <20020925201338.GA32366@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209252113280.16723-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209252113280.16723-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 09:20:01PM +0200, Ingo Molnar wrote:
> @@ -57,31 +58,31 @@
>  void release_task(struct task_struct * p)
>  {
>  	struct dentry *proc_dentry;
> +	task_t *leader;
>  
> -	if (p->state != TASK_ZOMBIE)
> +	if (p->state < TASK_ZOMBIE)

Could you check TASK_ZOMBIE and TASK_DEAD explicitly, or add a comment
in sched.h saying that only DEAD should be above ZOMBIE?  Otherwise, if
someone needs a new task state, this'll get out of sync.

Just my 2c.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318875AbSIIUq1>; Mon, 9 Sep 2002 16:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318877AbSIIUq1>; Mon, 9 Sep 2002 16:46:27 -0400
Received: from crack.them.org ([65.125.64.184]:1810 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318875AbSIIUpv>;
	Mon, 9 Sep 2002 16:45:51 -0400
Date: Mon, 9 Sep 2002 16:50:43 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: do_syslog/__down_trylock lockup in current BK
Message-ID: <20020909205043.GA9099@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020909201516.GA7465@nevyn.them.org> <Pine.LNX.4.44.0209092243160.19642-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209092243160.19642-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 10:43:51PM +0200, Ingo Molnar wrote:
> 
> the following assert triggers and catches the lockup:
> 
> --- linux/kernel/exit.c.orig	Mon Sep  9 21:59:24 2002
> +++ linux/kernel/exit.c	Mon Sep  9 22:38:44 2002
> @@ -461,6 +461,8 @@
>  		ptrace_unlink (p);
>  
>  		list_del_init(&p->sibling);
> +		if (p->parent == father && p->parent == p->real_parent)
> +			BUG();
>  		p->parent = p->real_parent;
>  		list_add_tail(&p->sibling, &p->parent->children);
>  	}
> 
> so somehow we can end up having parent == real_parent?

When is this happening?  It's not necessarily a bug.  If the process
was traced, then __ptrace_unlink will set p->parent = p->real_parent
when it unlinks.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

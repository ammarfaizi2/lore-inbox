Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbTCaNxz>; Mon, 31 Mar 2003 08:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbTCaNxy>; Mon, 31 Mar 2003 08:53:54 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:772
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261639AbTCaNxy>; Mon, 31 Mar 2003 08:53:54 -0500
Date: Mon, 31 Mar 2003 09:08:22 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Andrew Morton <akpm@digeo.com>
cc: roland@topspin.com, <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New
 OOPS w/ timer
In-Reply-To: <20030330151746.4394dd2e.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303310908020.166-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have applied this to my current tree, testing it out.

On Sun, 30 Mar 2003, Andrew Morton wrote:

> "Shawn Starr" <spstarr@sh0n.net> wrote:
> >
> > drivers/char/tty_io.c - Only
> >
> > I bet it's this function, there's only a kfree, not destruction of any
> > timers.
> >
>
> This is fairly foul.
>
> --- 25/drivers/char/tty_io.c~a	2003-03-30 15:12:37.000000000 -0800
> +++ 25-akpm/drivers/char/tty_io.c	2003-03-30 15:16:59.000000000 -0800
> @@ -1288,6 +1288,8 @@ static void release_dev(struct file * fi
>  	/*
>  	 * Make sure that the tty's task queue isn't activated.
>  	 */
> +	clear_bit(TTY_DONT_FLIP, &tty->flags);
> +	del_timer_sync(&tty->flip.work.timer);
>  	flush_scheduled_work();
>
>  	/*
>
> _
>
>
>


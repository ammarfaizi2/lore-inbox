Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTLEM3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 07:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTLEM3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 07:29:51 -0500
Received: from cibs9.sns.it ([192.167.206.29]:65287 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263963AbTLEM3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 07:29:49 -0500
Date: Fri, 5 Dec 2003 13:29:43 +0100 (CET)
From: venom@sns.it
To: lkml-031128@amos.mailshell.com
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
In-Reply-To: <20031205112319.31918.qmail@mailshell.com>
Message-ID: <Pine.LNX.4.43.0312051328260.19105-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


reproduced without ppp activated, but with lan ipv4 connection.

kernel 2.6.0-test11.

the system freexed, but unfortunatelly I was under X11, and no oops was saved in
my logs.

Luigi

On Fri, 5 Dec 2003 lkml-031128@amos.mailshell.com wrote:

> Date: Fri, 05 Dec 2003 13:23:15 +0200
> From: lkml-031128@amos.mailshell.com
> To: linux-kernel@vger.kernel.org
> Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
>
> OGAWA Hirofumi wrote:
> > lkml-031128@amos.mailshell.com writes:
> >
> >
> >>After I added Ogawa's line, "head -1 /proc/net/tcp" stopped
> >>freezing my machine but PPP failed to work.
> >>
> >>Also after adding Ogawa's line, PPP works fine (as it is now, as
> >>I write this message) as long as I don't try "head -1 /proc/net/tcp"
> >>after boot. If I'll try "head -1 /proc/net/tcp" now PPP will stop
> >>working.
> >
> >
> > Can you reproduce the fail of PPP? I couldn't reproduce it.
> > What reason is the fail of PPP? (the "debug" option of pppd may be helpful)
>
> Sorry. I just tried:
>
> 1. From a multi-user mode, after an uptime of 5 days (test11 with your
> fix).
> 2. killed the ppp daemon (/etc/init.d/ppp stop). Made sure the ppp0
> interface is down.
> 3. did "head -1 /proc/net/tcp" and "cat /proc/net/tcp". Passed fine.
> 4. re-startted ppp daemon.
> 5. System is fine. No kernel errors. PPP works flowlessly.
>
> So I think my linking of PPP to the fix was wrong. Maybe the PPP failure
> was unrelated to this.
>
> >
> > Of course, the following message is easy reproducible. But it's
> > debugging message, not the real problem. And probably it's unrelated
> > to the fail of PPP.
> >
> >
> >>>>>Badness in local_bh_enable at kernel/softirq.c:121
> >>>>>Call Trace:
> >>>>> [<c011df25>] local_bh_enable+0x85/0x90
> >>>>> [<c02315e2>] ppp_async_push+0xa2/0x180
> >>>>> [<c0230efd>] ppp_asynctty_wakeup+0x2d/0x60
> >>>>> [<c0202638>] pty_unthrottle+0x58/0x60
> >>>>> [<c01ff0fd>] check_unthrottle+0x3d/0x40
> >>>>> [<c01ff1a3>] n_tty_flush_buffer+0x13/0x60
> >>>>> [<c0202a47>] pty_flush_buffer+0x67/0x70
> >>>>> [<c01fba41>] do_tty_hangup+0x3f1/0x460
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


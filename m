Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933951AbWKWU5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933951AbWKWU5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933972AbWKWU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:57:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:9154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933951AbWKWU5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:57:53 -0500
Date: Thu, 23 Nov 2006 12:56:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1
Message-Id: <20061123125650.51be24d4.akpm@osdl.org>
In-Reply-To: <45660298.3090003@shadowen.org>
References: <20061123021703.8550e37e.akpm@osdl.org>
	<200611231223.48703.m.kozlowski@tuxland.pl>
	<20061123103607.af7ae8b0.akpm@osdl.org>
	<45660298.3090003@shadowen.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 20:20:40 +0000
Andy Whitcroft <apw@shadowen.org> wrote:

> Andrew Morton wrote:
> > On Thu, 23 Nov 2006 12:23:48 +0100
> > Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:
> > 
> >> Hello,
> >>
> >> 	Hmmm ... didn't apply cleanly.
> >>
> >> patching file kernel/tsacct.c
> >> Hunk #1 FAILED at 97.
> >> 1 out of 1 hunk FAILED -- saving rejects to file kernel/tsacct.c.rej
> > 
> > I think your local tree is not clean.
> 
> I get this accross the board on my test system too.  All clean downloads.
> 
> A quick look at the combo-patch and the broken-out patch seems to
> indicate they are not in sync with each other.  In the combo-patch we
> have this hunk (which is the one which fails):
> 
> --- linux-2.6.19-rc6/kernel/tsacct.c    2006-11-16 23:19:32.000000000 -0800
> +++ devel/kernel/tsacct.c       2006-11-23 01:12:17.000000000 -0800
> @@ -97,7 +97,14 @@ void xacct_add_tsk(struct taskstats *sta
>         stats->read_syscalls    = p->syscr;
>         stats->write_syscalls   = p->syscw;
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
> -       stats->read_bytes       = p->ioac->read_bytes
> +       stats->read_bytes       = p->ioac.read_bytes;
> +       stats->write_bytes      = p->ioac.write_bytes;
> +       stats->cancelled_write_bytes = p->ioac.cancelled_write_bytes;
> +#else
> +       stats->read_bytes       = 0;
> +       stats->write_bytes      = 0;
> +       stats->cancelled_write_bytes = 0;
> +#endif
> 
> In the broken-out directory the only patch which references this file
> has the following different hunk:
> 
> --- a/kernel/tsacct.c~io-accounting-via-taskstats
> +++ a/kernel/tsacct.c
> @@ -96,6 +96,15 @@ void xacct_add_tsk(struct taskstats *sta
>         stats->write_char       = 0;
>         stats->read_syscalls    = p->syscr;
>         stats->write_syscalls   = p->syscw;
> +#ifdef CONFIG_TASK_IO_ACCOUNTING
> +       stats->read_bytes       = p->ioac.read_bytes;
> +       stats->write_bytes      = p->ioac.write_bytes;
> +       stats->cancelled_write_bytes = p->ioac.cancelled_write_bytes;
> +#else
> +       stats->read_bytes       = 0;
> +       stats->write_bytes      = 0;
> +       stats->cancelled_write_bytes = 0;
> +#endif
>  }
>  #undef KB
>  #undef MB
> 
> Looking at 2.6.19-rc6 this second version seems completely reasonable.
> The former does not.

Yes, it seems it was me who had the scrogged tree.

Oh well, use /proc/pid/io ;)


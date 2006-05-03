Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWECNsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWECNsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWECNsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:48:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030209AbWECNsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:48:24 -0400
Date: Wed, 3 May 2006 06:48:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Benoit Boissinot" <bboissin@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: 2.6.17-rc3-mm1
Message-Id: <20060503064816.ef7ec2b7.akpm@osdl.org>
In-Reply-To: <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com>
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	<40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 11:11:48 +0200
"Benoit Boissinot" <bboissin@gmail.com> wrote:

> On 5/1/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/
> >
> >
> Hi Andrew,
> 
> Since a few -mm releases I am seeing processes stuck in a
> nanosleep({0, 0}, NULL) syscall. Sometimes, they unfreeze after
> several hours.
> 
> The processes are urxvtd (rxvt-unicode daemon) or urxvt (rxvt-unicode terminal).
> The backtrace from sysrq-t looks like:
> ...
> urxvtd        S DD965F68     0 12171      1 12367   12598 12078 (NOTLB)
>        dd965f38 326cc12f 00004abf dd965f68 dd965f38 631b6900 00000167 326c007b
>        003d0900 00000000 0000000a df51f144 df51f030 dfb81030 631b6900 00000167
>        003d0900 dd965000 dd965f68 00000001 dd965f50 c032703d 00000001 00000000
> Call Trace:
>  <c032703d> do_nanosleep+0x3d/0x80   <c012fc68> hrtimer_nanosleep+0x38/0xf0
>  <c012fd78> sys_nanosleep+0x58/0x60   <c032818b> sysenter_past_esp+0x54/0x75
> ...
> Showing all blocking locks in the system:
> S          urxvtd:12171 [df51f030, 115] (not blocked on mutex)
> 
> Was it already reported ?

No, I haven't seen such a report in some time.

> If not I'll test a vanilla kernel and start bisecting.

Thanks.   Yes, please test mainline first - it will probably occur there.

And it's a nanosleep(zero) all the time?  The obvious answer would be that
a clock tick came in at the right time and we end up trying to sleep for -1
units.  But if that was the case, things wouldn't unsleep after just
several hours.


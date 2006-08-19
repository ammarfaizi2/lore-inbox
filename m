Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWHSSOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWHSSOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 14:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWHSSOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 14:14:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750749AbWHSSOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 14:14:47 -0400
Date: Sat, 19 Aug 2006 11:14:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Martin Bligh <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 7027] New: CD Ripping speeds slow with 2.6.17
Message-Id: <20060819111437.a88f71cd.akpm@osdl.org>
In-Reply-To: <200608191800.k7JI0ML0015395@fire-2.osdl.org>
References: <200608191800.k7JI0ML0015395@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 11:00:22 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7027
> 
>            Summary: CD Ripping speeds slow with 2.6.17
>     Kernel Version: 2.6.17
>             Status: NEW
>           Severity: normal
>              Owner: bzolnier@gmail.com
>          Submitter: brnewber@gmail.com
> 
> 
> Most recent kernel where this bug did not occur: 2.6.16
> Distribution: Gentoo
> Hardware Environment: ASUS K8V mobo, AMD64 2200, 1GB RAM
> Software Environment: Gentoo
> Problem Description: Ever since 2.6.17 my cd ripping speeds with one particular
> CD ripper/encoder (namely the one I wrote) have been slow. 
> 
> Using git bisect I tracked it down to this patch..
> 
> 9430d58e34ec3861e1ca72f8e49105b227aad327 is first bad commit
> commit 9430d58e34ec3861e1ca72f8e49105b227aad327
> Author: Mike Galbraith <efault@gmx.de>
> Date:   Wed Mar 22 00:07:33 2006 -0800
> 
>     [PATCH] sched: remove sleep_avg multiplier
> 
>     Remove the sleep_avg multiplier.  This multiplier was necessary back when
>     we had 10 seconds of dynamic range in sleep_avg, but now that we only have
>     one second, it causes that one second to be compressed down to 100ms in
>     some cases.  This is particularly noticeable when compiling a kernel in a
>     slow NFS mount, and I believe it to be a very likely candidate for other
>     recently reported network related interactivity problems.
> 
>     In testing, I can detect no negative impact of this removal.
> 
>     Signed-off-by: Mike Galbraith <efault@gmx.de>
>     Acked-by: Ingo Molnar <mingo@elte.hu>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> :040000 040000 28d2d8f53ab7b5dd89e846f2dcc107ce88cb695f 780a13c0f8ba5465db79c668
> 
> I'm honestly not sure if my application is doing something it shouldn't or if
> this is a legitimate kernel bug. Being totally at a loss I'm filing it here.I
> just know that before the above patch I was ripping at about speeds of 9.0x and
> now I rip at 1.2x.
> 

sched problems...

Martin, this might be the source of your `dvdrip' woes?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTJAPSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJAPSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:18:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:42460 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262195AbTJAPSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:18:07 -0400
Date: Wed, 1 Oct 2003 08:19:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: jamie@shareable.org, hugh@veritas.com, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata
 patch
Message-Id: <20031001081910.70d4751b.akpm@osdl.org>
In-Reply-To: <20031001145631.GK22333@wotan.suse.de>
References: <20031001073132.GK1131@mail.shareable.org>
	<Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain>
	<20031001093329.GA2649@mail.shareable.org>
	<20031001075151.4e595f99.akpm@osdl.org>
	<20031001145631.GK22333@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > I'm a bit confused as to what significance the faulting address has btw:
>  > kernel code can raise prefetch faults against addresses which are less
>  > than, and presumably greater than TASK_SIZE.
> 
>  Currently it can't - hlist either prefetches to zero or to a valid 
>  address and everybody else using prefetch should also use valid addresses.

mumble, mutter.

>  But it's conceivable that future kernels make more extensive use of
>  prefetch.

yup.

Why is it not sufficient to do something like:

	if (!(error_code & 4) && is_prefetch(...))
		return;

near the start of do_page_fault()?

kernel-mode faults aren't very common.  Most of them occur in
generic_file_read(), for reads into freshly-allocated memory (I think). 
And the frequency of these is limited by disk bandwidth...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUEZXXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUEZXXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUEZXXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:23:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:20882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbUEZXXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:23:35 -0400
Date: Wed, 26 May 2004 16:26:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP support for drain local pages v2.
Message-Id: <20040526162607.0f177009.akpm@osdl.org>
In-Reply-To: <40B520A2.2060508@linuxmail.org>
References: <40B473F7.4000100@linuxmail.org>
	<20040526223255.GB15278@redhat.com>
	<40B520A2.2060508@linuxmail.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> +/*
> + * Spill per-cpu pages on all CPUs back into the buddy allocator.
> + * The first function is just to avoid a compiler warning.
> + */
> +static void __smp_drain_local_pages(void * data)
> +{
> +       drain_local_pages();
> +}
> +
> +void smp_drain_local_pages(void)
> +{
> +       on_each_cpu(__smp_drain_local_pages, NULL, 0, 1);
> +}

I think we only need a single entry point.  Make it a new "drain_percpu_pages()"
or such to break unconverted callers, switch callers of drain_local_pages()
over to the new function.   It needs no SMP ifdefs in it - on_each_cpu() will
do the right thing on UP.

But until something which needs this change is merged into the tree I'd say
that this patch should live with the patch which requires it.

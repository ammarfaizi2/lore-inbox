Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUIIVig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUIIVig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIIVav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:30:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:33254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266275AbUIIVYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:24:21 -0400
Date: Thu, 9 Sep 2004 14:28:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org, mista.tapas@gmx.net, kr@cybsft.com,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-Id: <20040909142801.5cfa32d1.akpm@osdl.org>
In-Reply-To: <1094760584.15210.1.camel@localhost.localdomain>
References: <20040903120957.00665413@mango.fruits.de>
	<20040904195141.GA6208@elte.hu>
	<20040905140249.GA23502@elte.hu>
	<20040906110626.GA32320@elte.hu>
	<1094626562.1362.99.camel@krustophenia.net>
	<20040909192924.GA1672@elte.hu>
	<20040909130526.2b015999.akpm@osdl.org>
	<1094760584.15210.1.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> I would still expect the only thing to materially improve swap latency
> to be a log structured swap, possibly with a cleaner which tidies
> together pages that are referenced together.
> 

Maybe.  It'd be nice to show some benefit from the "organise pages by
virtual address" patch first.

But then, maybe that doesn't help because there is little correlation
between address congruency and time-of-reference.  That's hard to believe
though.

hm.  The patch _does_ do what I wanted it to do.  Maybe I tested it with
silly workloads.

> 
> You also want contiguous runs of at least 64K and probaly a lot more on
> bigger memory systems. 

I used 1MB.

+/*
+ * We divide the swapdev into 1024 kilobyte chunks.  We use the cookie and the
+ * upper bits of the index to select a chunk and the rest of the index as the
+ * offset into the selected chunk.
+ */
+#define CHUNK_SHIFT	(20 - PAGE_SHIFT)


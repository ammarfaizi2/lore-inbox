Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTIXH7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 03:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTIXH7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 03:59:50 -0400
Received: from hera.kernel.org ([63.209.29.2]:41362 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261351AbTIXH7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 03:59:49 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] softirq_pending()
Date: Tue, 23 Sep 2003 11:07:17 -0700
Organization: OSDL
Message-ID: <bkq24l$g1v$1@build.pdx.osdl.net>
References: <20030923144847.GA16139@lst.de>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1064340437 16447 172.20.1.2 (23 Sep 2003 18:07:17 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 23 Sep 2003 18:07:17 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> x86-64 currently ignores the cpu argument to softirq_pending() and
> always uses smp_processor_id().  And indeed that's the only possible
> argument.  So consolidate the old softirq_pending() and
> local_softirq_pending() into a single one.

The issue is that on some architectures it is quite possibly useful to get
the cpu number, if we end up having to compute it anyway. An example of
this is x86.

On the other hand, some architectures have direct pointers to the "local cpu
state", so for them it is better to always know "this is local" (which it
indeed always is).

So think of the "cpu" argument as a pre-computed "what cpu am I on now"
thing. Especially since we often have it available anyway.

                Linus

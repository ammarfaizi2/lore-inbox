Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbTIQCoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbTIQCoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:44:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:51681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262668AbTIQCoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:44:16 -0400
Date: Tue, 16 Sep 2003 19:44:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-Id: <20030916194446.030d8e70.akpm@osdl.org>
In-Reply-To: <20030917022256.GA17624@wotan.suse.de>
References: <20030917022256.GA17624@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> 
> This is much more efficient than the previous workaround used in the kernel,
> which checked for AMD CPUs in every prefetch(). This can be seen 
> in the size of the vmlinux:

That is hardly a serious comparison: the workaround is just to stop the
oopses while this gets sorted out.  It makes no pretense at either
efficiency or permanence.

> Without patch:
>    text    data     bss     dec     hex filename
> 4020232  665956  169092 4855280  4a15f0 vmlinux
> With patch:
> 4011578  665973  169092 4846643  49f433

hrm.  Why did data grow?

> With prefetch check:    3.7268 microseconds
> Without prefetch check: 3.65945 microseconds

We don't know how much of this difference is due to removing the branch and
how much is due to reenabling prefetch.

It would be interesting to see comparative benchmarking between prefetch
and no prefetch at all, see whether this feature is worth its icache
footprint.


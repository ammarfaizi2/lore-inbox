Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263605AbUEDHgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUEDHgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 03:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUEDHgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 03:36:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:54198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263605AbUEDHgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 03:36:19 -0400
Date: Tue, 4 May 2004 00:35:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-Id: <20040504003548.75097bb6.akpm@osdl.org>
In-Reply-To: <20040504065016.GA6911@in.ibm.com>
References: <20040430113751.GA18296@in.ibm.com>
	<20040430192712.2e085895.akpm@osdl.org>
	<20040503122316.GA7143@in.ibm.com>
	<20040503122520.1e02e861.akpm@osdl.org>
	<20040504065016.GA6911@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> On Mon, May 03, 2004 at 12:25:20PM -0700, Andrew Morton wrote:
> > Well that create_workqueue_thread() will basically never fail - it's not a
> > path we need to be optimising.
> 
> Even if thread creation normally never fails, we still check for its
> return code and have some error recovery code! In that case, 
> I dont understand the point behind continuing the loop once thread
> destruction fails for some CPU. Lets say on a 128 CPU machine, if
> thread creation fails for the 1st CPU (because of say ENOMEM?), then
> why continue trying to create threads for the rest of 126 CPUs and
> _then_ destroy? Why not just break at the first occurence of failure 
> and cleanup then and there?
> 

Because there's less code to get wrong.

In this situation, correctness, clarity and code size are the only things
we care about.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbUCPRNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbUCPRJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:09:58 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:33733 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263966AbUCPRIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:08:07 -0500
Date: Tue, 16 Mar 2004 12:08:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G w/ 8k+ stacks
In-Reply-To: <20040316104042.GO655@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0403161206190.28447@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0403150401310.28447@montezuma.fsmlabs.com>
 <20040316104042.GO655@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, William Lee Irwin III wrote:

> On Tue, Mar 16, 2004 at 01:35:36AM -0500, Zwane Mwaikambo wrote:
> > +#ifdef CONFIG_4KSTACKS
> > +#define STACK_PAGE_COUNT	(4096/PAGE_SIZE)
> > +#else
> > +#define STACK_PAGE_COUNT	(8192/PAGE_SIZE)	/* THREAD_SIZE/PAGE_SIZE */
> > +#endif
>
> This looks like it wants to be:
>
> #define STACK_PAGE_COUNT	(PAGE_ALIGN(THREAD_SIZE)/PAGE_SIZE)
>
> (There are reasons to want THREAD_SIZE < PAGE_SIZE having to do with
> elevating PAGE_SIZE as opposed to shrinking THREAD_SIZE outright.)

Ah yes, i forgot about that case thanks for pointing it out.

> It looks like kmap_types.h should inherits PAGE_* from processor.h
> which in turn should inherit them from page.h
>
> Did the headers barf on this or something? I can't imagine you didn't
> think of it already.

Yes it does inherit PAGE_*, but i needed to specify the same thing in
processor.h so i made it one define to make grepping easier and the
intention more obvious.


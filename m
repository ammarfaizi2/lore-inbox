Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbUCPKkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUCPKkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:40:47 -0500
Received: from holomorphy.com ([207.189.100.168]:60934 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262762AbUCPKkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:40:46 -0500
Date: Tue, 16 Mar 2004 02:40:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G w/ 8k+ stacks
Message-ID: <20040316104042.GO655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0403150401310.28447@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403150401310.28447@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 01:35:36AM -0500, Zwane Mwaikambo wrote:
> +#ifdef CONFIG_4KSTACKS
> +#define STACK_PAGE_COUNT	(4096/PAGE_SIZE)
> +#else
> +#define STACK_PAGE_COUNT	(8192/PAGE_SIZE)	/* THREAD_SIZE/PAGE_SIZE */
> +#endif

This looks like it wants to be:

#define STACK_PAGE_COUNT	(PAGE_ALIGN(THREAD_SIZE)/PAGE_SIZE)

(There are reasons to want THREAD_SIZE < PAGE_SIZE having to do with
elevating PAGE_SIZE as opposed to shrinking THREAD_SIZE outright.)

It looks like kmap_types.h should inherits PAGE_* from processor.h
which in turn should inherit them from page.h

Did the headers barf on this or something? I can't imagine you didn't
think of it already.


-- wli

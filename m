Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWI1WfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWI1WfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWI1WfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:35:24 -0400
Received: from waste.org ([66.93.16.53]:10463 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932531AbWI1WfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:35:23 -0400
Date: Thu, 28 Sep 2006 17:33:41 -0500
From: Matt Mackall <mpm@selenic.com>
To: keios <keios.cn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] low performance of lib/sort.c , kernel 2.6.18
Message-ID: <20060928223341.GI6412@waste.org>
References: <76505a370609280818r3ffc9a4akf4cec6ed366d32e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76505a370609280818r3ffc9a4akf4cec6ed366d32e3@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 11:18:45PM +0800, keios wrote:
> It is a non-standard heap-sort algorithm implementation because the
> index of child node is wrong . The sort function still outputs right
> result, but the performance is O( n * ( log(n) + 1 ) ) , about 10% ~
> 20% worse than standard algorithm .
>
> Signed-off-by: keios <keios.cn@gmail.com>

Was a bit mystified by this as your patch matches what I've got
in my userspace test harness from 2003.

Here's what I submitted, which is almost the same as yours:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/broken-out/lib-sort-heapsort-implementation-of-sort.patch

Then Zou Nan hai sent Andrew a fix for an off-by-one bug here (merged
with my patch):

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/broken-out/lib-sort-heapsort-implementation-of-sort.patch

..which introduced the performance regression.

And then I subsequently tweaked my local copy for use in another
project, coming up with your version.

So this passes my test harness just fine (for both even and odd array
sizes).

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.

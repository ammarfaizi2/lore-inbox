Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUEJXIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUEJXIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUEJXHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:07:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:42693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262961AbUEJXFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:05:34 -0400
Date: Mon, 10 May 2004 16:07:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: alexeyk@mysql.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040510160740.5db8c62c.akpm@osdl.org>
In-Reply-To: <1084228767.6140.832.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	<200405050301.32355.alexeyk@mysql.com>
	<20040504162037.6deccda4.akpm@osdl.org>
	<200405060204.51591.alexeyk@mysql.com>
	<20040506014307.1a97d23b.akpm@osdl.org>
	<1084218659.6140.459.camel@localhost.localdomain>
	<20040510132151.238b8d0c.akpm@osdl.org>
	<1084228767.6140.832.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> I am nervous about this change. You are totally getting rid of
> lazy-readahead and that was the optimization which gave the best
> possible boost in performance. 

Because it disabled the large readahead outside the area which the app is
reading.  But it's still reading too much.

> Let me see how this patch does with a DSS benchmark.

That was not a real patch.  More work is surely needed to get that right.

> In the normal large random workload this extra page would have
> compesated for all the wasted readaheads.

I disagree that 64k is "normal"!

>  However in the case of
> sysbench with Andrew's ra-copy patch the readahead calculation is not
> happening quiet right. Is it worth trying to get a marginal gain 
> with sysbench at the cost of getting a big hit on DSS benchmarks,
> aio-tests,iozone and probably others. Or am I making an unsubstantiated
> claim? I will get back with results.

It shouldn't hurt at all - the app does a seek, we perform the
correctly-sized read.

As I say, my main concern is that we correctly transition from seeky access
to linear access and resume readahead.


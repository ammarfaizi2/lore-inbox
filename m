Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbTHYDAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHYDAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:00:47 -0400
Received: from dyn-ctb-210-9-243-120.webone.com.au ([210.9.243.120]:6148 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261418AbTHYDAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:00:45 -0400
Message-ID: <3F497BB6.90100@cyberone.com.au>
Date: Mon, 25 Aug 2003 13:00:06 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy
References: <3F48B12F.4070001@cyberone.com.au> <29760000.1061744102@[10.10.2.4]>
In-Reply-To: <29760000.1061744102@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>Seems to do badly with CPU intensive tasks:
>
>Kernbench: (make -j vmlinux, maximal tasks)
>                              Elapsed      System        User         CPU
>              2.6.0-test3       46.00      115.49      571.94     1494.25
>         2.6.0-test4-nick       49.37      131.31      611.15     1500.75
>

Thanks Martin.

>
>Oddly, schedule itself is significantly cheaper, but you seem
>to end up with much more expense elsewhere. Thrashing tasks between
>CPUs, maybe (esp given the increased user time)? I'll do a proper 
>baseline against test4, but I don't expect it to be any different, really.
>

Yeah I'd say most if not all would be my fault though. What happens
is that a lowest priority process will get a 1ms timeslice if there
is a highest priority process on the same runqueue, though it will
get I think 275ms if there are only other low priority processes
there.

A kernbench probably has enough IO to keep priorities up a bit and
keep timeslices short. The timeslice stuff could probably still use
a bit of tuning. On the other hand, nice -20 processes should get
big timeslices, while other schedulers give them small timeslices.



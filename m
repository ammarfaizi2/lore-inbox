Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTKJBKS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 20:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTKJBKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 20:10:18 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:36550 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261988AbTKJBKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 20:10:14 -0500
Message-ID: <3FAEE2E0.2040306@cyberone.com.au>
Date: Mon, 10 Nov 2003 11:59:12 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Con Kolivas <kernel@kolivas.org>, Davide Libenzi <davidel@xmailserver.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
References: <Pine.LNX.4.44.0311090801130.12198-100000@bigblue.dev.mdolabs.com> <200311100307.40127.kernel@kolivas.org> <125870000.1068397851@[10.10.2.4]>
In-Reply-To: <125870000.1068397851@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>On the same vein ... this looks odd:
>
>         * We fend off statistical fluctuations in runqueue lengths by
>         * saving the runqueue length during the previous load-balancing
>         * operation and using the smaller one the current and saved lengths.
>         * If a runqueue is long enough for a longer amount of time then
>         * we recognize it and pull tasks from it.
>...
>        if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
>                nr_running = this_rq->nr_running;
>        else
>                nr_running = this_rq->prev_cpu_load[this_cpu];
>
>It says we uses the smaller of the two in the comment, but then it seems to
>use the > of the two in the code? Unless I'm losing it, which is likely ;-)
>

You want the larger of the two values to be taken for the destination
queue, and the smaller to be taken for the source queue. This way you
get a minimal imbalance.



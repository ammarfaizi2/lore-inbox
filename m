Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTIGJ0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 05:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTIGJ0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 05:26:54 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:16905
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262918AbTIGJ0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 05:26:53 -0400
Message-ID: <3F5AF9D9.3070206@cyberone.com.au>
Date: Sun, 07 Sep 2003 19:26:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Yau <jyau_kernel_dev@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000201c374c8$1124ee20$f40a0a0a@Aria> <3F5ABE90.2040003@cyberone.com.au> <Law10-OE296cRyiOYbp00008b23@hotmail.com> <3F5AE7ED.7010501@cyberone.com.au> <LAW10-OE38NfztQ7LS000009f64@hotmail.com>
In-Reply-To: <LAW10-OE38NfztQ7LS000009f64@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Yau wrote:

>>Even if context switches don't cost anything, you still want to have
>>priorities so cpu hogs can be preempted by other tasks in order to
>>quickly respond to IO events. You want interactive tasks to be able
>>to sometimes get more cpu than cpu hogs, etc. Scheduling latency is
>>only a part of it.
>>
>>
>
>Of course priorities are still necessary =)  However assuming that
>interactive tasks will always finish much much earlier than hogs, it's not
>really worth it to give interactive tasks any special treatment when you
>have very fine timeslices.
>

Its actually more important when you have smaller timeslices, because
the interactive task is more likely to use all of its timeslice in a
burst of activity, then getting stuck behind all the cpu hogs.

>
>
>For example you have x that will use 100 ms and y that will use 5 ms, both
>of the same priority.  Assuming that x entered into the queue first and y
>immediately after, at 20 ms timeslice, it will be 25 ms before y finishes.
>However, at 1 ms timeslice, y finishes in 10 ms.
>
>

Yes. Also, say 5 hogs running, an interactive task needs to do something
taking 2ms. At a 2ms timeslice, it will take 2ms. At a 1ms timeslice it
will take 6ms.



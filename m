Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTJWCCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 22:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTJWCCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 22:02:48 -0400
Received: from mail-05.iinet.net.au ([203.59.3.37]:16874 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261555AbTJWCCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 22:02:46 -0400
Message-ID: <3F9736CE.8050007@cyberone.com.au>
Date: Thu, 23 Oct 2003 12:02:54 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v16 - reaim
References: <200310221407.h9ME7mM14401@mail.osdl.org>
In-Reply-To: <200310221407.h9ME7mM14401@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cliff White wrote:

>>
>>
>>>>I'm starting to do some large SMP / NUMA testing. Fixed and changed quite
>>>>a bit. It isn't too bad, although I'm only testing dbench, tbench, and
>>>>volanomark at the moment.
>>>>
>>>>These SMP and NUMA changes are not tied to my interactivity stuff, so its
>>>>possible they could get included if they turn out well. If you find any
>>>>problems with it (high end or interactivity), please let me know.
>>>>
>>>>
>
>Results from reaim aren't encouraging.
>patch was applied against 2.6.0-test8 - the result
>is PLM #2232
>
>STP id  kernal name       Max JPM   Max User Pct    elevator
>281932	nick_v16          4923.08    60	     0.00   AS
>281933	nick_v16          5196.06    68	     5.54   deadline
>281722	linux-2.6.0-test8 5432.77    92	     9.38   deadline
>281792	2.6.0-test8-mm1   5384.41    92	     8.56   deadline
>281790	2.6.0-test8-mm1   5392.65    88      8.7    AS
>
>The kernel doesn't perform well at larger user numbers.
>Notice the different in max users.
>Compare the graphs for jobs per minute, the usual graph
>is quite flat, see:
>http://khack.osdl.org/stp/281932/results/jpm.png
>
>With the v16 scheduler, jobs per minute falls off rapidly
>as user number increases giving graph with a steep slope, 
>not good.
>http://khack.osdl.org/stp/281790/results/jpm.png
>Further results: http://www.developer.osdl.org/reaim/index.html
>

Hi Cliff,

Yeah, unfortunately this graph has been a feature of my scheduler for
quite a while :( I think it is caused either by too much balancing
or timeslices getting too small because there are a lot of threads
blocking. Anyway, if you had the time to test this one would be really
good.

http://www.kerneltrap.org/~npiggin/v16/sched-rollup-nopolicy-v16.gz

Nick


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbUJZBZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbUJZBZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUJZBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:21:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261919AbUJZBSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:18:42 -0400
Message-ID: <417D9371.4050305@yahoo.com.au>
Date: Tue, 26 Oct 2004 09:59:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Hawkes <hawkes@sgi.com>
CC: John Hawkes <hawkes@google.engr.sgi.com>, John Hawkes <hawkes@oss.sgi.com>,
       Ingo Molnar <mingo@elte.hu>, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
References: <200410201936.i9KJa4FF026174@oss.sgi.com> <200410221938.MAA52152@google.engr.sgi.com> <00ee01c4b870$030b80f0$6700a8c0@comcast.net> <4179DDA3.1020405@yahoo.com.au> <001c01c4baac$056ae7d0$6700a8c0@comcast.net>
In-Reply-To: <001c01c4baac$056ae7d0$6700a8c0@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Hawkes wrote:

> 
> To reiterate:  this is probably reproducible on smaller SMP systems, too.
> Just do a 'runon' (using sys_sched_setaffinity) of ~200 (or more) small
> computebound processes on a single CPU.
> 

Yeah I tried that with a handful... I'll try again with 200.

> My patch -- that has load_balance() skip over (busiest->active_balance = 1)
> trigger that starts up active_load_balance() -- does seem to reduce the
> frequency of bursts of long-running activity of the migration thread, but
> those burst of activity are still there, with migration_thread consuming
> 75-95% of its CPU for several seconds (as observed by 'top').  I have not yet
> determined what's happening.  It might be an artifact of how long it takes to
> do those 'runon' startups of the computebound processes.
> 

Hmm... it would be hard to believe that it is all to do with
migrating tasks... but its possible I guess.

I'll also look into it if I can reproduce the problem here.


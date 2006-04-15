Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWDOW4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWDOW4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWDOW4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:56:43 -0400
Received: from mail.parknet.jp ([210.171.160.80]:18694 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932108AbWDOW4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:56:42 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@google.com>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
References: <4441452F.3060009@google.com>
	<20060415141744.042231a8.akpm@osdl.org> <44416616.10908@google.com>
	<20060415145227.5d1249bd.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 16 Apr 2006 07:56:34 +0900
In-Reply-To: <20060415145227.5d1249bd.akpm@osdl.org> (Andrew Morton's message of "Sat, 15 Apr 2006 14:52:27 -0700")
Message-ID: <87mzem78il.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> "Martin J. Bligh" <mbligh@google.com> wrote:
>>
>> drilling down into the results directories can get you the command line,
>>  looks like "reaim -f workfile.short -s 1 -e 10 -i 2" to me. Buggered if
>>  I can recall what that did though.
>> 
>>  (http://test.kernel.org/abat/20229/004.reaim.test/results/cmdline)
>> 
>>  I *think* it's only ia32 NUMA boxes, at least as far as I can see from
>>  a quick poke around. Which would make me guess at scheduler code. Gitweb
>>  would be nice to use, but it doesn't tag the -git snapshots, AFAICS, 
>>  which is a real shame. Nor does the git snapshot include the git tag,
>>  as far as I know. Grrrr. I guess I'll download the snapshots and diff
>>  them, and try to pull out the sched changes by hand. Much suckage.
>
> The diffstat for 2.6.15-git5 -> 2.6.15-git6 is at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2 - only a single line
> changed in sched.c:
>
> diff -uNr 2.6.15-git5/kernel/sched.c 2.6.15-git6/kernel/sched.c
> --- 2.6.15-git5/kernel/sched.c	2006-04-15 14:10:43.000000000 -0700
> +++ 2.6.15-git6/kernel/sched.c	2006-04-15 14:10:52.000000000 -0700
> @@ -4386,6 +4386,7 @@
>  	} while_each_thread(g, p);
>  
>  	read_unlock(&tasklist_lock);
> +	mutex_debug_show_all_locks();
>  }
>  
>  /**
>
> The below patches went from -mm into mainline on that day.  It'll be pretty
> simple to bisection search these once we have a testcase.

config DEBUG_MUTEXES
	bool "Mutex debugging, deadlock detection"
	default y
	depends on DEBUG_KERNEL
	help
	 This allows mutex semantics violations and mutex related deadlocks
	 (lockups) to be detected and reported automatically.

?

By default, it's y, so it seems likely.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

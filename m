Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbUKLGEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUKLGEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUKLGEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:04:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1288 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262456AbUKLGES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:04:18 -0500
Date: Fri, 12 Nov 2004 07:04:14 +0100
From: Willy Tarreau <willy@w.ods.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_PM_TIMER is slow
Message-ID: <20041112060413.GF783@alpha.home.local>
References: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 11, 2004 at 09:52:27PM -0800, dean gaudet wrote:
> when using CONFIG_X86_PM_TIMER i'm finding that gettimeofday() calls take 
> 2.8us on a p-m 1.4GHz box... which is an order of magnitude slower than 
> TSC-based solutions.
> 
> on one workload i'm seeing a 7% perf improvement by booting "acpi=off" to 
> force it to use tsc instead of the PM timer... (the workload calls 
> gettimeofday too frequently, but i can't change that).

I did not test, this might be interesting.
In fact, what would be very good would be sort of a new select/poll/epoll
syscalls with an additional argument, which would point to a structure
that the syscall would fill in return with the time of day. This would
greatly reduce the number of calls to gettimeofday() in some programs,
and make use of the time that was used by the syscall itself.

For example, if I could call it like this, it would be really cool :

   ret = select_absdate(&in, &out, &excp, &date_timeout, &return_date);

with <date_timeout> the date at which to timeout (instead of the number of
microseconds) and <return_date> the current date upon return.

Cheers,
Willy


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTEHJkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTEHJkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:40:06 -0400
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:61830 "EHLO
	gnuppy") by vger.kernel.org with ESMTP id S261251AbTEHJkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:40:03 -0400
Date: Thu, 8 May 2003 02:52:38 -0700
To: Ming Lei <lei.ming@attbi.com>
Cc: linux-kernel@vger.kernel.org, "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: linux rt priority  thread corrupt  global variable?
Message-ID: <20030508095238.GA20844@gnuppy.monkey.org>
References: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:03:35AM -0700, Ming Lei wrote:
> Related questions:
> 
> Is linux kernel 2.4.10 considered strictly preemptive such as VxWorks or
> other RTOS? I guess 2.4.10 may simulate preemptive with running scheduler on
> every syscall or interrupt returns. Am I right?

No, it's not a fully preemptive kernel, but spreads preemption points
throughout the source tree, both directly and indirectly, instead. Spinlocks
are the primary mutex of choice in Linux and create atomic critical sections
that can't be preempted with respect to the normal Linux scheduler. Fully
preemptive systems tend to use sleepable locks with relaxed preemptability
within critical sections and add the possible option of priority inheritance
depending on the system.

If you're going to do RT Linux related stuff use RTLinux, RTAI or other
commerical options instead.

> Is printf() real-time priority thread safe?

Stock Linux is definitely not if I understand what you're saying and
if I understand the code correctly. :)

bill


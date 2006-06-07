Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWFGJR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWFGJR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWFGJR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:17:28 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:14609 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932081AbWFGJR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:17:27 -0400
Message-ID: <4486998D.6060302@shadowen.org>
Date: Wed, 07 Jun 2006 10:17:01 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, mbligh@google.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm3] better lock debugging: remove mutex deadlock
 checking code
References: <44845C27.3000006@google.com> <20060605194422.GB14709@elte.hu> <20060605130039.db1ac80c.rdunlap@xenotime.net> <20060606085623.GA2932@elte.hu>
In-Reply-To: <20060606085623.GA2932@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Randy.Dunlap <rdunlap@xenotime.net> wrote:
> 
> 
>>BUG: unable to handle kernel paging request at virtual address 22222232
> 
> 
> ok, this was a big thinko on my part, and it was right before our eyes. 
> Mutex deadlock checking relied on the 'big mutex debugging lock', but 
> that one is gone now - so mutex deadlock checking became racy (as your 
> crashes nicely pinpointed that). The races are more likely with an 
> increasing number of CPUs.
> 
> so the patch below finishes the cleanup i started: it removes deadlock 
> checking from the mutex code and lets the lock validator do that. This 
> should also be (much) faster on SMP, because the lock validator is 
> lockless in the fastpath. (if CONFIG_DEBUG_LOCKDEP is disabled)
> 
> 	Ingo
> 
> ----------------
> Subject: better lock debugging: remove mutex deadlock checking code
> From: Ingo Molnar <mingo@elte.hu>
> 
> with the lock validator we detect mutex deadlocks (and more), the mutex
> deadlock checking code is both redundant and slower. So remove it.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---

Ok, this patch in combination with either fix for the swap max bug are
showing passes across the board.

Acked-by: Andy Whitcroft <apw@shadowen.org>

-apw

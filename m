Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSJOPRY>; Tue, 15 Oct 2002 11:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSJOPRX>; Tue, 15 Oct 2002 11:17:23 -0400
Received: from crack.them.org ([65.125.64.184]:8717 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S263137AbSJOPRV>;
	Tue, 15 Oct 2002 11:17:21 -0400
Date: Tue, 15 Oct 2002 11:10:04 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] x86 transition to 4k stacks (0/3)
Message-ID: <20021015151004.GA27693@nevyn.them.org>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DABAEDB.9070207@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DABAEDB.9070207@us.ibm.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:59:55PM -0700, Dave Hansen wrote:
> The kernel currently uses an 8k stack, per task.  Here is the 
> infrastructure needed to allow us to halve that at some point in the 
> future.
> 
> This is a port of work Ben LaHaise did around 2.5.20 time.  I split it
> up and updated it for the new preempt_count semantics.
> 
> I split the original patch up into 3 pieces (apply in this order):
> * clean thread info infrastructure (1/3)
>   - take out all instances of things like (8191&addr) to get
>     current stack address.
> * stack checking (3/3)
>   - use gcc's profiling features to check for stack overflows upon
>     entry to functions.
>   - Warn if the task goes over 4k.
>   - Panic if the stack gets within 512 bytes of overflowing.
> * interrupt stacks (3/3)
>   - allocate per-cpu interrupt stacks.  upon entry to
>     common_interrupt, switch to the current cpu's stack.
>   - inherit the interrupted task's preempt count
> 
> Any suggestions on how to deal with "gcc -p" and old, buggy versions
> of gcc would be appreciated.

You might have better luck with -finstrument-functions; I don't know if
it is supported as far back but I don't believe it was buggy.  It has a
few fewer quirks than mcount profiling.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

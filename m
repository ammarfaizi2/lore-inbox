Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVGWFg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVGWFg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 01:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVGWFg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 01:36:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262351AbVGWFg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 01:36:27 -0400
Date: Sat, 23 Jul 2005 15:35:31 +1000
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_times() return value
Message-Id: <20050723153531.7a5880c0.akpm@osdl.org>
In-Reply-To: <20050718002446.B789@flint.arm.linux.org.uk>
References: <20050718002446.B789@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> Guys,
> 
> ARM folk have recently pointed out a problem with sys_times().
> When the kernel boots, we set jiffies to -5 minutes.  This causes
> sys_times() to return a negative number, which increments through
> zero.
> 
> However, some negative numbers are used to return error codes.
> Hence, there's a period of time when sys_times() returns values
> which are indistinguishable from error codes shortly after boot.

What a strange system call.

> This probably only affects 32-bit architectures.  However, one
> wonders whether sys_times() needs force_successful_syscall_return().

I'd say so, yes.  But lots of architectures seem to have a no-op there.

> Also, it appears that glibc does indeed interpret the return value
> from sys_times in the way I describe above on at least ARM and x86.
> Other architectures may be similarly affected.  Hopefully the ARM
> glibc folk will raise a cross-architecture bug in glibc for this.
> 


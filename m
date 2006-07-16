Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWGPMfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWGPMfV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 08:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWGPMfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 08:35:21 -0400
Received: from smtpout.mac.com ([17.250.248.185]:9687 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751576AbWGPMfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 08:35:20 -0400
In-Reply-To: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
Cc: dwmw2@infradead.org, arjan@infradead.org, maillist@jg555.com,
       ralf@linux-mips.org, linux-kernel@vger.kernel.org, davem@davemloft.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 2.6.18 Headers - Long
Date: Sun, 16 Jul 2006 08:34:53 -0400
To: Albert Cahalan <acahalan@gmail.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 15, 2006, at 17:09:28, Albert Cahalan wrote:
> Here we have a full-featured set of atomic ops,

You realize that on a couple architectures it's fundamentally  
impossible to get atomic ops completely in userspace, right?  Some of  
the mechanisms that various archs use (IIRC including in one or two  
cases just completely disabling interrupts) don't work anywhere but  
the kernel.

> byte swapping with readable names and a distinction for pointers,  
> nice macros for efficient data structure manipulation...

Both of which may be easily cut and pasted into your GPL programs  
with little or no effort (Hint: I do this all the time).  Those are  
so stable you don't even have to maintain it!  IMHO, what you really  
want, though, is for GCC to export a library of ASM intrinsics (like  
memory barriers, atomic ops, etc), that are available on your current  
architecture.  If there is no __gcc_atomic_inc then it wouldn't  
#define it and you can just go back to pthread_mutex_lock/unlock for  
protecting an atomic variable.  Such a library layer certainly  
doesn't belong in the kernel, although if GCC got such a library  
right the kernel might start to use it (although only the most recent  
GCC would support it so it wouldn't be very useful).

> Sure, you'd like all the app developers to [...] use sucky POSIX  
> threads stuff

There is *NO* portable way to get atomic operations or locking in  
userspace except through libpthread.  Atomic operations in the kernel  
are sometimes _not_ atomic in userspace and the only decent way to do  
userspace locking is to call into the kernel on contention (or you  
waste the rest of your timeslice spinning).  POSIX thread operations  
are extremely efficient under Linux, but the kernel shouldn't export  
the varying underlying operations.

Cheers,
Kyle Moffett


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288089AbSAYWao>; Fri, 25 Jan 2002 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSAYWa2>; Fri, 25 Jan 2002 17:30:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:53258 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287882AbSAYWaO>;
	Fri, 25 Jan 2002 17:30:14 -0500
Subject: Re: [PATCH] syscall latency improvement #1
From: Robert Love <rml@tech9.net>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com>
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 17:35:19 -0500
Message-Id: <1011998120.3505.29.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 13:54, David Howells wrote:

> The attached patch does the following to 2.5.3-pre5:
> 
>  * consolidates various status items that are found in the lower reaches of
>    task_struct into one 32-bit word, thus allowing them to be tested
>    atomically without the need to disable interrupts in entry.S.
> 
>  * optimises the instructions in the system_call path in entry.S
> 
>  * frees up a hole in the bottom part of the task_struct (on the 1st cache
>    line).
> 
>  * improves base syscall latency by approximately 5.4% (dual PIII) or 3.6%
>    (dual Athlon) as measured by lmbench's "lat_syscall null" command against
>    the vanilla kernel.

Mmm, I like it.  Ingo Molnar talked to me about this (he wants such a
feature, too) earlier.  This is a real win.

This patch is beneficial to the kernel preemption patch.  I suspect
other future ideas could be added now without hurting the common case,
too.  I had planned to roll need_resched into our preemption counter,
and I probably still can even with only 1 byte.

Anyhow, I'm looking it over -- good code.

	Robert Love


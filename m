Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270810AbTHGVBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270848AbTHGVBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:01:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:48326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270810AbTHGVBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:01:13 -0400
Date: Thu, 7 Aug 2003 14:03:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Patrick McLean <pmclean@cs.ubishops.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm5 x86-64 link errors
Message-Id: <20030807140310.4e2c8a79.akpm@osdl.org>
In-Reply-To: <3F32AA2B.20809@cs.ubishops.ca>
References: <3F32AA2B.20809@cs.ubishops.ca>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McLean <pmclean@cs.ubishops.ca> wrote:
>
>  I get to play with an opteron for a bit, so I'm going to try 2.6 on it, 
>  but test2-mm5 seems to compile fine, but when it goes to link it, it 
>  gives these errors:
> 
>     LD      init/built-in.o
>     LD      .tmp_vmlinux1
>  kernel/built-in.o(.text+0x359): In function `try_to_wake_up':
>  : undefined reference to `sched_clock'

Ingo's scheduler patch requires that the architecture provide a
sched_clock() function which returns nanoseconds.  We only have ia32, ia64,
ppc and ppc64 versions thus far.

A lame version is to just add

unsigned long long sched_clock(void)
{
	return (unsigned long long)jiffies * (1000000000 / HZ);
}

to arch/<foo>/kernel/timer.c



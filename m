Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUGMHXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUGMHXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 03:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUGMHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 03:23:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:32724 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263555AbUGMHXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 03:23:10 -0400
Date: Tue, 13 Jul 2004 09:23:07 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: akpm@osdl.org, torvalds@osdl.org, mingo@redhat.com, jparadis@redhat.com,
       cagney@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 support for singlestep into 32-bit system calls
Message-Id: <20040713092307.4cd6b5aa.ak@suse.de>
In-Reply-To: <200407122358.i6CNwQ4Q001709@magilla.sf.frob.com>
References: <200407122358.i6CNwQ4Q001709@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 16:58:26 -0700
Roland McGrath <roland@redhat.com> wrote:

> This patch makes x86-64's 32-bit support behave consistently with the
> native i386 behavior achieved in Davide Libenzi's patch:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken-out/really-ptrace-single-step-2.patch
> 
> I hope these both can go into 2.6.8 or 2.6.9, since they make life 
> better for gdb.

I would prefer not to merge this. It looks extremly ugly and the current
behaviour is not that unreasonable and gdb has lived with it forever,
so why can't it continue it? It has to keep supporting old versions
anyways and other i386 OS it supports probably do the same.

If i386 merges it I guess it's ok for consistency, but it would be 
better to not do it at all.


> +#ifdef CONFIG_IA32_EMULATION
> +	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
> +#endif


This looks wrong. Why do you do this unconditionally when 32bit 
emulation is compiled in? Either it is correct to do for 64bit 
processes, then the ifdef should go, or it is not correct then
it would need a test. For me dropping the flag both for 32bit
and 64bit looks wrong.

Same in other hunks.

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263325AbTC0RST>; Thu, 27 Mar 2003 12:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbTC0RRS>; Thu, 27 Mar 2003 12:17:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56424 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263325AbTC0RRA>; Thu, 27 Mar 2003 12:17:00 -0500
Date: Thu, 27 Mar 2003 12:28:13 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200303271728.h2RHSDc28540@devserv.devel.redhat.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm offsets for i386
In-Reply-To: <mailman.1048773360.3585.linux-kernel2news@redhat.com>
References: <mailman.1048773360.3585.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Resend]
> 
> This patch creates an asm-offsets.c file for i386, and removes the
> hardcoded constants from several asm files.
> 
> --
> 				Brian Gerst

Doesn't seem to be worth the trouble because thread_info
is a small structure, not embedded into a big structure
as thread_struct was. DaveM removed the automatic
offset generation on sparc64 and I am thinking to do
the same on sparc.

I'm not surprised that nobody answered, the patch seems
to be rather pointless.

We might want to add something like this:

    if (TI_CPU         != offsetof(struct thread_info, cpu) ||
        TI_PREEMPT     != offsetof(struct thread_info, preempt_count) ||
        TI_SOFTIRQ     != offsetof(struct thread_info, softirq_count) ||
        TI_HARDIRQ     != offsetof(struct thread_info, hardirq_count))
            thread_info_offsets_are_bolixed_linus();

It gives out an link time error.

-- Pete

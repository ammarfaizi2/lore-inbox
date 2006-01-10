Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWAJBtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWAJBtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWAJBtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:49:15 -0500
Received: from ns2.suse.de ([195.135.220.15]:34213 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750904AbWAJBtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:49:15 -0500
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon 64 X2 cpuinfo oddities
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 10 Jan 2006 02:49:13 +0100
In-Reply-To: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
Message-ID: <p73r77gx36u.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> writes:
> 
> Well, first of all you'll notice that the second core shows a
> "physical id" of 127 while the first core shows an id of 0.  Shouldn't
> the second core be id 1, just like the "core id" fields are 0 & 1?

In theory it could be an uninitialized phys_proc_id (0xff >> 1), 
but it could be also the BIOS just setting the local APIC of CPU 1
to 0xff for some reason.

If you add a printk("PHYSCPU %d %x\n", smp_processor_id(), phys_proc_id[smp_processor_id()])
at the end of arch/x86_64/kernel/setup.c:early_identify_cpu() what does
dmesg | grep PHYSCPU output?

> 
> Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
> I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
> Is it a case of:
>  a) Me being wrong, not all Athlon 64 X2's feature SSE3?
>  b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
>  c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
> doesn't show that fact?
>  d) Something else?

It's called pni (prescott new instructions) for historical reasons. We added
the bit too early before Intel's marketing department could make up its
mind fully, so Linux is stuck with the old codename.

-Andi

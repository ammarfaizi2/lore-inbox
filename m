Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWGFIWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWGFIWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWGFIWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:22:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5351 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964991AbWGFIWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:22:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, kmannth@gmail.com,
       linux-kernel@vger.kernel.org, tglx@linutronix.de,
       Natalie.Protasevich@UNISYS.com
Subject: Re: 2.6.17-mm6
References: <20060705155037.7228aa48.akpm@osdl.org>
	<a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	<20060705164457.60e6dbc2.akpm@osdl.org>
	<20060705164820.379a69ba.akpm@osdl.org>
	<a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
	<20060705172545.815872b6.akpm@osdl.org>
	<m1u05v2st3.fsf@ebiederm.dsl.xmission.com>
	<20060705225905.53e61ca0.akpm@osdl.org>
	<20060705233123.dcb0a10b.akpm@osdl.org>
	<m17j2r2od0.fsf@ebiederm.dsl.xmission.com>
	<20060706072529.GA12317@elte.hu>
Date: Thu, 06 Jul 2006 02:21:32 -0600
In-Reply-To: <20060706072529.GA12317@elte.hu> (Ingo Molnar's message of "Thu,
	6 Jul 2006 09:25:29 +0200")
Message-ID: <m1psgj16ur.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> What is scary is that at 1K cpus if we wind up using all of the irqs 
>> we start consuming 1Gig of RAM.  At only 128 cpus we are still in the 
>> 2M-15M territory, so that isn't too scary.  The point is that after a 
>> certain put the memory usage for all of those counters goes insane.
>
> we just need to move kernel_stat.irqs out of the per-cpu area and 
> alloc_percpu() a counter pointer for each IRQ that is truly set up. If 
> someone ends up using more than say 10,000 irqs we can reconsider. With 
> 10K irqs we'd have 10MB of stat counter footprint - that's reasonable.

Hmm.  at 10,000 IRQs and 128 cpus I got about 5MB.  But close enough.

I'm convinced at least for now.

The case I have seen are sparsely populated irqs.

And we really do need the high IRQ counts because the potential irqs
really do go up at 15 or so IRQs per cpu.

Still if we are doing this generically let's please put in a
big fat comment describing the situation, and maybe a compile warning,
if things get too big.

Eric

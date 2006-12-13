Return-Path: <linux-kernel-owner+w=401wt.eu-S965088AbWLMUGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbWLMUGf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWLMUGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:06:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52425 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965088AbWLMUGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:06:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	<m1lklbport.fsf@ebiederm.dsl.xmission.com>
	<20061213194332.GA29185@elte.hu>
Date: Wed, 13 Dec 2006 13:06:12 -0700
In-Reply-To: <20061213194332.GA29185@elte.hu> (Ingo Molnar's message of "Wed,
	13 Dec 2006 20:43:32 +0100")
Message-ID: <m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> In addition the cases I can think of allowed_affinity is the wrong 
>> name.  suggested_affinity sounds like what you are trying to implement 
>> and when it is merely a suggestion and not a hard limit it doesn't 
>> make sense to export like this.
>
> well, there are interrupts that must be tied to a single CPU and must 
> never be moved away. For example per-CPU clock-events-source interrupts 
> are such. So allowed_affinity very much exists.

Although in that case since it is a single cpu there is a much
more elegant implementation.  We don't need a full cpumask_t to
describe it.

> also there might be hardware that can only route a given IRQ to a subset 
> of CPUs. While setting set_affinity allows the irqbalance-daemon to 
> 'probe' this mask, it's a far from optimal API.

I agree, I am just arguing that adding another awkward interface to
the current situation does not really make the situation better, and
it increases our support burden.

For a bunch of this it is arguable that the way to go is simply to
parse the irq type in /proc/interrupts.  All of the really weird cases
will have a distinct type there.  This certainly captures the MSI-X
case.  There is still a question of how to handle the NUMA case but...

Eric

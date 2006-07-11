Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWGKUIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWGKUIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWGKUIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:08:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63898 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751213AbWGKUIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:08:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH] i386 kexec:  Allow the kexec on panic support to compile on voyager.
References: <20060711123017.5F15A3403D@koto.vergenet.net>
Date: Tue, 11 Jul 2006 14:07:24 -0600
In-Reply-To: <20060711123017.5F15A3403D@koto.vergenet.net>
	(horms@verge.net.au's message of "Tue, 11 Jul 2006 21:30:17 +0900
	(JST)")
Message-ID: <m1ejwrgb2b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms <horms@verge.net.au> writes:

> On Mon, 10 Jul 2006 16:37:49 -0600, Eric W. Biederman wrote:
>> 
>> This patch removes the foolish assumption that SMP implied local
>> apics.  That assumption is not-true on the Voyager subarch.  This
>> makes that dependency explicit, and allows the code to build.
>
> Doesn't only a small portion of the code in question rely
> on CONFIG_X86_LOCAL_APIC? Is just a workaround until proper
> voager support materialises?

Essentially, but it is correct for the code to stay this way.

>> What gets disabled is just an optimization to get better crash
>> dumps so the support should work if there is a kernel that will
>> initialization on the voyager subarch under those harsh conditions.
>
> By that do you mean, a crash kernel that is able to boot even
> though the non-crashing CPUs have not been shutdown?

I simply mean a crash kernel that is able to boot.

>> Hopefully we can figure out how to initialize apics in init_IRQ
>> and remove the need to disable io_apics and this dependency.
>
> That does sound nice. Do you have any ideas on how that could be 
> made to happen?

My patch for that got reverted because it wouldn't boot on Linus's
SMP laptop.  It appeared to be some weird ACPI problem.  I didn't
receive any bug reports otherwise.

So I suspect the steps are:
1) Unify SMP and non-SMP apic initialization so it is the exact same
   code.
2) Move the unified code up in the boot sequence into init_IRQs.

It is something that needs to be done very delicately.

Eric

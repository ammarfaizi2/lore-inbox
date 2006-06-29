Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWF2Akj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWF2Akj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWF2Akj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:40:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40853 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932097AbWF2Aki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:40:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: [2.6 patch] i386: KEXEC must depend on (!SMP && X86_LOCAL_APIC)
References: <20060628165533.GJ13915@stusta.de>
	<m14py5fajw.fsf@ebiederm.dsl.xmission.com>
	<20060628204922.GM13915@stusta.de>
Date: Wed, 28 Jun 2006 18:40:05 -0600
In-Reply-To: <20060628204922.GM13915@stusta.de> (Adrian Bunk's message of
	"Wed, 28 Jun 2006 22:49:22 +0200")
Message-ID: <m1sllodcbe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Wed, Jun 28, 2006 at 11:35:15AM -0600, Eric W. Biederman wrote:
>> 
>> Adrian Bunk <bunk@stusta.de> writes:
>> > This patch fixes the following issue with CONFIG_SMP=y and 
>> > CONFIG_X86_VOYAGER=y:
>> >
>> > <--  snip  -->
>> >
>> > ...
>> >   CC      arch/i386/kernel/crash.o
>> > arch/i386/kernel/crash.c: In function ‘crash_nmi_callback’:
>> > arch/i386/kernel/crash.c:113: error: implicit declaration of function
>> > ‘disable_local_APIC’
>> >
>> > <--  snip  -->
>> 
>> I think the patch below more correctly captures the dependency.
>> 
>> In truth that call to disable_local_APIC() is a bug but the kernel
>> isn't ready yet to boot in apic only mode, so it remains until
>> the apic initialization can be moved into init_IRQ.
>> 
>> Does this sound good?
>
> It does compile (I can't test it due to lack of hardware).

The code that is disabled is really an optimization to get a higher
quality crash dump so we should be ok.

At the very least it should come very close to working for anyone on
that subarch.

Eric

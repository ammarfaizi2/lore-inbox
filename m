Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVJDQC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVJDQC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVJDQC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:02:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35036 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964836AbVJDQC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:02:56 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH 1/2] x86_64 nmi_watchdog: Make check_nmi_watchdog static
References: <m17jct8ggh.fsf@ebiederm.dsl.xmission.com>
	<200510041721.09736.ak@suse.de>
	<m1y859716y.fsf@ebiederm.dsl.xmission.com>
	<200510041732.07007.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 10:01:28 -0600
In-Reply-To: <200510041732.07007.ak@suse.de> (Andi Kleen's message of "Tue,
 4 Oct 2005 17:32:06 +0200")
Message-ID: <m1ll196zl3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 04 October 2005 17:26, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> > On Tuesday 04 October 2005 17:11, Eric W. Biederman wrote:
>> >> By using a late_initcall as i386 does we don't need to call
>> >> check_nmi_watchdog manually after SMP startup, and we don't
>> >> need different code paths for SMP and non SMP.
>> >>
>> >> This paves the way for moving apic initialization into init_IRQ,
>> >> where it belongs.
>> >
>> > I don't like it. I want to see a clear message in the log when
>> > the NMI watchdog doesn't work and with your patch that comes too late.
>>
>> Why is it to late?
>
> It's after too much of the boot. e.g. consider analyzing log with a boot hang.
> It's important to know if the NMI watchdog runs or not. For that it is
> best when the test of it happens as early as possible.

That make sense.

>> > -Andi (who has rejected similar patches before)
>>
>> Would it be more appropriate to make this a per cpu check?
>
> That would be fine as long as it's as early as possible.
> But I suspect you'll always need special cases for the BP
> because it needs the timer running first.

Well a special call site certainly but I can probably get away
with a single function called from the appropriate CPU.  I
might even be able to remove nmi_cpu_busy :)

It will take me a bit to get my head back into that part of the
code.  late_initcall was a nice solution from a correctness
and simplicity point of view.  But obviously it had other issues :)

There is the whole late_timer_init() which is probably where
the test needs to happen for the boot processor.

Eric

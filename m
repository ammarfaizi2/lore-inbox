Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVFOAlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFOAlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFOAlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:41:18 -0400
Received: from smtp-auth.no-ip.com ([8.4.112.95]:26591 "HELO
	smtp-auth.no-ip.com") by vger.kernel.org with SMTP id S261448AbVFOAlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:41:12 -0400
From: dagit@codersbase.com
To: Pavel Machek <pavel@suse.cz>
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: [ACPI] Resume from Suspend to RAM))
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz>
	<87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz>
	<87u0k061jx.fsf@www.codersbase.com> <20050614220911.GD2172@elf.ucw.cz>
	<87oea860rl.fsf@www.codersbase.com> <20050614231115.GE2172@elf.ucw.cz>
Organization: Coders' Base
Date: Tue, 14 Jun 2005 17:41:05 -0700
In-Reply-To: <20050614231115.GE2172@elf.ucw.cz> (Pavel Machek's message of
 "Wed, 15 Jun 2005 01:11:15 +0200")
Message-ID: <87ekb45u5a.fsf@www.codersbase.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-REPORT-SPAM-TO: abuse@no-ip.com
X-NO-IP: codersbase.com@noip-smtp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> >> >> Do you mean try something like this? Replace the push 0 with push
>> >> >> 0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
>> >> >> causes the reboot?
>> >> >
>> >> > Yep, try pushl $0, popl %eax; if that causes problems, something is
>> >> > seriously wrong with stack, otherwise changing flags hurts.
>> >> 
>> >> pushl $0, popl %eax gets the reboot.  So it's changing the flags that
>> >> is bad?
>> >> 
>> >> What should we try next?
>> >
>> > ??? You wanted it to reboot? If not, something is wrong with
>> > stack. Not sure whats next.
>> 
>> I don't want it to reboot, I guess I got confused.  As you say, maybe
>> something is wrong with the stack.  It's weird that something would be
>> wrong with the stack, because the other test to check the
>> suspend/resume code path works like a charm, the machine will do the
>> fake suspend/resume just fine.
>
> Well, we set up stack few instructions before that. But we do it in
> quite a complicated way; could you just put stack at 0x00:0x200 or
> something like that? Also test if push alone is enough to kill it.

Could you send me the code you want me to test, I'd don't know enough
asm to move the stack.  I tried replacing the line with the comment
about the ASUS board private stack with a line like, "mov $0x200,
%sp", but I don't understand it.

As for check about the push alone causing the reboot, I removed the
pop, and it still reboots, but to me that doesn't say that it's the
push that does it.  It could be the next line.  I'll try to put in an
infinite loop.

Thanks,
Jason


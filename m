Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933054AbWKMT7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbWKMT7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbWKMT7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:59:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61667 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1755241AbWKMT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:59:39 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Andi Kleen <ak@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
References: <20061113162135.GA17429@in.ibm.com>
	<200611131822.44034.ak@suse.de> <20061113175947.GA13832@in.ibm.com>
	<200611131913.32073.ak@suse.de>
	<m14pt3qhjy.fsf@ebiederm.dsl.xmission.com>
	<20061113193447.GB13832@in.ibm.com>
Date: Mon, 13 Nov 2006 12:57:02 -0700
In-Reply-To: <20061113193447.GB13832@in.ibm.com> (Vivek Goyal's message of
	"Mon, 13 Nov 2006 14:34:47 -0500")
Message-ID: <m1odrbp1bl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Nov 13, 2006 at 12:21:05PM -0700, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> 
>> >> This code (verify_cpu) is called while we are still in real mode. So it has
>> >> to be present in low 1MB. Now in trampoline has been designed to switch to
>> >> 64bit mode and then jump to the kernel hence kernel can be loaded anywhere
>> >> even beyond (4G). So if we move this code into say
> arch/x86_64/kernel/head.S
>> >> then we can't even call it.
>> >
>> > I didn't mean to call it. Just #include it from a common file
>> 
>> I believe the duplication winds up happening in setup.S
>> 
>
> Yes. So boot cpu code in setup.S is also doing these checks. So one 
> of the options is that I create a new file says verify_cpu.S and this
> code can be shared by setup.S, trampoline.S and wakeup.S.
>
> Or, I can simply drop the verify_cpu bit from trampoline.S and wakeup.S.
> This looks like a non-essential bit and in the past we did not perform
> these checks in trampoline.S and wakeup.S

We do it head.S instead.  Although the version in head.S is less
complete.

> At this point of time, I will prefer to go with second option of dropping
> extended checks in trampoline.S and wakeup.S to keep things simple.
>
> Does that make sense?

I think just making an arch/x86_64/kernel/verify_cpu.S that can
be included from setup.S wakeup.S and trampoline.S will be just
an exercise in code motion.  It provides a good sanity check in
case things are hideously wrong.

If we are looking at more then code motion then it make sense to
reevaluate and probably drop the code.

Deduping this code path makes a lot of sense.

Eric



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbWHAL3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWHAL3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWHAL3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:29:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21916 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932646AbWHAL3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:29:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jan Kratochvil <lace@jankratochvil.net>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060731202520.GB11790@in.ibm.com>
	<20060731210050.GC11790@in.ibm.com>
	<m18xm9425s.fsf@ebiederm.dsl.xmission.com>
	<20060801042528.GA19157@host0.dyn.jankratochvil.net>
	<m1bqr43jqv.fsf@ebiederm.dsl.xmission.com>
	<20060801094351.GA25944@host0.dyn.jankratochvil.net>
Date: Tue, 01 Aug 2006 05:28:13 -0600
In-Reply-To: <20060801094351.GA25944@host0.dyn.jankratochvil.net> (Jan
	Kratochvil's message of "Tue, 1 Aug 2006 11:43:51 +0200")
Message-ID: <m1bqr41yr6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kratochvil <lace@jankratochvil.net> writes:

> So you rather crash than running in that unmeasurably lower performance?

No simply I would rather not boot than run something I'm not certain will
work.  If we align things deliberately for better performance I don't
want to cope with that either.

> ...
>> I'm not terribly comfortable with the 8K alignment number as we only
>> tell the linker we need 4K alignment.
>
> Yes, it should be fixed there so that the stacks get allocated 8KB-aligned not
> depending on the kernel code position at all.  That means allocating the
> initial stack by code and not relying on its autoallocation by the linker.
> There would remain the 4KB alignment requirement due to the physical target
> address of the pagetable entries.

So thinking about this.  By processing relocations we end up with
no page table related relocation restrictions except that we must be
within the identity mapped page table area.  Not even the 4KB is
directly a page table related alignment restriction.

So the right answer is to review the arch/i386 kernel and make certain
we don't have any implicit alignment requirements, (and if we do
making them explicit so the linker will honor and report them).  At
which point all I need to do is to copy the required alignment from
vmlinux to the ELF header of the bzImage.

>> > ( I did not check your patches as they are locked in that useless GIT
> anyway. )

For code review sending patches is still the best way to do it.
Patches in email are easier to comment on, and require less work
for people to actually look at.  So since you have complained
I have sent out all of the patches.

My evil plan is to keep making interesting things available in GIT
until it is no longer considered useless :)

Eric


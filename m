Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWFUOJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWFUOJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFUOJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:09:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33507 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750719AbWFUOJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:09:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 11/25] i386 irq:  Dynamic irq support
References: <11508425191063-git-send-email-ebiederm@xmission.com>
	<1150842520235-git-send-email-ebiederm@xmission.com>
	<11508425201406-git-send-email-ebiederm@xmission.com>
	<1150842520775-git-send-email-ebiederm@xmission.com>
	<11508425213394-git-send-email-ebiederm@xmission.com>
	<115084252131-git-send-email-ebiederm@xmission.com>
	<11508425213795-git-send-email-ebiederm@xmission.com>
	<11508425222427-git-send-email-ebiederm@xmission.com>
	<20060620185015.F10402@unix-os.sc.intel.com>
	<m1mzc79rlf.fsf@ebiederm.dsl.xmission.com>
	<20060620192734.G10402@unix-os.sc.intel.com>
Date: Wed, 21 Jun 2006 08:07:49 -0600
In-Reply-To: <20060620192734.G10402@unix-os.sc.intel.com> (Rajesh Shah's
	message of "Tue, 20 Jun 2006 19:27:34 -0700")
Message-ID: <m1lkrq7gay.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah <rajesh.shah@intel.com> writes:

> On Tue, Jun 20, 2006 at 08:21:00PM -0600, Eric W. Biederman wrote:
>> Rajesh Shah <rajesh.shah@intel.com> writes:
>> 
>> > It would be really good to decouple MSI implementation from IO
>> > APICs, since there's really no real hardware dependence here.
>> > This code can actually go to arch/xxx/pci/msi-apic.c
>> 
>> I agree in theory.  In practice however msi interrupts look like io_apics.
>> with a different register set and the use all of the same support facilities.
>> So until that part of the architecture is refactored it doesn't make much
>> sense.  There is a slightly better case for moving the code into a separate
>> file.  Namely I think I know of a second common implementation for x86_64.
>> At which point the files will probably be named msi-intel.c and msi-amd.c
>> Or something like that.  
>> 
> Actually, I meant just the vector tracking code could be in a
> separate file and the ioapic and msi code could both assign
> vectors from a common routine. I had the patch below in my
> patchkit, plus another patch for x86_64 to do the same thing
> in io_apic.c and share the same intrvec.c file between the 
> two archs. Once you have this, the MSI callbacks in arch
> code can be moved out of io_apic.c

Well irq.c is probably the obvious place to put it.

But that goes way beyond small obviously correct steps.
So there is no way I'm going to include a change like
that in the middle of my patchset because it is unnecessary.

Doing this kind of thing later is certainly sane.

I guess this is a difference in focus.  You have been focused
on code cleanup.  I have been focused on breaking the unnatural tying
between parts of the code.

As for this specific patch it makes no sense to only move half
of assign_irq_vector to a different file.

Eric

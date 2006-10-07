Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWJGQzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWJGQzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWJGQzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 12:55:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51359 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751238AbWJGQzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 12:55:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
Date: Sat, 07 Oct 2006 10:52:24 -0600
In-Reply-To: <20061007080315.GM14186@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Sat, 7 Oct 2006 10:03:15 +0200")
Message-ID: <m14pugxe47.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <muli@il.ibm.com> writes:

> On Fri, Oct 06, 2006 at 05:42:40PM -0600, Eric W. Biederman wrote:
>
>> If I read your bootlog right. You have logical cpus, but only two
>> sockets, and I think only two cores.  The other two logical cpus
>> being hyperthreaded.
>
> Yes, 2 sockets each of which is HT. Here's a /proc/cpuinfo from a
> distro kernel:

Ok.  From looking at an individual case the ioapic is programmed
correctly and I don't see a reason the local apic would be programmed
incorrectly.  However logical delivery mode and lowest priority
delivery mode are enabled.  So we are asking the interrupt delivery
subsystem to choose a cpu to deliver the interrupt to and then are not
giving the cpu any choice.  So we may be confusing things. 

Can you try CONFIG_CPU_HOTPLUG?  That will force genapic to be set
to genapic_physflat instead of genapic_flat.

I am hoping that by running the apics in a different delivery mode
that explicitly says just deliver this interrupt to this cpu we
will avoid the problem you are seeing.

If genapic_physflat works we will have to decide what to do about
genapic_flat.

Thanks,

Eric

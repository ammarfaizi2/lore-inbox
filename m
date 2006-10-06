Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWJFSMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWJFSMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWJFSMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:12:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932449AbWJFSMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:12:20 -0400
Date: Fri, 6 Oct 2006 11:08:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
 handle IRQ -1"
In-Reply-To: <m1hcyh1hqz.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0610061102010.3952@g5.osdl.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
 <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0610060855220.3952@g5.osdl.org>
 <m1hcyh1hqz.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Eric W. Biederman wrote:
> 
> Forcing irqs to specific cpus is not something this patch adds.  That
> is the way the ioapic routes irqs.

What that patch adds is to make it an ERROR if some irq goes to an 
unexpected cpu.

And that very much is wrong. 

> Yes.  A single problem over several months of testing has been found.

Umm. It got found the moment it became part of the standard tree.

The fact is, "months of testing" is not actually very much, if it's the 
-mm tree. That's at best a "good vetting", but it really doesn't prove 
anything.

> So this is fairly fundamentally an irq migration problem.  If you
> never change which cpu an irq is pointed at you don't have problems,
> as there are no races.

So? Does that change the issue that this new model seems inherently racy?

> The current irq migration logic does everything in the irq handler
> after an irq has been received so we can avoid various kinds of races.

No. You don't understand, or you refuse to face the issue.

The races are in _hardware_, outside the CPU. The fact that we do things 
in an irq handler doesn't seem to change a lot.

And what do you intend to do if it turns out that the reason it doesn't 
work on x366 is that the _hardware_ just is incompatible with your model?

I'm not saying that's the case, and maybe there's some stupid bug that has 
been overlooked, and maybe it can all work fine. But the new model _does_ 
seem to be at least _potentially_ fundamentally broken.

			Linus

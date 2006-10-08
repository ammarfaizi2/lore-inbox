Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWJHNlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWJHNlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWJHNlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:41:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50658 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751129AbWJHNlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:41:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Muli Ben-Yehuda <muli@il.ibm.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86_64 irq fixes
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
	<m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	<20061007175926.GN14186@rhun.haifa.ibm.com>
Date: Sun, 08 Oct 2006 07:39:38 -0600
In-Reply-To: <20061007175926.GN14186@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Sat, 7 Oct 2006 19:59:26 +0200")
Message-ID: <m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <muli@il.ibm.com> writes:

> On Sat, Oct 07, 2006 at 10:52:24AM -0600, Eric W. Biederman wrote:
>
>> Can you try CONFIG_CPU_HOTPLUG?  That will force genapic to be set
>> to genapic_physflat instead of genapic_flat.
>
> Yep, it boots with CONFIG_CPU_HOTPLUG!
>
>> If genapic_physflat works we will have to decide what to do about
>> genapic_flat.
>
> I'm happy to test any follow-on patches to make it work without
> CONFIG_CPU_HOTPLUG.

Ok.  I have found a fairly clean way to structure the code that
should restore the previous behavior of the genapic_flat allowing
lowest priority interrupt delivery to work, and getting lucky
and avoiding your hardware that does not do what the software
tells it to :)

I still need to dig in and remove the BUG_ON in the interrupt
reception path, but that is a separate problem.

I also found another small bug in the pci_enable_irq because
of some code I failed to remove earlier, and the patches overlap
so I have made this a small patch series.

I have tested the code as best I can, and confirmation that this
fixes the original problem would be great.  But I don't see how
it could fail to fix the problem, as it restores genapic_flat to
global vector allocation.

Eric

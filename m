Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUFDQEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUFDQEC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUFDQEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:04:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:57230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265874AbUFDQCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:02:43 -0400
Date: Fri, 4 Jun 2004 09:02:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andy Lutomirski <luto@myrealbox.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
In-Reply-To: <20040604155138.GG16897@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de>
 <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com>
 <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
 <20040604154142.GF16897@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
 <20040604155138.GG16897@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jun 2004, Arjan van de Ven wrote:
> 
> I know that in a FC1 full install there are less than 5 binaries that don't
> run with NX. (one uses nested functions in C and passes function pointers to
> the inner function around which causes gcc to emit a stack trampoline, and
> gcc then marks the binary as non-NX, the others have asm in them that we
> didn't fix in time to be properly marked).

If things are really that good, why are we even worrying about this?

It sounds like we should just have NX on by default even for executables
that don't have any NX info records, and have some way of marking the
(very few) executables that don't want it. Maybe have the NX fault print a
warning when it happens for an executable that defaulted to NX on.

I think most people have seen the security disaster that causes most of
the emails on the net to be spam. So this should be _trivial_ to explain
to people when they complain about default behaviour breaking their
strange legacy app. Especially if there's a trivial tool to add an elf
section to make it work again.

So instead of having complex things to try to turn NX on for suid, we 
should aim to turn ot on as widely as possible, _even_if_ that means that 
people who upgrade hardware might have to do some trivial MIS stuff.

Make a kernel bootup option to default to legacy mode if somebody
literally has trouble booting and fixing their thing due to "init" or
similar being one of the problematic cases. Together with a printk() that 
says which executable triggered, it should be trivial to clean up a 
system.

No?

		Linus

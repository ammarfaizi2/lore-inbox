Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTESMSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTESMSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:18:36 -0400
Received: from boden.synopsys.com ([204.176.20.19]:54412 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S262429AbTESMSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:18:32 -0400
Date: Mon, 19 May 2003 14:31:19 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: mikpe@csd.uu.se
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030519123119.GA20385@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <200305191216.h4JCGONj015081@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305191216.h4JCGONj015081@harpo.it.uu.se>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikpe@csd.uu.se, Mon, May 19, 2003 14:16:24 +0200:
> On Wed, 14 May 2003 11:48:13 +0200, Alex Riesen wrote:
> >I have an old Compaq Armada 1592DT. The thing goes automagically into
> >suspend mode after being forgotten for a while. And there is this button
> >to wake it up (the blue one, above the keyboard).
> >
> >Last time i tried to wake it up it produced the attached oops.
> >"Unknown key"s are probable the blue button.
> >After printing out the oops, the system went back into suspend.
> >
> >-alex
> >
> >Suspending devices
> >Suspending device c03219ac
> >Unable to handle kernel NULL pointer dereference at virtual address 00000090
> > printing eip:
> >c011459f
> >*pde = 00000000
> >Oops: 0000 [#1]
> >CPU:    0
> >EIP:    0060:[<c011459f>]    Not tainted
> >EFLAGS: 00010202
> >EIP is at fix_processor_context+0x5f/0x100
> >eax: 0000007c   ebx: c5f0e000   ecx: 00000002   edx: 00000000
> >esi: 00000060   edi: 00000000   ebp: c5f0ff5c   esp: c5f0ff54
> >ds: 007b   es: 007b   ss: 0068
> >Process kapmd (pid: 4, threadinfo=c5f0e000 task=c5fbc640)
> 
> After receiving Alex' .config and gcc version (3.2.3), I've been
> able to decipher this. current->mm is NULL in the kapmd task. The call
> 
> 	load_LDT(&current->mm->context);	/* This does lldt */
> 
> in fix_processor_context() computes the address of context as
> (current->mm)+0x7c, which is 0x7c. load_LDT_nolock() dereferences
> 0x7c+0x14 (void *segments = pc->ldt) and the oops follows.
> 
> As to _why_ kapmd's current->mm is NULL, I don't know. It isn't
> when I test APM suspend in 2.5.69-bk. A lot of code dereferences
> current->mm without checking, so I guess current->mm==NULL is a bug.
> 

i just go and try it with the latest -bk.

-alex


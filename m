Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbQLGXJD>; Thu, 7 Dec 2000 18:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130349AbQLGXIy>; Thu, 7 Dec 2000 18:08:54 -0500
Received: from [64.64.109.142] ([64.64.109.142]:8457 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S130012AbQLGXIl>;
	Thu, 7 Dec 2000 18:08:41 -0500
Message-ID: <3A301106.D58DCB2E@didntduck.org>
Date: Thu, 07 Dec 2000 17:36:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: richardj_moore@uk.ibm.com, Andi Kleen <ak@suse.de>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Why is double_fault serviced by a trap gate?
In-Reply-To: <Pine.LNX.3.95.1001207163133.3136A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 7 Dec 2000 richardj_moore@uk.ibm.com wrote:
> 
> >
> >
> > Which surely we can on today's x86 systems. Even back in the days of OS/2
> > 2.0 running on a 386 with 4Mb RAM we used a taskgate for both NMI and
> > Double Fault. You need only a minimal stack - 1K, sufficient to save state
> > and restore ESP to a known point before switching back to the main TSS to
> > allow normal exception handling to occur.
> >
> > There no architectural restriction that some folks have hinted at - as long
> > as the DPL for the task gates is 3.
> >
> [SNIPPED...]
> 
> Please refer to page 6-16, Inter486 Microprocessor Family Programmer's
> Reference Manual.
> 
> The specifc text is: "The TSS does not have a stack pointer for a
> privilege level 3 stack, because the procedure cannot be called by a less
> privileged procedure. The stack for privilege level 3 is preserved by the
> contents of SS and EIP registers which have been saved on the stack
> of the privilege level called from level 3".
> 
> What this means is that a stack-fault in level 3 will kill you no
> matter how cute you try to be. And, putting a task gate as call
> procedure entry from a trap or fault is just trying to be cute.
> It's extra code that will result in the same processor reset.

No, because the CPL of the task gate would be 0, which means the stack
will be set to tss->esp0.  The DPL of 3 means that the descriptor can be
accessed from CPL3.  The text you mention generally means that the only
way to get back to CPL3 is with iret (via the saved %cs:%eip and
%ss:%esp pushed on the CPL0/1/2 stack).

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

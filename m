Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132494AbRAIXEH>; Tue, 9 Jan 2001 18:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbRAIXD5>; Tue, 9 Jan 2001 18:03:57 -0500
Received: from [64.64.109.142] ([64.64.109.142]:24850 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S132117AbRAIXDk>; Tue, 9 Jan 2001 18:03:40 -0500
Message-ID: <3A5B98AB.9B6FABC6@didntduck.org>
Date: Tue, 09 Jan 2001 18:03:07 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: rob@sysgo.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01010922090000.02630@rob> <01010922264400.02737@rob> <3A5B86C1.41DDB11B@didntduck.org> <01010923324500.02850@rob>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kaiser wrote:
> 
> On Die, 09 Jan 2001 you wrote:
> > Robert Kaiser wrote:
> > >
> > > On Die, 09 Jan 2001 you wrote:
> > > > Robert Kaiser wrote:
> > > > > I can't seem to get the new 2.4.0 kernel running on a 386 CPU.
> > > > > The kernel was built for a 386 Processor, Math emulation has been enabled.
> > > > > I tried three different 386 boards. Execution seems to get as far as
> > > > > pagetable_init() in arch/i386/mm/init.c, then it falls back into the BIOS as
> > > > > if someone had pressed the reset button. The same kernel boots fine on
> > > > > 486 and Pentium Systems.
> > >  ..... The last thing I see is
> > > "Uncompressing Linux... Ok, booting the kernel." I have added some
> > > quick and dirty debug code that writes messages directly to the VGA
> > > screen buffer. According to that, execution seems to get as far as the
> > > statement
> > >
> > >         *pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
> > >
> >
> > Could it be possible that memory size is being misdetected?  Try mem=8M
> > (or less) on the command line.  Try to catch the value of pte when it
> > crashes.
> 
> I tried "mem=4M" -- no effect. The value of pte is 0xc0001000, so it seems
> to be the first invocation of that statement in the for() loop.
> 
> Now comes the amazing (to me) part: I split the above statement up into:
> 
>         temp = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
>         *pte = temp;
> 
> where temp is declared "volatile pte_t". I inserted test-prints between the
> above two lines. Accoding to that, the _first_ line , i.e. the evaluation of the
> mk_pte_phys() macro is causing the crash!
> 
> I am still trying to figure out what mk_pte_phys() does. Apparently it involves
> an access to the kernel's data section. My current guess is that the data
> section is not correctly mapped at this point. Would that be possible ?

How much physical memory does this box really have?

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

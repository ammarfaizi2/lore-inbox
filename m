Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277347AbRJ3SXB>; Tue, 30 Oct 2001 13:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRJ3SWw>; Tue, 30 Oct 2001 13:22:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:39657 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277347AbRJ3SWr>; Tue, 30 Oct 2001 13:22:47 -0500
Date: Tue, 30 Oct 2001 10:19:01 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] making the printk buffer bigger 
Message-ID: <3709761319.1004437141@mbligh.des.sequent.com>
In-Reply-To: <Pine.GSO.3.96.1011030135941.6694E-100000@delta.ds2.pg.gda.pl>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, seeing as people don't seem to want a decent size buffer on 
>> CONFIG_SMP machines, could we at least do it under
>> CONFIG_MULTIQUAD? Loosing half my boot time messages is 
>> annoying, and I have gigabytes of RAM to waste. Please .......
> 
>  Hmm, and what exactly does prevent you from applying the patch privately
> for the time you are needing it for developent?

I don't just want it for development, I believe in capturing my boot messages 
all the time. If they're not visible, why bother printing them?

Why not just keep it as a patch? Partly the fact that it's a pain in the butt, 
and I keep forgetting to do it. In principle I think the default buffer ought 
to big enough to cope with the boot messages we put out. There's more 
messages on larger systems, hence it makes sense to have a larger buffer. 
Switching on CONFIG_SMP or CONFIG_MULTIQUAD is a crude 
approximation to estimating the size of boot messages. 

The correct solution is probably to either size it dynamically, or have a
seperate boot time buffer that we throw away afterwards. But for the 
sake of another 48Kb on machines with 2 - 16Gb of RAM, it's not worth
coding it, testing it, and risking the change.

M.

PS. Alan's solution was to turn off half the garbage that gets printed on
boot, which would work too. Especially half the stuff from the mps tables,
which we throw in the bin 2 nanoseconds after printing it. We could
turn off APIC_DEBUG by default, which would kill all the Dprintk's as
far as I can see ....




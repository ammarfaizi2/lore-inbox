Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUEJPFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUEJPFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbUEJPFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:05:49 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:1262 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S264728AbUEJPFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:05:46 -0400
Date: Mon, 10 May 2004 17:05:27 +0200 (METDST)
From: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>
Reply-To: a.verweij@student.tudelft.nl
To: Ross Dickson <ross@datscreative.com.au>
cc: cbradney@zip.com.au, Ian Kumlien <pomac@vapor.com>,
       <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       <christian.kroener@tu-harburg.de>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
In-Reply-To: <200405102137.11468.ross@datscreative.com.au>
Message-ID: <Pine.GHP.4.44.0405101659320.6908-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the 2.6.6 Changelog section about nforce2 imply that Ross' Patches of
Stability are no longer required? I don't read lkml regularely, so this
would be new for me.

Anyway, if this works (tm) I am very happy. Will attempt to test it later
on, even though I have Maxtor 8MB discs :)

Regards,

Arjen

<B.Zolnierkiewicz@elka.pw.edu.pl>
	[PATCH] fixup for C1 Halt Disconnect problem on nForce2 chipsets

	Based on information provided by "Allen Martin" <AMartin@nvidia.com>:

	A hang is caused when the CPU generates a very fast CONNECT/HALT
	cycle sequence.  Workaround is to set the SYSTEM_IDLE_TIMEOUT to
	80 ns. This allows the state-machine and timer to return to a
	proper state within 80 ns of the CONNECT and probe appearing
	together.  Since the CPU will not issue another HALT within 80 ns
	of the initial HALT, the failure condition is avoided.


On Mon, 10 May 2004, Ross Dickson wrote:

> Craig Bradney wrote
>
> >Well.. 2.6.6 is released.. and THANK YOU Linus and all the patch
> > writers.. we have nforce2 fixes in the released kernel now. I'm just
> > waiting for a gentoo-dev-sources release now..
> >
> >
> >
> >Craig
>
> MOMENT PLEASE.
> ALMOST complete nforce2 support. Job not done yet.
>
> Unfortunately 2.6.6 still has the old check_timer code which inhibits
> nmi_watchdog=1 on all nforce2 from working by having timer_ack=1
> when checking io-apic pit routing.
>
> It is a hardware issue - NOT A BUGGY BIOS ISSUE inside the integrated
> nforce2 interrupt routing.
>
> To my understanding IT WILL NEVER BE FIXED BY A BIOS REVISION and
> after reading the 8259 datasheets I think it is a mistake within the
> existing code to have the timer_ack on there in the first place.
>
> I would still like to see Maciej's check_timer patch in the kernel. It was
> pulled after only a single user mobo complaint was posted yet it helps
> both nforce2 and ibm bios pc's. To my knowledge little effort was made
> by that user to accomodate the patch - it was just outright pulled in spite
> of its benefit to others?
>
> Who do we ask to revisit this? Linus? the io-apic.c maintainer? or the one
> user with a complaint?
>
> That patch that was dropped by Linus? after appearing in 2.6.3-mm3.
> For those nforce2 users with problems of clock skew with the timer into pin0
> routing, that patch gave a virtual wire timer routing which worked well.
>
> It also works around serious problems for ibm users who also want it in.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/4421.html
>
> Regards
> Ross.
>
>
>


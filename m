Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUCIE3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 23:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUCIE3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 23:29:43 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:29162 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261519AbUCIE3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 23:29:41 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, Andi Kleen <ak@muc.de>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Tue, 9 Mar 2004 09:59:15 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
References: <1xpyM-2Op-21@gated-at.bofh.it> <m3hdwz9szt.fsf@averell.firstfloor.org> <20040308171831.GF15065@smtp.west.cox.net>
In-Reply-To: <20040308171831.GF15065@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403090959.15556.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 10:48 pm, Tom Rini wrote:
> On Mon, Mar 08, 2004 at 05:57:26PM +0100, Andi Kleen wrote:
> > Tom Rini <trini@kernel.crashing.org> writes:
> > > Here's where what Andi said about being able to get the pt_regs stuff
> > > off the stack (I think that's what he said at least) started to confuse
> > > me slightly.  But if I understand it right (and I never got around to
> > > testing this) we can replace the do_schedule() stuffs at least with
> > > something like kgdb_get_pt_regs(), since (and I lost my notes on this,
> > > so it's probably not quite right) (thread_info->esp0)-1
> >
> > No, that's the user space registers.
> >
> > You don't need these registers really as long as you have the
> > correct dwarf2 CFI description of all the code involved. gdb
> > is then able to reconstruct them using the C stack by itself.
> >
> > All it needs for that is esp and eip.
>
> Ah, OK.  Amit, how about for the expanded T-packet thing, we do what you
> suggested, except call it kgdb_arch_extra_regs() and let the arch fill
> out whatever regs it needs to.  ESP/EIP for x86_64/i386, PC/SP for
> ppc32, etc, etc?

That'll be great, though it won't provide any more info to gdb, as gdb can get 
that info by 'g' packet.

Thread listing problem is with 'g' packet returning incomplete information for 
threads other than the current thread.

-Amit


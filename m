Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUCHRSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUCHRSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:18:34 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:43694 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262253AbUCHRSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:18:33 -0500
Date: Mon, 8 Mar 2004 10:18:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040308171831.GF15065@smtp.west.cox.net>
References: <1xpyM-2Op-21@gated-at.bofh.it> <1xqXN-44F-13@gated-at.bofh.it> <1xr7w-4c4-9@gated-at.bofh.it> <1xrqW-4rh-51@gated-at.bofh.it> <1xuS8-83Q-11@gated-at.bofh.it> <m3hdwz9szt.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hdwz9szt.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 05:57:26PM +0100, Andi Kleen wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
> >
> > Here's where what Andi said about being able to get the pt_regs stuff
> > off the stack (I think that's what he said at least) started to confuse
> > me slightly.  But if I understand it right (and I never got around to
> > testing this) we can replace the do_schedule() stuffs at least with
> > something like kgdb_get_pt_regs(), since (and I lost my notes on this,
> > so it's probably not quite right) (thread_info->esp0)-1
> 
> No, that's the user space registers.
> 
> You don't need these registers really as long as you have the 
> correct dwarf2 CFI description of all the code involved. gdb
> is then able to reconstruct them using the C stack by itself.
> 
> All it needs for that is esp and eip.

Ah, OK.  Amit, how about for the expanded T-packet thing, we do what you
suggested, except call it kgdb_arch_extra_regs() and let the arch fill
out whatever regs it needs to.  ESP/EIP for x86_64/i386, PC/SP for
ppc32, etc, etc?

-- 
Tom Rini
http://gate.crashing.org/~trini/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUCIEgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 23:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUCIEgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 23:36:18 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:2283 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261541AbUCIEgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 23:36:16 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andi Kleen <ak@muc.de>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Tue, 9 Mar 2004 10:06:00 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
References: <1xpyM-2Op-21@gated-at.bofh.it> <1xuS8-83Q-11@gated-at.bofh.it> <m3hdwz9szt.fsf@averell.firstfloor.org>
In-Reply-To: <m3hdwz9szt.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403091006.00822.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 10:27 pm, Andi Kleen wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
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

Yes. But as things stand, gdb 6.0 doesn't show stack traces correctly with esp 
and eip got from switch_to and gas 2.14 can't handle i386 dwarf2 CFI. Do we 
want to enforce getting a CVS version of gdb _and_ gas to build kgdb? 
Certainly not.

Current kgdb has a dependency on gdb 6.0. My RH9 gdb (5.3.x) can't talk with 
kgdb and complains about too long [sf]ThreadInfo packets. I don't like that 
either, but gdb 6.x should be standard on all distributions based on 2.6 
kernels, so that's acceptable.

-Amit


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUBZOgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbUBZOe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:34:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:62848 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261840AbUBZOdy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:33:54 -0500
Date: Thu, 26 Feb 2004 09:35:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Wedgwood <cw@f00f.org>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
In-Reply-To: <20040226133959.GA19254@dingdong.cryptoapps.com>
Message-ID: <Pine.LNX.4.53.0402260913300.32691@chaos>
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com>
 <20040226133959.GA19254@dingdong.cryptoapps.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Chris Wedgwood wrote:

> On Wed, Feb 25, 2004 at 09:32:08PM -0800, Nakajima, Jun wrote:
>
> > Yes, "implementation specific" is one of the differences between
> > IA-32e and AMD64, i.e. that behavior is architecturally defined on
> > AMD64, but on IA-32e (as I posted):
>
> >   Near branch with 66H prefix:
> >     As documented in PRM the behavior is implementation specific and
> >     should avoid using 66H prefix on near branches.
>
>
> Not that it really matters that much --- but I'm curious to know why
> Intel made this decision?
>
> It seems really dumb to make such differences when Intel is already
> sorely lagging behind their competitor here, I would think given the
> circumstances Intel would try to be as compatible as possible on all
> fronts.
>
> I'd almost be nervous about getting an IA-32e CPU right now given that
> the AMD64 chips work just fine, have had lots of testing and there is
> plenty of code out there which is *known* to work reliably.
>

Errmm. The 0x66 prefix is used to change the implied register size
when using a register. It has nothing to do with a branch. It
can be used to cause the CPU to load the full-width of the
instruction pointer and the segment descriptor when transitioning
from 16-bit to 32-bit execution mode. This is an unconditional
jump immediate, instruction, not a branch. If it's used with a branch
instruction, near or far, the CPU should execute an "illegal operand
fault" (actually invalid opcode fault is the correct grammar since
neither AMD nor Intel make law).

Whether or not the CPU traps this invalid instruction is moot. No
compiler would emit junk like this and anybody horsing around with
an assembler deserves whatever they get, although you shouldn't
be able to smoke the CPU on a multi-user multitasking system because
it can be used as a DOS attack.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



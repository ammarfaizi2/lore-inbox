Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbTCJI2L>; Mon, 10 Mar 2003 03:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbTCJI2L>; Mon, 10 Mar 2003 03:28:11 -0500
Received: from AMarseille-201-1-1-111.abo.wanadoo.fr ([193.252.38.111]:9511
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262747AbTCJI2K>; Mon, 10 Mar 2003 03:28:10 -0500
Subject: Re: [patch] oprofile for ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@koffie.nl>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       o.oppitz@web.de, afleming@motorola.com, linux-kernel@vger.kernel.org
In-Reply-To: <3E6C0B93.5040205@koffie.nl>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
	 <1047032003.12206.5.camel@zion.wanadoo.fr> <1047061862.1900.67.camel@cube>
	 <1047136206.12202.85.camel@zion.wanadoo.fr>  <3E6C0B93.5040205@koffie.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047285491.19222.9.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Mar 2003 09:38:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 04:50, Segher Boessenkool wrote:
> Benjamin Herrenschmidt wrote:
> > Beware though that some G4s have a nasty bug that prevents
> > using the performance counter interrupt (and the thermal interrupt
> > as well).
> 
> MPC7400 version 1.2 and lower have this problem.
> 
>  > The problem is that if any of those fall at the same
> > time as the DEC interrupt, the CPU messes up it's internal
> > state and you lose SRR0/SRR1, which means you can't recover
> > from the exception.
> 
> But the worst that happens is that you lose that process, isn't
> it?  Not all that big a problem, esp. since the window in which
> this can happen is very small.

Well, you can also lose the kernel. We used to catch it with MOL
(since MOL increase the amount of DEC interrupts when running
within the virtual machine) quite easily.
Fortunately, the MOL kernel engine would then figure out that
something was wrong, bail out killing the emulator properly and
give useful error messages. So at that time, we could find the
problem before it beeing documented.

Ben.


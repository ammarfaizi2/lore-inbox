Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSA0VSb>; Sun, 27 Jan 2002 16:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288686AbSA0VSV>; Sun, 27 Jan 2002 16:18:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288716AbSA0VSF>; Sun, 27 Jan 2002 16:18:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PCI #LOCK assertion
Date: 27 Jan 2002 13:18:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a31qqb$ur4$1@nell.transmeta.com>
In-Reply-To: <F4T0giSftNtzsG06vdG0001152a@hotmail.com> <Pine.LNX.3.95.1020125132236.1362A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1020125132236.1362A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> On Intel machines, you precede a memory access with the 'lock'
> instruction. With CPUs i486, and later, only the accessed page
> is locked at that instant. Earlier CPUs locked the whole bus.
> 
> The PCI/Bus controller handles the #LOCK signal itself to guarantee
> the atomicity of a transaction. You should never have to do this
> yourself. If you think you have to, just precede each PCI/Bus
> address-space access with the 'lock' instruction. You just make
> your own version of the readl/readw/readb/etc macros that are
> provided. You may find that this deadlocks, though, and all bets
> are off. You may have just locked the PCI/Bus off the bus when
> you needed it most!!
> 

LOCK on readl/readw/etc is meaningless (might even be an error).  The
*only* case when the lock matters is when transferring
read/modify/write transactions such as "inc", "add", "xchg" (the
latter locks automatically.)

In practice, LOCK# on the PCI bus is so poorly supported that you
can't rely on it anyway (and it causes deadlocks.)  A number of
motherboards have been known not even to wire it up.  LOCK is still
needed for SMP coherency, however.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

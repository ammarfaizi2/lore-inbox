Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSHLIrq>; Mon, 12 Aug 2002 04:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSHLIrk>; Mon, 12 Aug 2002 04:47:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:395 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317598AbSHLIr0>;
	Mon, 12 Aug 2002 04:47:26 -0400
Date: Mon, 12 Aug 2002 12:49:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <julliard@winehq.com>, <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-C3
In-Reply-To: <1029146896.16216.113.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208121246340.2955-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Aug 2002, Alan Cox wrote:

> > No. The problem is that there are some BIOS's that contain code that (even
> > though they are called in protected mode) load 0x40 into ds and expect to
> > be able to reference stuff ...  Causes really interesting OOPSs :-(
> 
> Which does mean you can steal the old TLS value and put it back across
> the calls just by changing the TLS data for that process. For that
> matter on Windows emulation I thought Windows also needed 0x40 to be the
> same offset as the BIOS does so can't we leave it hardwired ?

i have no problem with hardwiring it (and excluding it from the TLS
allocation/setting syscalls) - in fact i almost did it that way. The
question is, is the required descriptor format 100% the same for all APM
variants, Wine and Windows and DOS emulators? It would suck if we had a
bad descriptor and also removed the ability of Wine to trap 0x40 access.

but, couldnt APM use its own private GDT for real-mode calls, with 0x40
filled in properly? That would pretty much decouple things.

	Ingo


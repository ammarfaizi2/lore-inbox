Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSHLInU>; Mon, 12 Aug 2002 04:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSHLInU>; Mon, 12 Aug 2002 04:43:20 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5112 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317587AbSHLInT>; Mon, 12 Aug 2002 04:43:19 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, julliard@winehq.com, ldb@ldb.ods.org
In-Reply-To: <20020812182325.52324305.sfr@canb.auug.org.au>
References: <20020812173404.39d3abab.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0208121205170.2561-100000@localhost.localdomain> 
	<20020812182325.52324305.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 11:08:16 +0100
Message-Id: <1029146896.16216.113.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 09:23, Stephen Rothwell wrote:
> > you can save/restore 0x40 in kernel-space if you need to no problem.
> I guess I could around every BIOS call ...
> 
> Also, Alan (Cox) will say that's OK until he does APM on SMP on broken
> BIOS's :-)

SMP actually makes no difference. I have full SMP APM working on my test
boxes now. However pre-empt and SMP are the same problem space

> We could also just say that we no longer support those broken BIOS's ...
> 
> > so you are using the kernel's GDT in real mode as well?

Yes. APM calls are made by all sorts of processes.

> No. The problem is that there are some BIOS's that contain code that (even
> though they are called in protected mode) load 0x40 into ds and expect to
> be able to reference stuff ...  Causes really interesting OOPSs :-(

Which does mean you can steal the old TLS value and put it back across
the calls just by changing the TLS data for that process. For that
matter on Windows emulation I thought Windows also needed 0x40 to be the
same offset as the BIOS does so can't we leave it hardwired ?


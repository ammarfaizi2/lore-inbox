Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUEWMAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUEWMAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 08:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUEWMAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 08:00:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25099 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262634AbUEWL75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 07:59:57 -0400
Date: Sun, 23 May 2004 13:57:35 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@redhat.com>
Cc: Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
Message-ID: <20040523115735.GA16726@alpha.home.local>
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523110836.GE25746@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523110836.GE25746@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 07:08:36AM -0400, Alan Cox wrote:
> On Sun, May 23, 2004 at 10:29:12AM +0200, Willy Tarreau wrote:
> >     being emulated. I think it's already the case. He also said that I
> >     didn't take care of the segment selectors (such as SS) which some
> >     programs use perfectly legally (eg Wine). I don't know how to do
> >     that.
> 
> You have to parse all the valid header bytes (the opcode prefixes) that
> change segment, cause repeats and change sizes. DOSemu has a worked example
> of this particular set of horrors.

It's already what it does, but I don't use the segment base in the TSS nor
check the segment limit. It will take me quite some time to understand how
all this is implemented in the kernel and unfortunately I don't have such
time now.

> >   - why not include the CMOV emulation while we're at it ? There are so
> >     many people using VIA EDEN chips who think it's i686 compatible that
> >     they may get hit too. IIRC, the chip only executes CMOV on registers,
> >     but very slowly (a few tens of cycles), while register to memory
> >     accesses generate a trap.
> 
> gcc generates a lot of cmov on i686 so many that people I've talked with
> on the compiler side also feel cmov emulation isnt useful. Newer Eden btw
> has cmov.

agreed, but there are some programs which don't need speed at all, hence the
reason for my first implementation of cmov (which burnt about 400 cycles IIRC).

> > Other than that, I'm happy that someone found it useful, and happy too that
> > someone did the 2.6 port :-)
> 
> Is there a reason btw it can't be done with LD_PRELOAD ?

Well, this is an interesting question. I don't know how to do it this way
(how can a program know exactly where the trap occured, etc... I don't know
how to program this). Other than that, LD_PRELOAD will not work against setuid
binaries. But if it does for the rest, I think it can become an elegant
approach.

Thanks for your insights,
Willy


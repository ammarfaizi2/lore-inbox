Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUIBW6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUIBW6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUIBWzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:55:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:3756 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269189AbUIBWxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:53:38 -0400
Date: Thu, 2 Sep 2004 15:53:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tom Vier <tmv@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040902223557.GA15505@zero>
Message-ID: <Pine.LNX.4.58.0409021549430.2295@ppc970.osdl.org>
References: <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy>
 <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy>
 <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org>
 <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
 <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
 <20040902223557.GA15505@zero>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Tom Vier wrote:
>
> > Not user space. They may be "ring 3" from a CPU standpoint, but they 
> > aren't user space from a _user_ standpoint - it's still very much a 
> > separate address space, with domain protection.
> 
> How are they different from regular user procs, other then being trusted to
> manage certain resources?

Ehh, they are separate the same way "inetd" is separate. It's not a _user_ 
proc, it's a system proc. The user can't actually do anything about it.

In many ways UNIX _is_ a microkernel. It does nonessential stuff in "user
space".  Anything that is critical for performance or the working of the
machine is in kernel space.

The big difference between UNIX and what people _call_ "microkernels" is 
that UNIX has a very functional and sane partitioning of what is a 
critical thing.

But from a kernel _protection_ angle, the only part that is important is 
that the services be in some protected domain. That was what started this 
discussion: 99% of what the kernel does is protecting shared data. Whether 
it does so by passing it on to some trusted third party or not is an 
implementation issue, and is totally pointless from a user standpoint, 
since the user won't see it anyway.

		Linus

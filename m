Return-Path: <linux-kernel-owner+w=401wt.eu-S932479AbWLLWVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWLLWVn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWLLWVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:21:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:42426 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932479AbWLLWVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:21:42 -0500
Subject: Re: Mach-O binary format support and Darwin syscall personality
	[Was: uts banner changes]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
References: <457D750C.9060807@shadowen.org>
	 <20061211163333.GA17947@aepfle.de>
	 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>
	 <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de>
	 <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
	 <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com>
	 <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org>
	 <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 09:21:23 +1100
Message-Id: <1165962083.11914.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The PPC syscall stuff on the other hand is fairly straightforward.   
> The code loads the argument registers (which I _think_ follow the  
> same syscall ABI on Linux and Darwin due to somebody having a flash  
> of inspiration and putting that recommendation in the PPC spec  
> documents) 

I wouldn't bet on that ... they might look the same but it's likely that
there will be subtle differences. There are definitely differences
between the PEF ABI used on MacOS < X (and useable in OS X with a
special loader) and the SysV ABI we use in Linux. The differences
generally are around those areas:

 - stack frame format (hopefully should be irrelevant for syscalls,
well, I hope so ...)
 - va_args format (same)
 - passing or returning function arguments larger than the native int
size (passing 64 bits values, passing structures by values)  (r3/r4 vs.
stack for example).
 - TOC/TLS/whatever is in r2, r12 and r13 ...

I would expect most of these but not all to be irrelevant for syscalls.

Now, I don't know precisely what the mach-o ABI looks like, we might be
lucky and it may be similar to ours. PEF is not, but then, PEF isn't
native in OS-X, they use a special loader/wrapper for it.

Also, beware that there are two different ABIs (both in linux and in
mach-o) for 32 and 64 bits binaries.

Ben.



Return-Path: <linux-kernel-owner+w=401wt.eu-S1751538AbWLLQYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWLLQYu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWLLQY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:24:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41754 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbWLLQYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:24:04 -0500
Date: Tue, 12 Dec 2006 08:23:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: LKML Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Mach-O binary format support and Darwin syscall personality
 [Was: uts banner changes]
In-Reply-To: <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com>
Message-ID: <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de>
 <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
 <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2006, Kyle Moffett wrote:
> 
> So now I have to figure out how to set up a new syscall personality with a
> bunch of wrapper syscalls which reorder arguments and translate constant
> values before calling into the rest of the Linux code.  I'm fairly sure it's
> possible because you can run some Solaris binaries under Linux if you turn on
> the appropriate BINFMT_* config option(s), but I'm totally unsure as to _how_.

What system call interface do Mach-O binaries use? Is it the old stupid 
"lcall 7,0" thing, or does it use "sysenter" or something like that?

If it's sysenter, it's going to be "interesting". That code currently 
doesn't support any kind of emulation, and the whole "sysenter" interface 
is pretty grotty at a CPU level (it doesn't even save eip etc). So you'd 
need to delve into x86 asm and arch/i386/kernel/entry.S (or the x86-64 
equivalent).

		Linus

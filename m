Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVAGGsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVAGGsY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 01:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAGGsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 01:48:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:11941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261272AbVAGGsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 01:48:20 -0500
Date: Thu, 6 Jan 2005 22:48:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Kacur <jkacur@rogers.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Jesse Allen <the3dfxdude@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: minor nit with decoding popf instruction - was Re: ptrace
 single-stepping change breaks Wine
In-Reply-To: <1105073464.8135.17.camel@linux.site>
Message-ID: <Pine.LNX.4.58.0501062238050.2272@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <1104401393.5128.24.camel@gamecube.scs.ch>  <1104411980.3073.6.camel@littlegreen>
 <200412311413.16313.sailer@scs.ch>  <1104499860.3594.5.camel@littlegreen> 
 <53046857041231074248b111d5@mail.gmail.com> 
 <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com> 
 <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org> <1105073464.8135.17.camel@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jan 2005, John Kacur wrote:
> 
> In order to avoid false positives, I think you should remove the line
> case 0xf0: case 0xf2: case 0xf3:

False positives are ok with instructions that trap - if it traps, we won't 
much care, since the debugger will get notified about that separately (and 
unambiguously).

Also:

> 0xf0 corresponds to the lock prefix which would trigger an invalid
> opcode exception with a popf instruction.
> 
> 0xf2 and 0xf3 correspond to the repeat prefixes and are also not valid
> with popf

I don't think either of those are necessarily true on older x86 chips. 
Nonsensical prefixes used to be silently ignored. Only in later chips has 
Intel been more strict about them, and given them meanings.

In fact, I'm pretty sure it's only "lock" that Intel got a lot more
careful about.  Try it. I'm pretty sure a "rep" prefix is still accepted
in front of pretty much all instructions. It just doesn't do anything.

Is it used? Probably not. But people have done some strange things to 
"mark" instructions (ie for things like run-time exception handling you 
can "mark" an instruction by prefixing it with a nonsensical "rep" prefix: 
the CPU won't care, and you can check at trap time whether it was one of 
your magic instructions.

Of course, I'd never admit to doing anything that obscure. Never.

		Linus

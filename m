Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758396AbWK0Qnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396AbWK0Qnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758397AbWK0Qnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:43:52 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:21160 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1758393AbWK0Qnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:43:51 -0500
Date: Mon, 27 Nov 2006 16:43:32 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kyle McMartin <kyle@parisc-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
Message-ID: <20061127164332.GA26389@linux-mips.org>
References: <20061126224928.GA22285@linux-mips.org> <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org> <Pine.LNX.4.64.0611261509330.3483@woody.osdl.org> <20061126232128.GC30767@flint.arm.linux.org.uk> <Pine.LNX.4.64.0611261627260.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611261627260.30076@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 04:29:00PM -0800, Linus Torvalds wrote:

> > > Ralf, Russell, does this work for you guys?
> > 
> > Not at all.  It creates even more problems for me, with this circular
> > dependency:
> 
> Ok. I just reverted it then. 
> 
> Pls verify that this is all good, and I didn't mess anything up due to the 
> manual conflict resolution.

Thanks, 2ea5814472c3c910aed5c5b60f1f3b1000e353f1 builds again for MIPS.

If you deciede to put the patch back in after 2.6.19 I'm considering to
replace the local_irq_{save,restore} calls in the various atomic operations
in <asm/{atomic,bitops,system}.h with their raw_* equivalents.

What I dislike about Alexey's patch is that is finally tries to cast
unsigned long as the data type for the flags into stone.  The natural
data type to use on MIPS and several other architectures is a 32-bit
integer - or just a single bit on a stingy day ;-).  Time for flags_t
maybe?

  Ralf

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUJKLrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUJKLrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUJKLrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:47:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:37552 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268819AbUJKLrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:47:20 -0400
Date: Mon, 11 Oct 2004 13:42:11 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [BKPATCH] LAPIC fix for 2.6
Message-ID: <20041011114211.GF14615@wotan.suse.de>
References: <1097429707.30734.21.camel@d845pe> <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org> <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl> <Pine.LNX.4.58.0410101744110.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410101744110.3897@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 05:47:05PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 10 Oct 2004, Maciej W. Rozycki wrote:
> > 
> >  Hmm, any particular reason to keep the local APIC disabled by default?  
> 
> Yes. It changes interrupt handling, so any SMM stuff tends to break on
> BIOSes that don't know about APICs. Things like the magic keys etc. It
> apparently also breaks some ACPI stuff (likely AML code that "knows" that
> interrupts are done with the legacy controller).
> 
> Mostly a laptop issue, I suspect - simply because desktops don't do 
> anything strange these days.

It's more than a laptop issue. Especially older desktops still don't
work with APIC by default, and even a lot of modern ones have problems.  

It works around ACPI bugs. Some common issues I ran into on x86-64:
nvidia nforce2/3 is still often broken because of the bogus timer override 
so many BIOS have) 
Some VIA K8 boards get mysterious IDE DMA errors after some time when the APIC 
is on.

[Patch for the Nvidia thing is pending - just always ignore it - but not 
submitted yet for i386 yet. x86-64 has it fixed in -mm*]

-Andi


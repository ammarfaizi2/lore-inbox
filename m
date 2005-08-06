Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbVHFP56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbVHFP56 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 11:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbVHFP55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 11:57:57 -0400
Received: from havoc.gtf.org ([69.61.125.42]:44176 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263226AbVHFP55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 11:57:57 -0400
Date: Sat, 6 Aug 2005 11:57:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-ID: <20050806155755.GA17136@havoc.gtf.org>
References: <1123259263.8917.9.camel@whizzy> <20050805183505.GA32405@kroah.com> <1123279513.4706.7.camel@whizzy> <20050805225712.GD3782@kroah.com> <20050806033455.GA23679@havoc.gtf.org> <20050806085013.GA17747@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806085013.GA17747@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 09:50:13AM +0100, Matthew Wilcox wrote:
> On Fri, Aug 05, 2005 at 11:34:55PM -0400, Jeff Garzik wrote:
> > FWIW, compilers generate AWFUL code for bitfields.  Bitfields are
> > really tough to do optimally, whereas bit flags ["unsigned int flags &
> > bitmask"] are the familiar ints and longs that the compiler is well
> > tuned to optimize.
> 
> I'm sure the GCC developers would appreciate a good bug report with a
> test-case that generates worse code.  If you don't want to mess with their
> bug tracking system, just send me a test case and I'll add it for you.

Its an order-of-complexity issue.  No matter how hard you try,
bitfields will -always- be tougher to optimize, than machine ints.

Bitfields are weirdly-sized, weirdly-aligned integers.  A simple look at
the generated asm from gcc on ARM or MIPS demonstrates the explosion of
code that can sometimes occur, versus a simple 'and' test of a machine
int and a mask.  x86 is a tiny bit better, but still more expensive to
do bitfields than machine ints.

	Jeff




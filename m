Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUAFXCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbUAFXCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:02:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8818 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265354AbUAFXCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:02:37 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <1aJdi-7TH-25@gated-at.bofh.it>
	<m37k054uqu.fsf@averell.firstfloor.org>
	<Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jan 2004 15:56:34 -0700
In-Reply-To: <Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
Message-ID: <m17k04n0t9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 6 Jan 2004, Andi Kleen wrote:
> > 
> > IMHO the only reliable way to get physical bus space for mappings
> > is to allocate some memory and map the mapping over that.
> 
> You literally can't do that: the RAM addresses are decoded by the 
> northbridge before they ever hit the PCI bus, so it's impossible to "map 
> over" RAM in general. 

On AMD cpus starting at least with the K7 it is a cpu function.  They
have both memory access and IO access FSB cycles.  The cpu decodes the
address by looking at the IORRS and TOP_MEM (IO range registers are
similar to mtrrs but for specifying IO regions).  

Of course there are some northbridges that don't ignore the mem/io
bits..
 
> Normally, the way this works is that there are magic northbridge mapping
> registers that remap part of the memory, 
So far I have only seen this on the intel E7500 and it's descendants.

> so that the memory that is
> physically in the upper 4GB of RAM shows up somewhere else (or just
> possibly disappears entirely
Having the memory disappear entirely is much more common.

>  - once you have more than 4GB of RAM, you
> might not care too much about a few tens of megs missing).

At least not until you plug in a card with a 256M pci memory region
and loose half a gig of RAM.

There is also the trick of just not mapping the RAM into the address
space in a contiguous fashion.  I have been very tempted lately to
just setup boxes with one dimm below 4G and have all of the rest above
to make this easier.  But 32bit OS's and the performance hit
they take when accesses memory above 4G to make this a good idea yet.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbTICHlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTICHli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:41:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45451 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261523AbTICHlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:41:36 -0400
Date: Wed, 3 Sep 2003 08:41:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030903074134.GB19920@mail.jlokier.co.uk>
References: <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk> <20030902091553.A29984@flint.arm.linux.org.uk> <20030902115731.GA14354@mail.jlokier.co.uk> <20030902195222.D9345@flint.arm.linux.org.uk> <20030902235900.GA5769@work.bitmover.com> <20030903083118.A17670@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903083118.A17670@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> > > Multiple mappings of the same object rarely occur in my experience, so
> > > the resulting performance loss caused by working around the cache and
> > > writebuffer is something we can live with.
> > 
> > Multiple *writable* mappings.   Don't forget about libc et al.
> 
> I mean in the same group of threads with the same struct mm, not the whole
> system.

Larry means that it's perfectly normal for libc to map the same file
more than once: you have the code section and the data section.

I don't know if ARM's ELF is like the x86, but on the x86 the final
partial page of code or read-only data will be mapped twice, as the
latter part of the page can contain writable data.  This avoids
wasting up to a page's worth of bytes in the ELF file.

-- Jamie


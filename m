Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUCVAeC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCVAeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:34:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1195 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261586AbUCVAd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:33:57 -0500
Message-ID: <405E3466.8070401@pobox.com>
Date: Sun, 21 Mar 2004 19:33:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com> <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org> <405E2F0D.3050001@pobox.com> <20040322002041.I26708@flint.arm.linux.org.uk>
In-Reply-To: <20040322002041.I26708@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Mar 21, 2004 at 07:10:53PM -0500, Jeff Garzik wrote:
> 
>>For the first kind, please read fb_mmap in drivers/video/fbmem.c.  Look 
>>at the _horror_ of ifdefs in exporting the framebuffer.  And that horror 
>>is what's often needed when letting userspace mmap(2) PCI memory IO regions.
> 
> 
> Most of this:
[...]
> exists because architectures haven't defined their private
> pgprot_writecombine() implementations, preferring instead to add
> to the preprocessor junk instead.


Agreed but the larger point is that that code should not be in fbmem.c 
at all.

There are two main types of usage for bus IO memory (MMIO), data and 
hardware registers.  Both types driver writers currently export to 
userspace via mmap(2).  Caching and write combining are simply 
driver-controlled attributes one must consider.

	Jeff




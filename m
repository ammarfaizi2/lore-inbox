Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbUCWR5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUCWR5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:57:05 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:25607 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262751AbUCWR47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:56:59 -0500
Date: Tue, 23 Mar 2004 17:59:20 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <28313883.1080064760@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <20040321235854.H26708@flint.arm.linux.org.uk>
References: <1079901914.17681.317.camel@imladris.demon.co.uk>
 <20040321204931.A11519@infradead.org>
 <1079902670.17681.324.camel@imladris.demon.co.uk>
 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
 <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
 <20040321225117.F26708@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
 <405E23A5.7080903@pobox.com>
 <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
 <20040321235854.H26708@flint.arm.linux.org.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 21 March 2004 23:58 +0000 Russell King <rmk+lkml@arm.linux.org.uk>
wrote:

> On Sun, Mar 21, 2004 at 03:51:31PM -0800, Linus Torvalds wrote:
>> That might be the minimal fix, since it would basically involve:
>>  - change whatever offensive "virt_to_page()" calls into 
>>    "dma_map_to_page()".
>>  - implement "dma_map_to_page()" for all architectures.
>> 
>> Would that make people happy?
> 
> Unfortunately this doesn't make dwmw2 happy - he claims to have machines
> which implement dma_alloc_coherent using RAM which doesn't have any
> struct page associated with it.

Would it not be possible to allocate struct page's for these special areas
of memory?  Worst, worst, worst case could they not represent pages in a
memory only node in the NUMA sense?  I am sure there is some way they could
be 'tacked' onto the end of the cmap in reality?

-apw

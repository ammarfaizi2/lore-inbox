Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUCWR6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUCWR6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:58:48 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:43651 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262742AbUCWR6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:58:45 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: David Woodhouse <dwmw2@infradead.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <28313883.1080064760@42.150.104.212.access.eclipse.net.uk>
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
	 <28313883.1080064760@42.150.104.212.access.eclipse.net.uk>
Content-Type: text/plain
Message-Id: <1080064710.16509.297.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Tue, 23 Mar 2004 17:58:31 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 17:59 +0000, Andy Whitcroft wrote:
> Would it not be possible to allocate struct page's for these special areas
> of memory?  Worst, worst, worst case could they not represent pages in a
> memory only node in the NUMA sense?  I am sure there is some way they could
> be 'tacked' onto the end of the cmap in reality?

It would be possible. But why? What benefit do we gain from this
pretence?

Just hide it all from the driver with dma_coherent_mmap() and forget
about it. Let the arch deal with it -- the _common_ case will be that we
use nopage for the actual mapping, perhaps. But why mandate it?


-- 
dwmw2


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUCVBeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 20:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUCVBeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 20:34:05 -0500
Received: from holomorphy.com ([207.189.100.168]:16270 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261604AbUCVBeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 20:34:03 -0500
Date: Sun, 21 Mar 2004 17:28:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322012822.GA2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Garzik <jgarzik@pobox.com>, rmk@arm.linux.org.uk,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk> <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405E3387.1050505@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 07:29:59PM -0500, Jeff Garzik wrote:
> No comment on struct dma_scatterlist, but the above is the most natural 
> API for audio drivers at least.
> Audio drivers allocate buffers at ->probe() or open(2), and the only 
> entity that actually cares about the contents of the buffers are (a) the 
> hardware and (b) userland.  via82cxxx_audio only uses 
> pci_alloc_consistent because there's not a more appropriate DMA 
> allocator for the use to which that memory is put.
> Audio drivers only need to read/write the buffers inside the kernel when 
> implementing read(2) and write(2) via copy_{to,from}_user().

I based it on rmk's set of arguments to his functions; I'm hoping for
feedback (or another API/implementation) from him and hopefully at
least one other arch maintainer having problems in this area. I'm
hoping to focus mostly on the driver sweep, and to devolve e.g. finer
details of the design like the above arguments and/or structures to
those with more detailed knowledge or direct experience (and the
broader details came from elsewhere too).


-- wli

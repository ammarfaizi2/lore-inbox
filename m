Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbUCUGXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 01:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUCUGXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 01:23:30 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:25102 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263610AbUCUGX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 01:23:29 -0500
Date: Sun, 21 Mar 2004 06:23:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321062322.A5861@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20040320133025.GH9009@dualathlon.random> <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org> <20040321031355.GB3930@dingdong.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040321031355.GB3930@dingdong.cryptoapps.com>; from cw@f00f.org on Sat, Mar 20, 2004 at 07:13:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 07:13:55PM -0800, Chris Wedgwood wrote:
> > If a driver wants to map non-RAM pages, that's perfectly ok, but it
> > MUST NOT happen through "nopage()". The driver should map them with
> > "remap_page_range()", and thus never take a page fault for such
> > pages at all.
> 
> This is what the fetchop driver does.

Not sure how you get to fetchop here, but that driver does map ram pages
so it should take pagefaults and not use remap_page_range().


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTEZDGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 23:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263911AbTEZDGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 23:06:39 -0400
Received: from rth.ninka.net ([216.101.162.244]:43395 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263902AbTEZDGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 23:06:38 -0400
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
	2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       LW@KARO-electronics.de, linux-kernel@vger.kernel.org
In-Reply-To: <20030523193458.B4584@flint.arm.linux.org.uk>
References: <20030523175413.A4584@flint.arm.linux.org.uk>
	 <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain>
	 <20030523112926.7c864263.akpm@digeo.com>
	 <20030523193458.B4584@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053919171.14018.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 May 2003 20:19:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-23 at 11:34, Russell King wrote:
> So no, I don't think it is a device driver issue at all.
> 
> DaveM?

Oh yes, this part is.  If you don't ensure this, everything
breaks.

At the end of an I/O operation, say to a page cache page, that
data ought to be visible equally to a userspace vs. a kernel
space mapping to that page.

For example, this is why we use language about "cpu visibility" in the
DMA api documentation and not "kernel cpu visibility" :-)  And because
PIO transfers are basically pseudo-DMA they need to make the same exact
guarentees.

If you've been living in a world where you didn't think this is
necessary, I certainly feel bad for you :-)

-- 
David S. Miller <davem@redhat.com>

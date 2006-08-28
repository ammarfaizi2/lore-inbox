Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWH1Mnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWH1Mnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWH1Mnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:43:42 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:63690 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750703AbWH1Mnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:43:42 -0400
Date: Mon, 28 Aug 2006 14:42:13 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reiser4 und LZO compression
Message-ID: <20060828124213.GA26698@wohnheim.fh-wedel.de>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru> <20060827010428.5c9d943b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060827010428.5c9d943b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 August 2006 01:04:28 -0700, Andrew Morton wrote:
> 
> Like lib/inflate.c (and this new code should arguably be in lib/).
> 
> The problem is that if we clean this up, we've diverged very much from the
> upstream implementation.  So taking in fixes and features from upstream
> becomes harder and more error-prone.

I've had an identical argument with Linus about lib/zlib_*.  He
decided that he didn't care about diverging, I went ahead and changed
the code.  In the process, I merged a couple of outstanding bugfixes
and reduced memory consumption by 25%.  Looks like Linus was right on
that one.

> I'd suspect that the maturity of these utilities is such that we could
> afford to turn them into kernel code in the expectation that any future
> changes will be small.  But it's not a completely simple call.
> 
> (iirc the inflate code had a buffer overrun a while back, which was found
> and fixed in the upstream version).

Dito in lib/zlib_*.  lib/inflage.c is only used for the various
in-kernel bootloaders to uncompress a kernel image.  Anyone tampering
with the image to cause a buffer overrun already owns the machine
anyway.

Whether any of our experiences with zlib apply to lzo remains a
question, though.

Jörn

-- 
I've never met a human being who would want to read 17,000 pages of
documentation, and if there was, I'd kill him to get him out of the
gene pool.
-- Joseph Costello

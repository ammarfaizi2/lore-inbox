Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSLFRuo>; Fri, 6 Dec 2002 12:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSLFRui>; Fri, 6 Dec 2002 12:50:38 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:55950 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S265222AbSLFRub>; Fri, 6 Dec 2002 12:50:31 -0500
Date: Fri, 6 Dec 2002 12:58:06 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Make `hash_long' function work if bits parameter is 0.
Message-ID: <20021206175806.GB15923@gnu.org>
References: <20021206093351.9413736F6@mcspd15.ucom.lsi.nec.co.jp> <Pine.LNX.4.44.0212060836170.23118-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212060836170.23118-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 08:37:26AM -0800, Linus Torvalds wrote:
> > If the bits parameter of hash_long (in <linux/hash.h>) is 0, then it
> > ends up right-shifting by BITS_PER_LONG, which is undefined in C (and
> > often is a nop).
> 
> I would much rather just add a comment saying that "bits" had better be in
> a valid range. There are no valid uses for a 0-bit hash table that I can
> see, and undefined behaviour for undefined operations is fine with me.

The reason I sent the patch is because I ran into a case where the return
value _should_ be zero -- on a machine with very little memory (1MB), the
page wait-queue hash-table ends up having only one bucket (it has 256 pages,
and the code tries to make a wait-queue for every 256 pages....).  The 0 is
returned by the `wait_table_bits' function in mm/page_alloc.c.

I suppose an alternative in this case is to special-case above calculation to
peg the minimum at 1.

-Miles
-- 
`...the Soviet Union was sliding in to an economic collapse so comprehensive
 that in the end its factories produced not goods but bads: finished products
 less valuable than the raw materials they were made from.'  [The Economist]

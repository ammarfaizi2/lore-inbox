Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTBSSL4>; Wed, 19 Feb 2003 13:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTBSSL4>; Wed, 19 Feb 2003 13:11:56 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:36580
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S263342AbTBSSLy>; Wed, 19 Feb 2003 13:11:54 -0500
Date: Wed, 19 Feb 2003 13:20:52 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: James Bottomley <James.Bottomley@steeleye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
In-Reply-To: <1045678275.2033.37.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0302191316230.29393-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2003, James Bottomley wrote:

> > 3. use run-time checks all over the place, of the 
> > "sizeof(dma_addr_t)==sizeof(u64)" kind, which adds unnecessary
> > overhead to 
> > all platforms.
> 
> Actually, these aren't technically run time checks.  Although the cpp
> can't be used for sizeof(), the compiler (at least gcc) does seem to
> have enough sense to optimise away if(..) branches it has enough
> information to know won't be taken at compile time.
> 
> As long as this optimisation works, I think the if(sizeof(..)) checks
> are fine for this.

Well, yes and no. Indeed those checks are optimized away, but as a result 
of using them most data-access macros must be converted to inline 
functions. And, last I heard at least, gcc was optimizing inline functions 
much worse than preprocessor macros.

There are various other things that are made easier by a preprocessor 
directive -- constructing the right data structures, for instance.

However, if such a patch is ultimately not getting accepted, these checks
is probably what I'll end up using...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


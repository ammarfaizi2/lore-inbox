Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUJDVWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUJDVWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268575AbUJDVVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:21:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37866 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268588AbUJDVUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:20:35 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: [PATCH] I/O space write barrier
Date: Mon, 4 Oct 2004 14:20:01 -0700
User-Agent: KMail/1.7
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
References: <1096922369.2666.177.camel@cube>
In-Reply-To: <1096922369.2666.177.camel@cube>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041420.01266.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 4, 2004 1:39 pm, Albert Cahalan wrote:
> > diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
> > --- a/include/asm-ppc/io.h 2004-09-27 10:48:41 -07:00
> > +++ b/include/asm-ppc/io.h 2004-09-27 10:48:41 -07:00
> > @@ -197,6 +197,8 @@
> >  #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
> >  #define memcpy_toio(a,b,c) memcpy((void *)(a),(b),(c))
> >
> > +#define mmiowb() asm volatile ("eieio" ::: "memory")
> > +
> >  /*
> >   * Map in an area of physical address space, for accessing
> >   * I/O devices etc.
>
> I don't think this is right. For ppc, eieio is
> already included as part of the assembly for the
> IO operations. If you could delete that, great,
> but I suspect that nearly all drivers would break.

Ok, if it's covered than mmiowb() can just be empty for ppc.

> BTW, the "eieio" name is better. The "wb" part
> of "mmiowb" looks like "write back" to me, as if
> it were some sort of cache push operation. It is
> also lacking an appropriate song. :-)

It's supposed to be 'write barrier' just like wmb is a write memory barrier, 
so is mmiowb a memory-mapped I/O write barrier.  Make sense?

Thanks,
Jesse

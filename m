Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314675AbSEFTB1>; Mon, 6 May 2002 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314658AbSEFTBZ>; Mon, 6 May 2002 15:01:25 -0400
Received: from mail.uklinux.net ([80.84.72.21]:57362 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S314657AbSEFTBY>;
	Mon, 6 May 2002 15:01:24 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 6 May 2002 20:01:01 +0100 (BST)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/depca.c tidyup
In-Reply-To: <20020506193247.C22215@suse.de>
Message-ID: <Pine.LNX.4.44.0205061944460.30139-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Dave Jones wrote:

> On Mon, May 06, 2002 at 06:17:00PM +0100, Peter Denison wrote:
>  > The ALIGN macro is defined centrally - remove the local version
> 
> They aren't functionally equivalent though are they?

Eek. I thought they were.

-#define ALIGN4      ((u_long)4 - 1)       /* 1 longword align */
-#define ALIGN8      ((u_long)8 - 1)       /* 2 longword (quadword) align */
-#define ALIGN         ALIGN8              /* Keep the LANCE happy... */

-	offset = (offset + ALIGN) & ~ALIGN;
+	offset = ALIGN(offset, 8);

And from include/linux/cache.h:

#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))

So, we're replacing (offset + 8 - 1) & ~(8-1) = (offset + 7) & ~7
with (((offset)+(8)-1)&~((8)-1)) = ((offset+7)&~7)

I think they're the same, aren't they, except for the promotion to u_long, 
which is probably bogus anyway?

-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please note that my address is changing from <peterd at pnd-pc dot demon.co.uk>


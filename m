Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318635AbSGZXY0>; Fri, 26 Jul 2002 19:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318636AbSGZXY0>; Fri, 26 Jul 2002 19:24:26 -0400
Received: from [195.223.140.120] ([195.223.140.120]:19816 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318635AbSGZXYZ>; Fri, 26 Jul 2002 19:24:25 -0400
Date: Sat, 27 Jul 2002 01:28:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020726232834.GA1168@dualathlon.random>
References: <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com> <20020725225613.GW1180@dualathlon.random> <20020725170113.F5326@host110.fsmlabs.com> <20020726223750.GA1151@dualathlon.random> <20020726165535.R13656@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726165535.R13656@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 04:55:35PM -0600, Cort Dougan wrote:
> I don't see how this is significantly different from the patch I sent
> apart from removing some useful debugging.  Is there something I'm missing?
> 
> The patch I sent prints out the offset from the symbol name nearest
> (below) the EIP and the offset from that symbol.  I found that really
> useful and was what I use the patch for.  Is there a reason you don't want
> that?  I know you had some cases where all symbols weren't listed for you

that's why, because of those cases. I thought you had those cases too
right? And for ksymoops it's much simpler to avoid the reverse lookup.

I think either you go kksymoops, or you go my way + module tracking
aware ksymoops (only one "k"), the intermediate approch is probably a
nice way but handy only until a module tracking aware ksymoops exists.

Furhtmore your patch doesn't really provide all the info need, you
only take care of the module where the EIP lives, you don't handle the
case of multiple module addresses in the stack trace. And printing lots
of symbols for the stack trace too (potentially to reverse all the time
too) can overflow the screen.  Infact I also considered to print modules
tracking info without \n in between even if it can overflow to save
screen ram space. Maybe that's worhwhile, OTOH I wouldn't expect more
than a few lines usually and the \n makes it more readable but I may
change it to use better the screen space.

> but many of us do have those symbols we'd like to see.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea

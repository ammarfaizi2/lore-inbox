Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSHXPBa>; Sat, 24 Aug 2002 11:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSHXPB3>; Sat, 24 Aug 2002 11:01:29 -0400
Received: from waste.org ([209.173.204.2]:36772 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316541AbSHXPB2>;
	Sat, 24 Aug 2002 11:01:28 -0400
Date: Sat, 24 Aug 2002 10:05:36 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (1/7) entropy, take 2 - log2
Message-ID: <20020824150535.GA2436@waste.org>
References: <20020823182629.GA2224@waste.org> <3D675042.A2F163D5@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D675042.A2F163D5@libero.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 11:22:10AM +0200, Abramo Bagnara wrote:
> Oliver Xymoron wrote:
> > 
> >> +static inline __u32 int_log2_16bits(__u32 word)
> >  {
> >         /* Smear msbit right to make an n-bit mask */
> >         word |= word >> 8;
> >         word |= word >> 4;
> >         word |= word >> 2;
> >         word |= word >> 1;
...
> > +       return hweight16(word)-1;
> >  }
> > -#endif
> 
> I suggest you to use a more efficient version like that below:
> 
> static inline int ld2_16(__u16 v)
> {
>         unsigned r = 0;
> 
>         if (v >= 0x100) {
>                 v >>= 8;
>                 r += 8;
>         }
>         if (v >= 0x10) {
>                 v >>= 4;
>                 r += 4;
>         }
>         if (v >= 4) {
>                 v >>= 2;
>                 r += 2;
>         }
>         if (v >= 2)
>                 r++;
>         return r;

Four branches are almost certainly less efficient. In any case, the
intent above is not to optimize the code, but to replace it with a
call to identical code that exists in bitops so that optimizations can
be made globally, and arch-specific if necessary.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

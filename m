Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267391AbSKPWoK>; Sat, 16 Nov 2002 17:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbSKPWoK>; Sat, 16 Nov 2002 17:44:10 -0500
Received: from are.twiddle.net ([64.81.246.98]:61574 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267391AbSKPWoJ>;
	Sat, 16 Nov 2002 17:44:09 -0500
Date: Sat, 16 Nov 2002 14:51:02 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: in-kernel linking issues
Message-ID: <20021116145102.A24671@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, paulus@samba.org
References: <20021114143701.A30355@twiddle.net> <20021116164755.59575f21.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021116164755.59575f21.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Sat, Nov 16, 2002 at 04:47:55PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 04:47:55PM +1100, Rusty Russell wrote:
> [ Sorry for the delayed reply, I only got this mail via kernel.org: did you
>   get a bounce from rusty@rustcorp.com.au? ]

Nope.

> Thanks for this.  It adds even more weight to your ET_DYN argument as well.
> I'll need to play with that linker script some more (on PPC, binfmt_misc.o
> is 13000 bytes, binfmt_misc.so becomes 156128 bytes 8)

I know what this is -- max architectural page size of 64k.
The linker is trying to make the file offset congruent to
the address mod 64k.  Which adds a *lot* of padding.

Should be fixable by using the -N option.

> There's still the issue of PPC and PPC64 which can only jump 24-bits away,
> and so currently insert trampolines which have to be allocated with the
> module, but that should be no uglier than currently.

I would hope that this would be handled by the normal .plt
creation.  We'll see.



r~

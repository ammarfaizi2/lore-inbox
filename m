Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316655AbSEUWEq>; Tue, 21 May 2002 18:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSEUWEp>; Tue, 21 May 2002 18:04:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20231 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316655AbSEUWEo>; Tue, 21 May 2002 18:04:44 -0400
Date: Tue, 21 May 2002 15:04:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <3CEAC020.4F63A181@zip.com.au>
Message-ID: <Pine.LNX.4.33.0205211500530.1307-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002, Andrew Morton wrote:
> 
> Pavel makes a reasonable point that copy_*_user may elect
> to copy the data in something other than strictly ascending
> user virtual addresses.  In which case it's not possible to return
> a sane "how much was copied" number.

I don't agree that that is true.

Do you have _any_ reasonable implementation taht would do that_

> And copy_*_user is buggy at present: it doesn't correctly handle
> the case where the source and destination of the copy are overlapping
> in the same physical page.  Example code below.

So we have memcpy() semantics for read()/write(), big deal. 

The same way you aren't supposed to use memcpy() for overlapping areas, 
you're not supposed to read/write into such areas, for all the same 
reasons.

> One fix is to
> do the copy with descending addresses if src<dest or whatever.

No. That wouldn't work anyway, because the addresses are totally different 
kinds.

> But then how to return the number of bytes??

The way we do now, which is the CORRECT way.

Stop this idiocy. 

The current interface is quite well-defined, and has good semantics. Every 
single argument against it has been totally bogus, with no redeeming 
values.

			Linus


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276337AbRJGM2W>; Sun, 7 Oct 2001 08:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276334AbRJGM2M>; Sun, 7 Oct 2001 08:28:12 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:28680 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276335AbRJGM2B>; Sun, 7 Oct 2001 08:28:01 -0400
Date: Sun, 7 Oct 2001 14:28:17 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <E15qAQ3-0005Eq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1011007141040.1764A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001, Alan Cox wrote:

> > Here goes the fix. (note that I didn't try to compile it so there may be
> > bugs, but you see the point). 
> 
> It isnt a fix
> 
> > kmalloc should be fixed too (used badly for example in select.c - and yes
> > - I have seen real world bugreports for poll randomly failing with
> > ENOMEM), but it will be hard to audit all drivers that they do not try to
> > use dma on kmallocated memory. 
> 
> So you run out of blocks of vmalloc address space instead. The same problem
> still occurs and always will

I already said it in mail to Rik:

Yes - you can run out of vmalloc space. But you run out of it only when
you create too many processes (8192), load too many modules etc. If
someone needs to put such heavy load on linux, we can expect that he is
not a luser and he knows how to increase size of vmalloc space.

But - you run out of high-order pages randomly. You don't have to overflow
any resource - just map a file, touch it whole the first time and then
periodically touch every second page of it. Or: alloc periodically one
anon page and one cache page - read() (without readahead) does exactly
that.

You can't run out of vmalloc space just by mapping files and touching
pages. 

The probability math is fine - only if you are sure that pages are
allocated and freed randomly. But they are not. 

Mikulas


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130940AbRCPStT>; Fri, 16 Mar 2001 13:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130941AbRCPStJ>; Fri, 16 Mar 2001 13:49:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47088 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130940AbRCPStE>;
	Fri, 16 Mar 2001 13:49:04 -0500
Date: Fri, 16 Mar 2001 13:48:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David Weinehall <tao@acc.umu.se>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Wayne.Brown@altec.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <20010316193259.A1962@khan.acc.umu.se>
Message-ID: <Pine.GSO.4.21.0103161335240.12618-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Mar 2001, David Weinehall wrote:

> On Fri, Mar 16, 2001 at 01:07:17PM -0500, Alexander Viro wrote:
> > 
> > 
> > On Fri, 16 Mar 2001, Alexander Viro wrote:
> >  
> > [snip]
> > 
> > > Sure. With all its holes and illetarate C.
> > 				    ^
> > 				    e
> > Apparently, rule about typos in spelling flame are not
> > limited to natural languages...
> 
> Oh... Was it a typo? I had a good laugh, because I thought it was
> intended. Especially considering that you left one of the typos
> (I was always taught that it's spelled illiterate...)

Original - typo, the rest (including "rule...are") - not ;-)

Seriously, binfmt_misc.c was written in rather, erm, interesting C.
Read it and you'll see. Just one (but rather impressive) example:

        if ((count == 1) && !(buffer[0] & ~('0' | '1'))) {

It was meant to be

        if (count == 1 && (buffer[0] == '0' || buffer[0] == '1')) {

and anyone who can't find the difference really should learn C. And
that's not the only bogosity of such level. Besides, the thing is
trivially oopsable - write() to any file in binfmt_misc with buffer
pointing to unmapped kernel address and you are screwed,


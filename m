Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132762AbRDELnx>; Thu, 5 Apr 2001 07:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132609AbRDELne>; Thu, 5 Apr 2001 07:43:34 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:34825 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132607AbRDELnY>;
	Thu, 5 Apr 2001 07:43:24 -0400
Date: Thu, 5 Apr 2001 07:37:03 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Manoj Sontakke <manojs@sasken.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version?
In-Reply-To: <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com>
Message-ID: <Pine.LNX.4.30.0104050732080.13246-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Manoj Sontakke wrote:

> Addition and subtraction works fine. The problem is with multiplication
> and division. I am doing this to avoid floating point calculation and
> doing fixed point calculation. The rage is large enough to need "long
> long" Any other way to achieve this?

gcc requires a function call to do a mul/div on a long long.  There is no
easy way to do a 64bit op of this type on a 32 bit CPU...

IFF you are making a module that will never be part of the kernel tree you
can get away with adding `gcc -print-libgcc-file-name` to your link line.
And by that I mean:

	${LD} ${LDFLAGS} -o $@ $< `gcc -print-libgcc-file-name`

This is a hack that will link in the __div3 function from glibc into your
module.  NOTE that this will never be done for you in the kernel... so if
you can don't use div or mul on long long.

Cheers,
Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/



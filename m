Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267234AbRGPIit>; Mon, 16 Jul 2001 04:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbRGPIij>; Mon, 16 Jul 2001 04:38:39 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:7341 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267234AbRGPIiW>; Mon, 16 Jul 2001 04:38:22 -0400
Date: Mon, 16 Jul 2001 10:37:03 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: jlnance@intrex.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <20010716103703.E750@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org> <20010709230151.A13704@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010709230151.A13704@bessie.localdomain>; from jlnance@intrex.net on Mon, Jul 09, 2001 at 11:01:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 11:01:51PM -0400, jlnance@intrex.net wrote:
> stack gets mapped into the top of memory at 0xc0000000 and it grows down
> tword the program text.  Files or shared libraries are mmaped in starting
> at 0x40000000 (1G) and each new mmap() occurs at a higher address so that
> the mapped area grows tword the stack.
> its something like this:
> 
>        0x00000000 ---> Unmapped
>        0x08048000 ---> Text/Data
[1]
>        0x40000000 ---> Shared libs and mmaped
>        0xc0000000 ---> Stack

Does anybody know, why we leave that much Room unmapped in [1]?

Having at least one page unmapped is ok to catch programmer
errors, but the first 132MB seems a little bit too large...

I still don't know why an allocator ONLY using mmap() and no
brk()/sbrk() shouldn't use mmap(getpagesize(),...).

PS: I used this information already to help someone having these
   kind of problems. 
   

Thanks & Regards

Ingo Oeser

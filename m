Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279927AbRKFSPg>; Tue, 6 Nov 2001 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279926AbRKFSP0>; Tue, 6 Nov 2001 13:15:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:62729 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279927AbRKFSPJ>; Tue, 6 Nov 2001 13:15:09 -0500
Date: Tue, 6 Nov 2001 14:55:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161AkQ-0001Fp-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0111061453050.10028-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Alan Cox wrote:

> > "get_current" interrupt safe (ie switching tasks is totally atomic, as
> > it's the one single "movl ..,%esp" instruction that does the real switch
> > as far as the kernel is concerned).
> > 
> > It does require using an order-2 allocation, which the current VM will
> > allow anyway, but which is obviously nastier than an order-1.
> 
> I've seen boxes dead in the water from 8K NFS (ie 16K order-2 allocations),
> let alone the huge memory hit. Michael's rtlinux approach looks even more
> interesting and I may have to play with that (using the TSS to ident the
> cpu)

Btw, I also want to see what intense "for-optimization" high-order
allocators are going to do to the current VM. 

Think about the possible intensive pressure (and CPU wasted) caused by,
for example, SCSI code which _always_ tries to do 1-order allocations (or
bigger?) to allocate scatter/gather tables. We want those allocations to
fail to 0-order allocations instead looping madly inside the VM freeing
routines.



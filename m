Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSHCRfu>; Sat, 3 Aug 2002 13:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSHCRfu>; Sat, 3 Aug 2002 13:35:50 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:19440 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317622AbSHCRfu>; Sat, 3 Aug 2002 13:35:50 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0208031014190.3981-100000@home.transmeta.com> 
References: <Pine.LNX.4.44.0208031014190.3981-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd() 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 18:39:11 +0100
Message-ID: <18259.1028396351@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  My personal opinion is that if a prefetch has semantic meanings
> outside the "speed up subsequent accesses", it should not be exposed
> to the rest of the kernel (it might still be useful inside
> architecture-specific routines like optimized memcpy etc). 

Prefetch generally means 'bring it into the cache'. On architectures with
non-cache-coherent DMA, doing a prefetch on wild address which happens to be
a DMA buffer for which we've just said 'drop it from the cache' is generally
a bad thing.

Not that I'm necessarily disagreeing with you -- but can you confirm that 
you are including all architectures with non-cache-coherent DMA in the 
'broken hardware' category below, or point out what I'm missing?

> I'd rather speed up non-broken machines and let the broken hardware
> hopefully slowly die away.


--
dwmw2



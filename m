Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317907AbSHCWA3>; Sat, 3 Aug 2002 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSHCWA3>; Sat, 3 Aug 2002 18:00:29 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50418 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317907AbSHCWA2>; Sat, 3 Aug 2002 18:00:28 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0208031230400.9758-100000@home.transmeta.com> 
References: <Pine.LNX.4.44.0208031230400.9758-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd() 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 23:03:49 +0100
Message-ID: <24964.1028412229@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  I don't think that non-cache-coherency wrt DMA necessarily means that
> that is true, though. If you flush all CPU caches to memory before
> starting the DMA, and you invalidate the DMA'd memory range _after_
> the DMA finished, a "prefetch" on such an architecture is not a
> problem at all. 

OK -- assuming you actually do flush before the DMA and invalidate 
afterwards, that works. That's what I was missing; thanks :)

That's for a prefetch operation which doesn't mark the cache line 
dirty/owned. If you have random addresses used with 'write prefetch' 
operations, that's still going to be a problem.

--
dwmw2



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316976AbSFKOEn>; Tue, 11 Jun 2002 10:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSFKOEn>; Tue, 11 Jun 2002 10:04:43 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:40948 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316976AbSFKOEl>; Tue, 11 Jun 2002 10:04:41 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <52y9dn86k5.fsf@topspin.com> 
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 15:04:26 +0100
Message-ID: <28713.1023804266@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


roland@topspin.com said:
> Replying to myself....  Anyway, I realized that even my idea above is
> wrong.  I don't see _any_ safe way to share a cache line between a DMA
> buffer and other data.  Access to the cache line might pull the cache
> line back in and write it back at any time, which could corrupt the
> DMA'ed data.  I don't see a way to hide the existence of cache lines
> etc. from the driver.

Access to a cache line can't be shared safely. Disable the cache for that
page while its ownership is in doubt and you can happily share the RAM
though. If we find another CPU which fetches cache lines preemptively, we 
may have to do that anyway.

--
dwmw2



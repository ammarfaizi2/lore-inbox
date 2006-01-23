Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWAWTj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWAWTj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAWTj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:39:28 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:42987 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932240AbWAWTj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:39:27 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Jan 2006 20:38:52 +0100
To: matthias.andree@gmx.de, arjan@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <43D530CC.nailC4Y11KE7A@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
In-Reply-To: <20060123185549.GA15985@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> On Mon, 23 Jan 2006, Arjan van de Ven wrote:
>
> > hmm... curious that mlockall() succeeds with only a 32kb rlimit....
>
> It's quite obvious with the seteuid() shuffling behind the scenes of the
> app, for the mlockall() runs with euid==0, and the later mmap() with euid!=0.
>
> Clearly the application should do both with the same privilege or raise
> the RLIMIT_MEMLOCK while running with privileges.
>
> The question that's open is one for the libc guys: malloc(), valloc()
> and others seem to use mmap() on some occasions (for some allocation
> sizes) - at least malloc/malloc.c comments as of 2.3.4 suggest so -, and
> if this isn't orthogonal to mlockall() and set[e]uid() calls, the glibc
> is pretty deeply in trouble if the code calls mlockall(MLC_FUTURE) and
> then drops privileges.

If the behavior described by Matthias is true for current Linuc kernels,
then there is a clean bug that needs fixing.

If the Linux kernel is not willing to accept the contract by 
mlockall(MLC_FUTURE), then it should now accept the call at all.

In our case, the kernel did accept the call to mlockall(MLC_FUTURE), but later 
ignores this contract. This bug should be fixed.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

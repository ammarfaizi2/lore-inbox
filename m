Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269816AbRHIQD7>; Thu, 9 Aug 2001 12:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269844AbRHIQDt>; Thu, 9 Aug 2001 12:03:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26688 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269816AbRHIQDo>; Thu, 9 Aug 2001 12:03:44 -0400
Date: Thu, 9 Aug 2001 18:03:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
Message-ID: <20010809180344.J4895@athlon.random>
In-Reply-To: <Pine.LNX.3.96.1010809152133.5473B-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010809152133.5473B-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Thu, Aug 09, 2001 at 03:32:44PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 03:32:44PM +0200, Bjorn Wesen wrote:
> I'm trying to track down a problem which seems to be a race condition
> vmalloc page table delayed PTE copying", or "you must never
> call free_kiovec in an interrupt context" etc..)

The latter is certainly the case. The former could be the case, however
if you know you're running any free_kiovec from irqs remove it and try
again first.

BTW, you should also avoid all the kiobuf allocation in all the fast
paths, try to pre-allocate it in a slow path to deliver higher
performance. (shortly we'll split the bh/blocks array out of the kiobuf
in a data structure called kiobuf_io so the non-IO usage will avoid the
overhead of the bh/blocks arrays and it will become lighter but still
it won't be that light)

Andrea

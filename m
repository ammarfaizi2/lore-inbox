Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbTIRAUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 20:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTIRAUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 20:20:04 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:50412 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262909AbTIRAUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 20:20:00 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Stevie-O <oliver@klozoff.com>
Date: Thu, 18 Sep 2003 02:19:50 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Aliasing physical memory using virtual memory (from a d
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <80BC15566D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 03 at 19:36, Stevie-O wrote:
> 
> My thinking is this: I want to use __get_free_pages(1) 80 times to get the
> 160 pages, then passed those 80 pieces to the card (it's known the card can
> handle requests with that many pieces).  Then I want to create a *virtually*
> contiguous 160-page mapping, so the postprocessing code in the driver can
> view the 80 2-page sub-buffers as one big consecutive 160-page buffer. 
> Doing this would (a) make for more efficient use of memory, and (b) leave
> the larger piles of contiguous pages to the drivers of cards that actually
> require them.

If you'll use __get_free_pages(0) 160 times, you should be able to use
vmap() in 2.[456].x.

I must say that I do not understand why it checks for 
size > (max_mapnr << PAGE_SHIFT) in 2.4.x, or for count > num_physpages
in 2.6.x (as there is nothing wrong with mapping same page several
thousand times, or is it bad? with 32MB host you have plenty of
unused VA space in the kernel...), but it should not hurt you as you
need distinct physical pages.

On other side, maybe that using SG even for driver operations is not
that complicated. Do not forget that on bigmem boxes you have only
128MB area for vmalloc/vmap/ioremap, so you can quickly find that
there is not 640KB continuous area available.
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz


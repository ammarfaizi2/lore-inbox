Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129758AbQKJKrt>; Fri, 10 Nov 2000 05:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbQKJKrj>; Fri, 10 Nov 2000 05:47:39 -0500
Received: from www.wen-online.de ([212.223.88.39]:49934 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129758AbQKJKre>;
	Fri, 10 Nov 2000 05:47:34 -0500
Date: Fri, 10 Nov 2000 11:47:21 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jens Axboe <axboe@suse.de>, MOLNAR Ingo <mingo@chiara.elte.hu>,
        Rik van Riel <H.H.vanRiel@phys.uu.nl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process,
 2.4.0-test10
In-Reply-To: <Pine.Linu.4.10.10011100732250.601-100000@mikeg.weiden.de>
Message-ID: <Pine.Linu.4.10.10011101145220.889-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I understood the above well enough to be very interested in seeing what
> happens with flush IO restricted.
> 
> 	-Mike
> 
> [try_to_free_pages()->swap_out()/shm_swap().. can fight over who gets
> to shrink the best candidate's footprint?]
> 
> Thanks!

The results:

pre2+semaphore
real    14m19.987s
user    6m24.480s
sys     1m12.970s

pre2+semaphore+throttle_IO
real    10m13.953s
user    6m19.980s
sys     0m28.960s

pre2+semaphore+throttle_IO extended to refill_inactive()
real    9m46.395s
user    6m23.510s
sys     0m29.420s

pre2+semaphore+throttle_IO + above + tiny little tweak to page_launder()
real    8m56.808s
user    6m23.420s
sys     0m29.430s

Unfortunately, when I try to get past this point I burn trees :-)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315782AbSEDGfX>; Sat, 4 May 2002 02:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSEDGfW>; Sat, 4 May 2002 02:35:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59041 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315782AbSEDGfV>;
	Sat, 4 May 2002 02:35:21 -0400
Date: Sat, 4 May 2002 02:35:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Odd code in sd_init()
Message-ID: <Pine.GSO.4.21.0205040203511.21265-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sd_init() contains the following loop:

        for (k = 0; k < N_USED_SD_MAJORS; k++) {
                request_queue_t *q = blk_get_queue(mk_kdev(SD_MAJOR(k), 0));
                blk_queue_hardsect_size(q, 512);
        }

... which is a damn interesting thing to do, seeing that it's called when
we do scsi_register_device(&sd_template) and before we get any chance to
set ->queue, so we actually end up setting sector size for hell knows
what (well, for default queues of our majors - i.e. stuff that won't be
used).

Either I'm missing something, or that code is bogus.  Jens, Linus?


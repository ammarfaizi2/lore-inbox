Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129520AbQLAAGP>; Thu, 30 Nov 2000 19:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLAAGF>; Thu, 30 Nov 2000 19:06:05 -0500
Received: from north.net.CSUChico.EDU ([132.241.66.18]:2832 "EHLO
	north.net.csuchico.edu") by vger.kernel.org with ESMTP
	id <S129520AbQLAAGC>; Thu, 30 Nov 2000 19:06:02 -0500
Date: Thu, 30 Nov 2000 15:35:35 -0800
From: John Kennedy <jk@csuchico.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: loopback block sizes vs. truncation
Message-ID: <20001130153535.A10494@north.csuchico.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  In trying to test the international crypto patch-2.2.17.11pre1 I was
doing some QA on my bootloader program.  It looks like the loopback
device will return EOF before a file is finished.

  In my case in particular, I was using files instead of block devices
(again, for testing) and had a nulled loop_info so I wasn't dealing with
encryption at that point.  I had a 7851-byte test file, which happens
to be (7*1024)+683.  The general setup was:

	(<stdin> -> /dev/loop0) -> <stdout>	[ < /tmp/in > /tmp/out ]

			... which should equate to

			(/tmp/in -> /dev/loop0) -> /tmp/out

  I was getting a output file truncated at 7168 (7*1024) bytes.  That
wasn't even a multiple of 4096, which is st_blksize if you stat() the
input, output, or loopback file descriptors.

  No problems with files that are multiples of 1K so far.

  I assume it is just giving me the finger because the leftover 683
bytes aren't a multiple of the block size, but right now I'm not sure
how to go about getting the proper block size anyway.


  No real problem dealing with it, but it made me wonder what was going
on with the whole 1K/4K filesystem block size again.

  [This is with a patched 2.2.18pre24 kernel.]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

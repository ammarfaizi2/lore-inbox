Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292552AbSBPVly>; Sat, 16 Feb 2002 16:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292551AbSBPVlp>; Sat, 16 Feb 2002 16:41:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:63741 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292550AbSBPVl0>;
	Sat, 16 Feb 2002 16:41:26 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 16 Feb 2002 21:41:21 GMT
Message-Id: <UTC200202162141.VAA31781.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH] size-in-bytes
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From dalecki@evision-ventures.com Sat Feb 16 22:09:26 2002

    Andries.Brouwer@cwi.nl wrote:

    > /*
    >+ * blk_size_in_bytes contains the size of all block-devices in bytes
    >+ * (blk_size has too low a resolution, since we really need the size
    >+ * in 512 byte sectors, and fails on devices > 2 TB)
    >+ *
    >+ * blk_size_in_bytes[MAJOR][MINOR]
    >+ *
    >+ * if (!blk_size_in_bytes[MAJOR]) then no minor size checking is done.
    >+ */
    >+loff_t * blk_size_in_bytes[MAX_BLKDEV];
    >+
    >+/*

    Please pin it up the block device structure not to just another 
     arbitrary global array.

You miss the point of the patch, perhaps forgot to read the introduction :-)

The point of the patch is that all applied occurrences of blk_size[][]
have disappeared. All places in the code where a size is needed, that size
comes from blkdev_size_in_bytes(), and the size comes in bytes, and the size
is a loff_t.

You want to remove these arrays - fine, so do I.
(And of course I removed them a few times, but that is another story.)
But that is an independent action. Whatever one planned to do with
blk_size[][] now applies to blk_size_in_bytes[][].
So, this patch is a step ahead but does not solve all the worlds problems
at once.

Andries

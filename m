Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292568AbSBPWGN>; Sat, 16 Feb 2002 17:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292569AbSBPWGD>; Sat, 16 Feb 2002 17:06:03 -0500
Received: from [195.63.194.11] ([195.63.194.11]:7172 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S292568AbSBPWF4>;
	Sat, 16 Feb 2002 17:05:56 -0500
Message-ID: <3C6ED7A9.5040909@evision-ventures.com>
Date: Sat, 16 Feb 2002 23:05:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] size-in-bytes
In-Reply-To: <UTC200202162141.VAA31781.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>    From dalecki@evision-ventures.com Sat Feb 16 22:09:26 2002
>
>    Andries.Brouwer@cwi.nl wrote:
>
>    > /*
>    >+ * blk_size_in_bytes contains the size of all block-devices in bytes
>    >+ * (blk_size has too low a resolution, since we really need the size
>    >+ * in 512 byte sectors, and fails on devices > 2 TB)
>    >+ *
>    >+ * blk_size_in_bytes[MAJOR][MINOR]
>    >+ *
>    >+ * if (!blk_size_in_bytes[MAJOR]) then no minor size checking is done.
>    >+ */
>    >+loff_t * blk_size_in_bytes[MAX_BLKDEV];
>    >+
>    >+/*
>
>    Please pin it up the block device structure not to just another 
>     arbitrary global array.
>
>You miss the point of the patch, perhaps forgot to read the introduction :-)
>
>The point of the patch is that all applied occurrences of blk_size[][]
>have disappeared. All places in the code where a size is needed, that size
>comes from blkdev_size_in_bytes(), and the size comes in bytes, and the size
>is a loff_t.
>
>You want to remove these arrays - fine, so do I.
>(And of course I removed them a few times, but that is another story.)
>But that is an independent action. Whatever one planned to do with
>blk_size[][] now applies to blk_size_in_bytes[][].
>So, this patch is a step ahead but does not solve all the worlds problems
>at once.
>

Well I see that you have killed all places where it get's used - that's 
fine!
But why don't just kill (fix) the initializations as well. You have already:

g->part[minor(dev)].nr_sects;

and friends right there at your hands ;-).



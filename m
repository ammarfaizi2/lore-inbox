Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269739AbRIDWfH>; Tue, 4 Sep 2001 18:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269718AbRIDWe5>; Tue, 4 Sep 2001 18:34:57 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:7075 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S269693AbRIDWen>;
	Tue, 4 Sep 2001 18:34:43 -0400
Date: Wed, 5 Sep 2001 00:34:57 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200109042234.AAA28635@harpo.it.uu.se>
To: zaitcev@redhat.com
Subject: Re: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works in 2.4.4
Cc: Floydsmith@aol.com, linux-kernel@vger.kernel.org,
        linux-tape@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001 20:14:06 -0400, Pete Zaitcev wrote:

>> - block size: The 2.4 ide-tape driver only works reliably if you
>>   write data with the correct block size. If you don't write full
>>   blocks the last block of data may not be readable.
>
>I fixed that some time ago, it's in current -ac
>if not in Linus's tree.

Sorry, but that's not correct. I just ran a test, and the bug is
still there in 2.4.9-ac7. Maybe you're thinking of some other bug?

ide-tape tells me it uses a 14*26KB buffer for my Seagate STT8000A.
If I dd a 39KB (1.5 "buffer units") file with bs=1k to /dev/ht0 it tells
me it wrote 39 blocks. If I then rewind and dd with bs=1k from /dev/ht0
it only reads 26 blocks. The same happens in 2.2 + Hedrick's IDE patch.

2.2 vanilla reads 56 blocks, of which the first 39 are identical to
what I initially wrote. The last 13 contain junk but that's not a big
problem since I back up with tar which writes its own EOF mark.

/Mikael

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264994AbSKFLun>; Wed, 6 Nov 2002 06:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264995AbSKFLun>; Wed, 6 Nov 2002 06:50:43 -0500
Received: from [202.54.39.98] ([202.54.39.98]:62478 "HELO mtsslvpngway")
	by vger.kernel.org with SMTP id <S264994AbSKFLum>;
	Wed, 6 Nov 2002 06:50:42 -0500
Message-ID: <3DC903BE.F4CD5A52@multitech.co.in>
Date: Wed, 06 Nov 2002 17:27:50 +0530
From: Pannaga Bhushan <bhushan@multitech.co.in>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-rtl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A hole in kernel space!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
        I am looking for a setup where I need to have a certain amount
of data always available to the kernel. The size of data I am looking at
is abt
40MB(preferably, but I will settle for 20MB too) . So the normal kmalloc
will not help me. So what I did was, I created a hole in kernel space by
putting
the following line in vmlinux.lds

    ALIGN(4096);
 __hole_start = .;
    . = . + 0xmy_size;
 __hole_end = .;

First, I put these lines in code segment and found that  'my_size'
cannot go beyond 0x500000(5MB) . Any larger value , the kernel image
refuses to
boot up. I found the same problem with these lines being in data segment
or in the bss segment.

But putting these line after

_end = .;

line in vmlinux.lds, I am able to give 0x1700000(17MB) to my_size and
still boot with that kernel image.

My questions are :

1.   Is there any other way I can get to keep 40MB(or even 20MB) of
contiguous kernel memory space ?

2.    Abt the 17MB hole, I am able to use after the   _end = .;
....     is this 17MB really there in kernel image?('cos it isn't in any
segment and also it
appears after _end).
        if yes, are the pages corresponding to this region swappable or
is it that since this hole appears in kernel image, it is locked to a
physical space
and this is never swapped. (basically, i want by data in kernel space
always available to kernel without having to bother abt swapping the
pages back)

Thanx in advance,
Pannaga Bhushan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129873AbQKZOEy>; Sun, 26 Nov 2000 09:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130121AbQKZOEn>; Sun, 26 Nov 2000 09:04:43 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:23556 "EHLO
        ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
        id <S129873AbQKZOE3>; Sun, 26 Nov 2000 09:04:29 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: torger@ludd.luth.se
cc: linux-kernel@vger.kernel.org
Message-ID: <CA2569A3.004A8A41.00@d73mta05.au.ibm.com>
Date: Mon, 27 Nov 2000 18:57:46 +0530
Subject: Re: How to transfer memory from PCI memory directly to user space
         safely and portable?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I'm writing a sound card driver where I need to transfer memory from the
card
>to user space using the CPU. Ideally I'd like to do that without needing
to
>have an intermediate buffer in kernel memory. I have implemented the copy
>functions like this:

>From user space to the sound card:
>
>    if (verify_area(VERIFY_READ, user_space_src, count) != 0) {
>        return -EFAULT;
>    }
>    memcpy_toio(iobase, user_space_src, count);
>    return 0;

>From the sound card to user space:
>
>    if (verify_area(VERIFY_WRITE, user_space_dst, count) != 0) {
>        return -EFAULT;
>    }
>    memcpy_fromio(user_space_dst, iobase, count);
>    return 0;


>These functions are called on the behalf of the user, so the current
process
>should be the correct one. The iobase is ioremapped:
>
>    iobase = ioremap(sound_card_port, sound_card_io_size);


The best solution will be to let the user mmap the device memory to his
address space.The driver need to provide the interface through ioctl cmd or
mmap file operations.


http://www2.linuxjournal.com/lj-issues/issue28/1287.html
The above link might be usefull though this is for pre2.4 kernel, it needs
some modification for 2.4 kernels.

Regards
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

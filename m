Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129725AbQK1BTl>; Mon, 27 Nov 2000 20:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129908AbQK1BTW>; Mon, 27 Nov 2000 20:19:22 -0500
Received: from hera.cwi.nl ([192.16.191.1]:37293 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129675AbQK1BTH>;
        Mon, 27 Nov 2000 20:19:07 -0500
Date: Tue, 28 Nov 2000 01:49:05 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Marcus Sundberg <marcus@cendio.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: real_root_dev
Message-ID: <20001128014905.B9220@veritas.com>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net> <200011270839.AAA28672@pizda.ninka.net> <20001127182113.A15029@athlon.random> <20001127182113.A15029@athlon.random> <20001127123655.A16930@munchkin.spectacle-pond.org> <vey9y5umvv.fsf@lipta.cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <vey9y5umvv.fsf@lipta.cendio.se>; from marcus@cendio.se on Mon, Nov 27, 2000 at 10:27:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 10:27:00PM +0100, Marcus Sundberg wrote:

> This reminded me of an old bug which apparently still hasn't been
> fixed (not in 2.2 at least). In init/main.c we have:
> 
> extern int rd_image_start;	/* starting block # of image */
> #ifdef CONFIG_BLK_DEV_INITRD
> kdev_t real_root_dev;
> #endif
> #endif
> 
> int root_mountflags = MS_RDONLY;
> 
> and then in kernel/sysctl.c:
> 
> #ifdef CONFIG_BLK_DEV_INITRD
> 	{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),
> 	 0644, NULL, &proc_dointvec},
> #endif
> 
> Because rd_image_start and root_mountflags are both int-aligned,
> this happens to work on little endian platforms. On big endian
> platforms however writing a value in the range 0-65535 to 
> /proc/sys/kernel/real-root-dev will place 0 in real_root_dev,
> and the actual value in the two padding bytes...
> 
> Unfortunately proc_dointvec() doesn't support shorts, so what is
> the correct fix? Changing:
> kdev_t real_root_dev;
> into
> int real_root-dev;
> is a perfectly working solution, but is it acceptable?

If you compile the kernel and use an integral type for kdev_t, perhaps.
On the other hand, I usually use a pointer type for kdev_t, and then
this entire sysctl construction is broken.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

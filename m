Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130282AbRAWMJ2>; Tue, 23 Jan 2001 07:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130359AbRAWMJJ>; Tue, 23 Jan 2001 07:09:09 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:8372 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S130282AbRAWMJC>;
	Tue, 23 Jan 2001 07:09:02 -0500
Date: Tue, 23 Jan 2001 13:08:54 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101231208.NAA29008@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, tmolina@home.com
Subject: Re: problem with dd for floppy under 2.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001 23:23:36 -0600 (CST), Thomas Molina wrote:

>[1.] One line summary of the problem: seek= parameter for dd under 2.4.0
>gives permission denied error
>[2.] Full description of the problem/report:I was creating a new
>root+boot disk for 2.4.0 this evening.  I issued the command:
>dd if=/tmp/rootfs.gz of=/dev/fd0 bs=1k seek=335
>
>and got the error message:
>dd: /dev/fd0: Permission denied

There's a known bug in dd where it incorrectly attempts to truncate
the output file even though it's a block device. In kernels older
than 2.4.0-test10 or so it got away with this, but now the kernel
correctly returns an error.

Use the 'conv=notrunc' option to dd to fix this, i.e.

    dd if=rootfs.gz of=/dev/fd0 bs=1k conv=notrunc seek=XXX


/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

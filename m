Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTLDWch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTLDWbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:31:55 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:64457 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263636AbTLDWbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:31:11 -0500
Date: Thu, 4 Dec 2003 22:31:09 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
In-Reply-To: <Pine.GSO.4.44.0312041620210.25354-100000@math.ut.ee>
Message-ID: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk>
References: <Pine.GSO.4.44.0312041620210.25354-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

2.4.23-bk has a changeset (post 2.4.23 release TAG) that makes edd not
compile as Meelis Roos already reported:

On Thu, 4 Dec 2003, Meelis Roos wrote:
> gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup  -DEXPORT_SYMTAB -c setup.c
> setup.c: In function `copy_edd':
> setup.c:734: error: `DISKSIG_BUFFER' undeclared (first use in this function)
> setup.c:734: error: (Each undeclared identifier is reported only once
> setup.c:734: error: for each function it appears in.)
> make[1]: *** [setup.o] Error 1
>
> DISKSIG_BUFFER is nowhere to be seen.

Further, looking at the header files the closest constant that does exist
is #define DISK80_SIG_BUFFER 0x228 from include/asm-i386/edd.h.

However, changing DISKSIG_BUFFER to DISK80_SIG_BUFFER causes the kernel to
reboot the computer as soon as it starts booting.  Basically I select it
in grub and the screen changes graphics mode and by the time it has
finished the switch the computer reboots.

2.4.23-bk at the 2.4.23 release TAG works fine and compiles fine with the
same .config.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

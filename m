Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbQLBTyH>; Sat, 2 Dec 2000 14:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbQLBTx4>; Sat, 2 Dec 2000 14:53:56 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:7956 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129842AbQLBTxl>; Sat, 2 Dec 2000 14:53:41 -0500
Date: Sat, 2 Dec 2000 13:23:01 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Wolfgang Spraul <wspraul@q-ag.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: arch/i386/boot/bootsect.S incompatible with Vaio C1VE (Crusoe) floppy
In-Reply-To: <975784573.3a294a7dcabfd@ssl.local>
Message-ID: <Pine.LNX.3.96.1001202131716.1450C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2000, Wolfgang Spraul wrote:
> 2.4.0-test11, arch/i386/boot/bootsect.S has a probe_loop: to determine the
> number of sectors that can be read at once (i.e. in one track).
> 
> This routine does not work with the Sony UDF5 USB floppy disk, mapped as an
> Int13 device by the Vaio C1VE (Crusoe) BIOS.
> Therefore, a bzdisk floppy will not be bootable.

The bzdisk code is used so infrequently compared to the normal
bootloaders, lilo, grub, and syslinux, that I'm not surprised it has
problems with many edge cases.

Although I imagine this is an unpopular opinion, I think that we
should remove all bzdisk-type code from X86...	syslinux and other
boot loaders handle weird BIOS quirks much better, simply because
they are used in far more situations than bzdisk.

syslinux especially is quite nice for loading kernels from floppy.
It's very small, and "syslinux -s" adds in some wonderfully-paranoid
sanity checks which make boot loading works on many a quirky BIOS.
(don't use '-s' unless you need it, of course, it slows things down...)

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

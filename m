Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbQLRMm7>; Mon, 18 Dec 2000 07:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbQLRMmx>; Mon, 18 Dec 2000 07:42:53 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:38019 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130670AbQLRMmn>; Mon, 18 Dec 2000 07:42:43 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200012181211.NAA15721@sunrise.pg.gda.pl>
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
To: tigran@veritas.com (Tigran Aivazian)
Date: Mon, 18 Dec 2000 13:11:15 +0100 (MET)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012181150060.840-100000@penguin.homenet> from "Tigran Aivazian" at Dec 18, 2000 11:56:47 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tigran Aivazian wrote:"
> In November last year I wrote support for a new boot parameter called
> "rootfs" implementing functionality similar to  UnixWare7, i.e. being
> able to specify the filesystem type to try first in mount_root() and if
> this fails then go on to the usual loop over all registered filesystems.
> 
> At the time it was of pure academical interest (i.e. generally useful to
> everybody) but now I realized that it is actually quite critical, i.e.
> there exist filesystems (e.g. ext2) which are not able to detect their
> structural integrity beyond simple damage to the superblock. So, as a

It is more critical now if one wants to use eg. UMSDOS filesystem as root fs.
As the msdos filesystem is linked first system always tries to use it first
when there is a FAT filesystem on the root device.

One way of solving the problem is the "rootfs" parameter.
Changing link sequence to be non-alphabetic is another choice...

However, it is a separate issue that UMSDOS-root is broken in 2.4 at the
moment. But I hope it is not a permanent state.

> diff -urN -X dontdiff linux/Documentation/kernel-parameters.txt rootfs/Documentation/kernel-parameters.txt
> --- linux/Documentation/kernel-parameters.txt	Tue Sep  5 21:51:14 2000
> +++ rootfs/Documentation/kernel-parameters.txt	Mon Dec 18 09:04:06 2000
> @@ -473,7 +473,10 @@
>  
>  	ro		[KNL] Mount root device read-only on boot.
>  
> -	root=		[KNL] root filesystem.
> +	root=		[KNL] Mount root filesystem on specified (as hex or "/dev/XXX") device.
> +
> +	rootfs=		[KNL] Use filesystem type specified (e.g. rootfs=ext2) for root.
> + 
>  
>  	rw		[KNL] Mount root device read-write on boot.
>  

Regards
   Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

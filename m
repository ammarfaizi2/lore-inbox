Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282914AbRLBQyg>; Sun, 2 Dec 2001 11:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281488AbRLBQyW>; Sun, 2 Dec 2001 11:54:22 -0500
Received: from pl475.nas921.ichikawa.nttpc.ne.jp ([210.165.235.219]:51512 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S282895AbRLBQyC>;
	Sun, 2 Dec 2001 11:54:02 -0500
Date: Mon, 3 Dec 2001 01:53:56 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Kilobug <kilobug@freesurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.1-pre5 failed to compile (module ide-tape.c)
Message-Id: <20011203015356.663d9087.bruce@ask.ne.jp>
In-Reply-To: <3C0A3EB2.7090802@freesurf.fr>
In-Reply-To: <3C0A3EB2.7090802@freesurf.fr>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2001 15:46:10 +0100
Kilobug <kilobug@freesurf.fr> wrote:

> While doing 'make modules':
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.1-pre5/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon  -DMODULE   -c -o ide-tape.o ide-tape.c
> ide-tape.c: In function `idetape_input_buffers':
> ide-tape.c:1512: structure has no member named `b_reqnext'

[SNIP]

This is caused by the block I/O changes going into 2.5. Unfortunately, ATM it
looks like they break at least the following:

drivers/block/acsi.c
drivers/scsi/scsi_debug.c
drivers/ide/icside.c
drivers/ide/ide-pmac.c
drivers/ide/ide-tape.c
drivers/s390/block/dasd_diag.c
drivers/s390/block/dasd_eckd.c
drivers/s390/block/dasd_fba.c
drivers/s390/char/tape34xx.c
drivers/s390/char/tapeblock.c
drivers/md/raid5.c
arch/cris/drivers/ide.c

And most likely the following as well:

include/linux/elevator.h
drivers/ide/hptraid.c
drivers/ide/pdcraid.c
drivers/ide/ataraid.c
drivers/md/raid1.c
drivers/md/multipath.c


Bruce

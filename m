Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbSJ2Pte>; Tue, 29 Oct 2002 10:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSJ2Pte>; Tue, 29 Oct 2002 10:49:34 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50898 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261911AbSJ2Ptd>; Tue, 29 Oct 2002 10:49:33 -0500
Date: Tue, 29 Oct 2002 16:55:50 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Martin Diehl <lists@mdiehl.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jean Tourrilhes <jt@hpl.hp.com>, <linux-kernel@vger.kernel.org>,
       <trivial-feedback@rustcorp.com.au>
Subject: Re: [2.5 patch] remove 2.4 compatibility code from irda/vlsi_ir.h
In-Reply-To: <Pine.LNX.4.44.0210210921140.5689-100000@notebook.home.mdiehl.de>
Message-ID: <Pine.NEB.4.44.0210291633540.14144-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Martin Diehl wrote:

> On Sun, 20 Oct 2002, Adrian Bunk wrote:
>
> Hi Adrian,

Hi Martin,

>...
> Anyway, of course I agree with you the stuff must not break compiling.
> It looks like you are right, there's a linux/version.h missing in the
> includes. Does this solve the issue for you (it does for me)?


yes, this fixes it.

Alan:
You did already include my patch into -ac. Please remove my patch to
include/net/irda/vlsi_ir.h from -ac and include Martin's patch (at the
bottom of this mail) instead.


> > vlsi_ir.h in 2.4 and 2.5 differ significantly, and I therefore suggest the
> > following patch to remove the compatibility stuff that caused this problem
> > (IMHO a better solution than an #include <linux/version.h>):
>
> The 2.5/2.4 differences are only temporarily there and due to the usual
> approach to apply new stuff to 2.5 first before moving into 2.4. The
> current 2.5 code should go into 2.4 rather soon and there will be further
> changes along this path. So the compatibility defines are there for a good
> reason and the very few differences between 2.4 and 2.5 (wrt. this
> driver) do not justify the increased effort of having two versions.
>
> > -#define pci_dma_prep_single(dev, addr, size, direction)	/* nothing */
>
> If this gets removed I can assure you the driver won't compile ;-)

You are right, this was surrounded by so much comment that I assumed it
was a comment, too...

Unfortunately the file compiled with a "implicit declaration of function
`pci_dma_prep_single'" and since the .config I was using is far from
getting to the final linking stage I didn't notice the problem...

> Please apply the following fix.
>
> Thanks
> Martin

cu
Adrian


--- linux-2.5.44/drivers/net/irda/vlsi_ir.c	Sat Oct 12 13:51:07 2002
+++ v2.5.44-md-ob/drivers/net/irda/vlsi_ir.c	Mon Oct 21 19:23:53 2002
@@ -44,6 +44,7 @@
 #include <linux/time.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/version.h>
 #include <asm/uaccess.h>

 #include <net/irda/irda.h>








Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131570AbQKNX0F>; Tue, 14 Nov 2000 18:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131595AbQKNXZz>; Tue, 14 Nov 2000 18:25:55 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:59399 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S131582AbQKNXZm>; Tue, 14 Nov 2000 18:25:42 -0500
Date: Tue, 14 Nov 2000 23:56:00 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c compile
 failure
In-Reply-To: <200011132244.OAA03269@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.21.0011142345440.2383-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000, Adam J. Richter wrote:

> 	linux-2.4.0-test11-pre4/drivers/sound/yss225.c uses __initdata
> but does not include <linux/init.h>, so it could not compile.  I have
> attached below.
> 
> 	Note that I am a bit uncertain about the correctness of
> the __initdata prefix here in the first place.  Is yss225 a PCI
> device?  If so, a kernel that supports PCI hot plugging should
> be prepared to support the possibility of a hot pluggable yss225
> card being inserted after the module has already been initialized.
> Even if no CardBus or CompactPCI version of yss225 hardware exists
> yet, it will require less maintenance for PCI drivers to be prepared
> for this possibility from the outset (besides, is it possible to have a
> hot pluggable PCI bridge card that bridges to a regular PCI bus?).

Good question....

>
> 	So, if yss225 is a PCI device, the declaration should use
> __devinitdata.  On the other hand, if it is ISA only, then __initdata
> should be correct.

Currently not a problem because yss225.c is used only by wavfront.c which
is a driver for Turtle Beach WaveFront Series (ISA)...

> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> 
> --- linux-2.4.0-test11-pre4/drivers/sound/yss225.c	Mon Nov 13 13:36:50 2000
> +++ linux/drivers/sound/yss225.c	Mon Nov 13 09:11:02 2000
> @@ -1,3 +1,4 @@
> +#include <linux/init.h>
>  unsigned char page_zero[] __initdata = {
>  0x01, 0x7c, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf5, 0x00,
>  0x11, 0x00, 0x20, 0x00, 0x32, 0x00, 0x40, 0x00, 0x13, 0x00, 0x00,
> 

Rasmus Andersen have already posted three patches
which fix my temporary braindamage (linux/init.h)...

Right know I don't care too much about hotplugging because most
of drivers are broken anyway (or not?)... I _will_ try to fix
hotplugging later (I'm talking not only about sound)... as it needs
some further investigation...

Regards
--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTDUN0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbTDUN0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 09:26:25 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:46722 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S261177AbTDUN0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 09:26:24 -0400
Date: Mon, 21 Apr 2003 15:38:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>, porter@cox.net
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix scsi build on !CONFIG_GENERIC_ISA_DMA
In-Reply-To: <200304180612.h3I6CnZV016165@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0304211537130.14857-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1101, 2003/04/17 22:02:50-07:00, porter@cox.net
> 
> 	[PATCH] Fix scsi build on !CONFIG_GENERIC_ISA_DMA
> 	
> 	This allows the SCSI subsystem to build on systems where
> 	CONFIG_GENERIC_ISA_DMA is not set.
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1100  -> 1.1101 
> #	drivers/scsi/hosts.c	1.56    -> 1.57   
> #
> 
>  hosts.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> 
> diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> --- a/drivers/scsi/hosts.c	Thu Apr 17 23:12:56 2003
> +++ b/drivers/scsi/hosts.c	Thu Apr 17 23:12:56 2003
> @@ -183,8 +183,10 @@
>  {
>  	if (shost->irq)
>  		free_irq(shost->irq, NULL);
> +#ifdef CONFIG_GENERIC_ISA_DMA
>  	if (shost->dma_channel != 0xff)
>  		free_dma(shost->dma_channel);
> +#endif
>  	if (shost->io_port && shost->n_io_port)
>  		release_region(shost->io_port, shost->n_io_port);

Hence it needs to include <linux/config.h>

--- linux-2.5.68/drivers/scsi/hosts.c	Sun Apr 20 12:28:47 2003
+++ linux-m68k-2.5.68/drivers/scsi/hosts.c	Sun Apr 20 12:51:54 2003
@@ -27,6 +27,7 @@
  *  hosts currently present in the system.
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/blk.h>
 #include <linux/kernel.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


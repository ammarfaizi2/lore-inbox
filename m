Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272336AbTG3XXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272337AbTG3XXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:23:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36869
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S272336AbTG3XXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:23:31 -0400
Date: Wed, 30 Jul 2003 16:14:14 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@ucw.cz>
cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about taskfile?
In-Reply-To: <20030730205935.GA238@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10307301609580.19607-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If your corruption is only under DMA you have a chipset or an ./arch/
problem.  If you have corruption under PIO, this could be a timing error.
If command mode of taskfile is at issue, you can not function period.

If this only happens on writes, you have a FIFO problem in the ASIC or
iotable for the scatter gather formation.

Taskfile is not broken, it is the only means to talk to an ATA/ATAPI/SATA
device.  How Taskfile is executed is dependent on the device attached.

So if this is the x86-64 issue you have to fix that arch.

-a

On Wed, 30 Jul 2003, Pavel Machek wrote:

> Hi!
> 
> I had some strange fs corruption, and andi suggested that it probably
> is TASKFILE-related. Perhaps this is good idea?
> 
> 								Pavel
> 
> --- clean/drivers/ide/Kconfig	2003-07-27 22:31:13.000000000 +0200
> +++ linux/drivers/ide/Kconfig	2003-07-30 22:56:50.000000000 +0200
> @@ -283,7 +283,8 @@
>  	---help---
>  	  Use new taskfile IO code.
>  
> -	  It is safe to say Y to this question, in most cases.
> +	  It is safe to say Y to this question, but you should attach
> +	  scratch monkey, first.
>  
>  comment "IDE chipset support/bugfixes"
>  	depends on BLK_DEV_IDE
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSFUO5k>; Fri, 21 Jun 2002 10:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316636AbSFUO5j>; Fri, 21 Jun 2002 10:57:39 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:27373 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S316632AbSFUO5g>; Fri, 21 Jun 2002 10:57:36 -0400
To: dalecki@evision-ventures.com, Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: error: DMA in progress..
In-Reply-To: <3D13098E.2020100@evision-ventures.com>
References: <20020621092459.GD27090@suse.de> <3D12FA4D.6060500@evision-ventures.com> <20020621101202.GF27090@suse.de> <3D130095.6050207@evision-ventures.com> <20020621103553.GI27090@suse.de> <3D13098E.2020100@evision-ventures.com>
Message-Id: <E17LPqm-0006S3-00@come.alcove-fr>
From: Stelian Pop <stelian@fr.alcove.com>
Date: Fri, 21 Jun 2002 16:57:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you add a reporting about
> the handler function there:
> 
>   	if (test_bit(IDE_DMA, ch->active)) {
> 			printk(KERN_ERR "%s: error: DMA in progress... %p\n",
>   drive->name, ch->handler);
> 			break;
> 		}
> 
> And please take a short look at System.map.
> 
> This will show which IRQ handler is the culprit...

Martin, I have the same problem on my Sony Vaio C1VE, 
Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01), HITACHI_DK23AA-12 disk.

It doesn't even boot, the "DMA in progress error..." appears just
after having mounted the root partition. 2.5.23 worked on this laptop.

I've added, as you suggested the following patch:

===== drivers/ide/ide.c 1.110 vs edited =====
--- 1.110/drivers/ide/ide.c	Thu Jun 20 13:28:43 2002
+++ edited/drivers/ide/ide.c	Fri Jun 21 16:46:29 2002
@@ -863,7 +863,7 @@
 		drive->sleep = 0;
 
 		if (test_bit(IDE_DMA, ch->active)) {
-			printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
+			printk(KERN_ERR "%s: error: DMA in progress...%p\n", drive->name, ch->handler);
 			break;
 		}

And the bad news is that ch->handler is NULL...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

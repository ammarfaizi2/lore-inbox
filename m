Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269536AbUINROf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269536AbUINROf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269532AbUINRMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:12:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11454 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269473AbUINRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:03:05 -0400
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41471163.10709@rtr.ca>
References: <41471163.10709@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095177622.16990.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 17:00:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 16:42, Mark Lord wrote:
> Please email me any errors or corrections you may deem necessary
> for kernel inclusion.

Nothing says its GPL

qstor_printk uses a fixed length buffer yet we have vprintk. It also
appears to be full of magic maybe formatting stuff to optionally insert
things like DRIVER_NAME. Is there a reason for not just using printk ?

qstore_test_logbuf returns the flags value across functions. Not all
platforms can support this (see Rusty's unreliable guide)

What is qstor_alloc about ?

What happens if qstor_scsi_proc_write is passed a length of 
0xFFFFFFFF. You seem to have no upper bound nor any trap on the 
alloc overflow. Seems a horrible way to expose the raid commands too ?

qstor_exec_special_cmd doesn't consider datalen overflow. I'm not sure
what stops a lot of parallel callers here but not sure if thats fixed by
the command queueing ?

Correct ioctl return is -ENOTTY for unknown (thats a mistake still in
many existing drivers so no suprise its still being copied)

The ioremap_nocache should just be ioremap I believe

Announces for the driver should be KERN_INFO IMHO

Reset code seems to be spending a lot of time with irq's off ?

qstor_dealloc_device checks dev->id != NULL - kfree(NULL) is an allowed
no-op btw.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTJCAnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTJCAnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:43:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:58573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263565AbTJCAnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:43:05 -0400
Date: Thu, 2 Oct 2003 17:43:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Aniket Malatpure <aniket@sgi.com>
Cc: linux-kernel@vger.kernel.org, gwh@sgi.com, jeremy@sgi.com, jbarnes@sgi.com,
       aniket_m@hotmail.com,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Message-Id: <20031002174304.5c984dc9.akpm@osdl.org>
In-Reply-To: <3F7CB4A9.3C1F1237@sgi.com>
References: <3F7CB4A9.3C1F1237@sgi.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniket Malatpure <aniket@sgi.com> wrote:
>
> Hi
> 
> This patch adds support for the ATAPI part of SGI's IOC4 chipset.
> A version of this patch for the 2.4 series has been accepted and is present in the tree.
> This patch is a slight modification of the earlier patch for the 2.4 series.
> 

Perhaps Bart could take a look over this sometime please?


> +++ b/drivers/ide/pci/sgiioc4.c	Thu Oct  2 16:53:34 2003
> +
> +extern int dma_timer_expiry(ide_drive_t * drive);

This is unused.  Just as well, as it is static to a different file.

> +static struct pci_device_id sgiioc4_pci_tbl[] __devinitdata = {

This cannot be __devinitdata because the PCI table walking will look at it
even after __init code has been dropped.  We've had oopses from this.

> --- /dev/null	Wed Dec 31 16:00:00 1969
> +++ b/drivers/ide/pci/sgiioc4.h	Thu Oct  2 16:53:34 2003

hrm, why does this file exist?  It has only one include site, and should
not be included by other .c files anyway because it defines static storage.

It looks like the whole file should just be pasted into sgiioc4.c?

> +typedef volatile struct {
> +	u32 timing_reg0;
> +	u32 timing_reg1;
> +	u32 low_mem_ptr;
> +	u32 high_mem_ptr;
> +	u32 low_mem_addr;
> +	u32 high_mem_addr;
> +	u32 dev_byte_count;
> +	u32 mem_byte_count;
> +	u32 status;
> +} ioc4_dma_regs_t;

Does this actually need to be volatile?



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTEHIty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbTEHIty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:49:54 -0400
Received: from [212.50.18.217] ([212.50.18.217]:1032 "EHLO gw.zaxl.net")
	by vger.kernel.org with ESMTP id S261231AbTEHItv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:49:51 -0400
Date: Thu, 8 May 2003 12:02:41 +0300 (EEST)
From: Alexander Atanasov <alex@ssi.bg>
To: David Ford <david+powerix@blue-labs.org>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.5.69, IDE problems
In-Reply-To: <3EB9F541.7060008@blue-labs.org>
Message-ID: <Pine.LNX.4.21.0305081147280.20708-100000@mars.zaxl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On Thu, 8 May 2003, David Ford wrote:

> hda: dma_timer_expiry: dma status == 0x24
> drivers/ide/ide-io.c:108: spin_lock(drivers/ide/ide.c:c04fb648) already 
> locked by drivers/ide/ide-io.c/948
> drivers/ide/ide-io.c:990: spin_unlock(drivers/ide/ide.c:c04fb648) not locked
> hda: lost interrupt
> hda: dma_intr: bad DMA status (dma_stat=30)
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> hda: dma_timer_expiry: dma status == 0x24
> drivers/ide/ide-io.c:108: spin_lock(drivers/ide/ide.c:c04fb648) already 
> locked by drivers/ide/ide-io.c/948
> drivers/ide/ide-io.c:990: spin_unlock(drivers/ide/ide.c:c04fb648) not locked
> hda: lost interrupt
> hda: dma_intr: bad DMA status (dma_stat=30)
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }

	known problem, patch sent to alan some time ago(may be i should
resync/resend?) for this dma_timer_expiry have several problems:
calls DRIVER(drive)->error - the one above, it's called with lock from
ide_timer_expiry
calls ide_dma_end - the reason for called while not waiting messages,
it's called again in ide_timer_expiry

there is one more locking problem known to me - HDIO_DRIVE_RESET,
but can not find out how to fix it properly.

-- 
have fun,
alex


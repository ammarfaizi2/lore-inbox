Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTHESy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHESy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:54:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61321 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267724AbTHESyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:54:54 -0400
Date: Tue, 5 Aug 2003 20:54:44 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix error return get/set_native_max functions
In-Reply-To: <UTC200308051818.h75IIB517382.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0308052045390.21574-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Aug 2003 Andries.Brouwer@cwi.nl wrote:

> In ide-disk.c we have functions
>   idedisk_read_native_max_address
>   idedisk_read_native_max_address_ext
>   idedisk_set_max_address
>   idedisk_set_max_address_ext
> that are documented as
>
>  /*
>   * Sets maximum virtual LBA address of the drive.
>   * Returns new maximum virtual LBA address (> 0) or 0 on failure.
>   */
>
> The IDE command they execute returns the largest address,
> and 1 is added to get the capacity.
> Unfortunately, the code does
>
> 	addr = 0;
> 	if (ide_command_succeeds) {
> 		addr = ...
> 	}
> 	addr++;
>
> so that the return value on error is 1 instead of 0.
> The patch below moves the addr++.
>
> Andries

This change is okay, thanks.

However changing coding style is not...

> @@ -1002,7 +1003,8 @@
>   * Sets maximum virtual LBA address of the drive.
>   * Returns new maximum virtual LBA address (> 0) or 0 on failure.
>   */
> -static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
> +static unsigned long
> +idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
>  {
>  	ide_task_t args;
>  	unsigned long addr_set = 0;

--
Bartlomiej


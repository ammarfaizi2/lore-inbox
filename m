Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933832AbWKWQDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933832AbWKWQDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933794AbWKWQDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:03:46 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:44811 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933832AbWKWQDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:03:46 -0500
Date: Thu, 23 Nov 2006 16:03:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix random SD/MMC card recognition failures on ARM Versatile
Message-ID: <20061123160335.GB8984@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>, drzeus-mmc@drzeus.cx,
	linux-kernel@vger.kernel.org
References: <20061123184606.bb203ae6.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123184606.bb203ae6.vitalywool@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 06:46:06PM +0300, Vitaly Wool wrote:
> Hello Pierre,
> 
> currently sometimes the SD/MMC card inserted results in recognition failure on ARM Versatile board:
> 
>    <<<Plug in MMC card>>>
> 
> root@versatile:~# mmcblk0: mmc0:0001 SDMB-32 31360KiB
>  mmcblk0:<3>mmcblk0: error 3 transferring data
> end_request: I/O error, dev mmcblk0, sector 0
> Buffer I/O error on device mmcblk0, logical block 0
> mmcblk0: error 3 transferring data
> end_request: I/O error, dev mmcblk0, sector 0
> Buffer I/O error on device mmcblk0, logical block 0
>  unable to read partition table
> 
> This patch fixes the problem.

Doubtful.  mmci_stop_data() already does this, which will be called
immediately prior to mmci_request_end().  So you're doubling up the
writes to registers again.

Since this is not the first occurance that you've had to do this with
your board (the other being the SIC) I suggest that your board is
faulty in some way, causing writes to registers to be occasionally
dropped.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

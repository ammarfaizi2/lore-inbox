Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVLNOYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVLNOYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVLNOYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:24:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24584 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932535AbVLNOYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:24:01 -0500
Date: Wed, 14 Dec 2005 14:23:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <briglia.anderson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] [RFC] Add MMC password protection (lock/unlock) support
Message-ID: <20051214142355.GA7124@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <briglia.anderson@gmail.com>,
	linux-kernel@vger.kernel.org
References: <e55525570512140529v8aafdd4m1290cf2c2069a7c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55525570512140529v8aafdd4m1290cf2c2069a7c8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:29:25AM -0400, Anderson Briglia wrote:
> - Currently, some host drivers assume the block length will always be a power
>   of 2. This is not true for the MMC_LOCK_UNLOCK command, which is a block
>   command that accepts arbitratry block lengths. We have made the necessary
>   changes to the omap.c driver (present on the linux-omap tree), but the same
>   needs to be done for other hosts' drivers.

Some MMC hosts require that the data transfer be a multiple of the
block size.  Therefore, set blksz_bits to the biggest power of two
which represents the buffer, and use "blocks" to set the length of
the transfer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

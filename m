Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbULKTLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbULKTLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbULKTLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:11:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42246 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261994AbULKTLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:11:17 -0500
Date: Sat, 11 Dec 2004 19:11:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arne Caspari <arne@datafloater.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/driver.c : driver_unregister
Message-ID: <20041211191113.A13985@flint.arm.linux.org.uk>
Mail-Followup-To: Arne Caspari <arne@datafloater.de>,
	linux-kernel@vger.kernel.org
References: <41BB4268.8020908@datafloater.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41BB4268.8020908@datafloater.de>; from arne@datafloater.de on Sat, Dec 11, 2004 at 07:54:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 07:54:32PM +0100, Arne Caspari wrote:
> I think the meaning of this patch is obvious: In driver_unregister, the 
> bus_remove_driver function call was called outside the driver unload 
> semaphore which should obviously protect it.

No.  The semaphore is there to ensure that the function does not
return until the driver structure has a use count of zero.  If you
tested your patch, you'd find that your change would deadlock on
the locked semaphore.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

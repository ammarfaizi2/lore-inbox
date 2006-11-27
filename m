Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758052AbWK0LY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbWK0LY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758054AbWK0LY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:24:58 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:37386 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1758052AbWK0LY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:24:58 -0500
Date: Mon, 27 Nov 2006 11:24:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Greg K-H <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/7] driver core fixes: device_register() retval check in platform.c
Message-ID: <20061127112447.GA28761@flint.arm.linux.org.uk>
Mail-Followup-To: Cornelia Huck <cornelia.huck@de.ibm.com>,
	Greg K-H <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20061127103508.36d36539@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127103508.36d36539@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 10:35:08AM +0100, Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Check the return value of device_register() in platform_bus_init().

I still say this is absolutely crazy.  If a bus does not get registered,
what happens to all the devices and drivers which are registered against
that bus?

I suspect that if this bus_register doesn't work, you'll see an oops
sooner or later.  So it might as well be a BUG_ON here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

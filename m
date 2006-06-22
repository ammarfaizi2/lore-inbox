Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWFVSnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWFVSnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWFVSnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:43:16 -0400
Received: from ns2.suse.de ([195.135.220.15]:30658 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751215AbWFVSnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:43:15 -0400
Date: Thu, 22 Jun 2006 11:39:55 -0700
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [i2c] [PATCH] I2C bus driver for Philips ARM boards
Message-ID: <20060622183955.GA6372@kroah.com>
References: <20060622153146.2ae56e33.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622153146.2ae56e33.vitalywool@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 03:31:46PM +0400, Vitaly Wool wrote:
> +static inline int i2c_pnx_bus_busy(volatile struct i2c_regs *master)
> +{
> +	long timeout;
> +
> +	timeout = TIMEOUT * 10000;
> +	if (timeout > 0 && (master->sts & mstatus_active)) {

Please use the proper ioread() function to read from memory, and don't
rely on a memory mapped structure.  Linux does this in order to work for
all platforms.

A big hint about this, if you have volatile in your driver, it's
wrong...

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269983AbTGPBQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTGPBQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:16:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:50081 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269983AbTGPBQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:16:07 -0400
Date: Tue, 15 Jul 2003 18:28:41 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@convergence.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] Add a driver for the Technisat Skystar2 DVB card
Message-ID: <20030716012841.GA2017@kroah.com>
References: <1058271657827@convergence.de> <10582716573394@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10582716573394@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 02:20:57PM +0200, Michael Hunold wrote:
> +
> +/////////////////////////////////////////////////////////////////////
> +//              register functions
> +/////////////////////////////////////////////////////////////////////
> +
> +void WriteRegDW(struct adapter *adapter, u32 reg, u32 value)

Hm, this really isn't the proper Linux coding style.  Please read
Documentation/CodingStyle on how to name functions.

> +{
> +	u32 flags;

flags has to be a unsigned long.

> +
> +	save_flags(flags);
> +	cli();

Huh?  Did you even compile this on a SMP kernel on 2.5?  (Hint, it will
not...)  Please fix this up.

> +u32 ReadRegDW(struct adapter *adapter, u32 reg)
> +{
> +	return readl(adapter->io_mem + reg);
> +}

Why?  Why not just write the readl() function whereever you call
ReadRegDW?

> +/////////////////////////////////////////////////////////////////////
> +//                      I2C
> +////////////////////////////////////////////////////////////////////
> +
> +u32 i2cMainWriteForFlex2(struct adapter * adapter, u32 command, u8 * buf, u32 retries)

kernel functions traditionally return an int.  A negative number if
there is an error, and 0 if there isn't.

Oh, any reason for not tying this to the existing i2c core?
Or is that done somewhere else?

thanks,

greg k-h

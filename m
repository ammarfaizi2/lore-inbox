Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUD0PgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUD0PgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUD0PgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:36:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:60826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264183AbUD0Pfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:35:44 -0400
Date: Tue, 27 Apr 2004 08:35:12 -0700
From: Greg KH <greg@kroah.com>
To: stefan.eletzhofer@eletztrick.de, linux-kernel@vger.kernel.org
Subject: Re: i2c_get_client() missing?
Message-ID: <20040427153512.GA19633@kroah.com>
References: <20040427150144.GA2517@gonzo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427150144.GA2517@gonzo.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 05:01:44PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> Hi,
> I'm in the process of porting my Epson 8564 RTC chip from 2.4 to
> 2.6.6-rc2. This is a RTC chip sitting on a I2C bus.
> 
> The code is here:
> http://213.239.196.168/~seletz/patches/2.6.6-rc2/i2c-rtc8564.patch
> http://213.239.196.168/~seletz/patches/2.6.6-rc2/machine-raalpha-rtc.patch
> 
> In order to split up functionality (I2C bus access and RTC misc device
> stuff) I wrote two separate modules. In the rtc code module I did a i2c_get_client()
> with the ID of my RTC chip to get a struct i2c_client which I think I need to
> talk to the chip. I've implemented the command callback in my I2C module, which
> I want to call from my RTC module.
> 
> Now I find that in 2.6.6-rc2 the i2c_get_client() implementation is missing (the prototype
> is still in linux/i2c.h). Even the docs for i2c_use_client() refer to that function.

It was removed as there were no users of it from what I remember.  I
should go and delete that prototype too...

> Most probably I'm missing something, but how is one supposed to access a i2c-client's
> command function when i2c_get_client() is missing?

Where do you need to access it from?  Why do all of the current drivers
not need it?

> Of course I could just merge these two drivers and forget about
> separating i2c chip access and rtc stuff, but ...

If you always need both drivers to get the system to work, and there's
no real reason to split them up...

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUAYDUM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 22:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUAYDUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 22:20:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:8132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263632AbUAYDUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 22:20:06 -0500
Date: Sat, 24 Jan 2004 19:20:03 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Linux 2.6.2-rc1
Message-ID: <20040125032003.GA8455@kroah.com>
References: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org> <20040124225612.GC4072@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124225612.GC4072@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 11:56:12PM +0100, J.A. Magallon wrote:
> 
> On 01.21, Linus Torvalds wrote:
> > 
> > Ok, this is the next "big merge" with things from Andrew's -mm tree, along
> > with a number of new drivers and arch updates.
> > 
> 
> drivers/i2c/chips/w83781d.c is flooding my syslog with:
> 
> Jan 24 23:50:36 werewolf kernel: Starting device update
> Jan 24 23:51:09 werewolf last message repeated 11 times
> Jan 24 23:52:12 werewolf last message repeated 21 times
> Jan 24 23:53:15 werewolf last message repeated 21 times
> Jan 24 23:54:18 werewolf last message repeated 21 times
> 
> so:
> 
> --- linux-2.6.2-rc1/drivers/i2c/chips/w83781d.c.orig	2004-01-24 23:53:02.579206290 +0100
> +++ linux-2.6.2-rc1/drivers/i2c/chips/w83781d.c	2004-01-24 23:53:13.862321904 +0100
> @@ -1656,7 +1656,6 @@
>  	if (time_after
>  	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
>  	    || time_before(jiffies, data->last_updated) || !data->valid) {
> -		pr_debug("Starting device update\n");
>  
>  		for (i = 0; i <= 8; i++) {
>  			if ((data->type == w83783s || data->type == w83697hf)
> 
> Correct ?

No, just disable the CONFIG_I2C_DEBUG_CHIP option.  That will get rid of
the messages for you.

thanks,

greg k-h

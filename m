Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUBDBFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUBDBFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:05:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:47329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265148AbUBDBFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:05:37 -0500
Date: Tue, 3 Feb 2004 17:01:59 -0800
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv oops
Message-ID: <20040204010159.GA23386@kroah.com>
References: <401E69AD.4080606@earthlink.net> <87u129eb5p.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u129eb5p.fsf@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 04:47:14PM +0100, Gerd Knorr wrote:
> Stephen Clark <stephen.clark@earthlink.net> writes:
> 
> > Gentle people,
> > 
> > I am having the following problem. Also if I compile bttv into the
> > kernel I get a panic in the driver at boot.
> > 
> > Any ideas?
> 
> disable CONFIG_I2C_*_DEBUG, the debug printk() dereference pointers
> unchecked.

Here's the patch that has been reported to fix this oops.  I've added it
to my i2c bk tree.

thanks,

greg k-h

# I2C: fix oops when CONFIG_I2C_DEBUG_CORE is enabled and the bttv driver is loaded.

diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Tue Feb  3 17:00:46 2004
+++ b/drivers/i2c/i2c-core.c	Tue Feb  3 17:00:46 2004
@@ -598,7 +598,7 @@
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		up(&adap->bus_lock);
 	
-		dev_dbg(&client->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
+		dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr);
 	
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes

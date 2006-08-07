Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWHGC52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHGC52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWHGC52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:57:28 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:46518 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1750939AbWHGC51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:57:27 -0400
Date: Sun, 6 Aug 2006 20:57:23 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: dev_printk() is now GPL-only
Message-ID: <20060807025723.GK4379@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does dev_driver_string() really need to be GPL-only?  Up to this point,
proprietary modules have been entitled to call dev_printk(), but now:

#define dev_printk(level, dev, format, arg...)  \
        printk(level "%s %s: " format , dev_driver_string(dev) , (dev)->bus_id , ## arg)

with

EXPORT_SYMBOL_GPL(dev_driver_string);

means that they're not allowed to.

On a related note, one might wonder if

        return dev->driver ? dev->driver->name :
	                        (dev->bus ? dev->bus->name : "");

really qualifies for the full weight of copyright enforcement, and query
whether using it makes your driver a derived work.  Particularly since
all one is doing is asking the kernel for a nice printk prefix and know
nothing about the innards of the device model.


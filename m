Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267210AbRGKGVM>; Wed, 11 Jul 2001 02:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbRGKGVB>; Wed, 11 Jul 2001 02:21:01 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:38660 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267210AbRGKGUw>;
	Wed, 11 Jul 2001 02:20:52 -0400
Date: Tue, 10 Jul 2001 23:18:03 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linuxdrivers-foundry@lists.sourceforge.net
Subject: [PATCH] Hotplug PCI driver for 2.4.7-pre6
Message-ID: <20010710231803.B26745@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another release of the Compaq/Intel Hotplug PCI driver.
It's available at:
	http://www.kroah.com/linux/hotplug/
and is against 2.4.7-pre6, but applies with a bit of fuzz on 2.4.6.

Changes since last release:
	- forward ported to 2.4.7-pre6
	- lots better error handling on startup if things don't go quite
	  right.
	- Cleared up the printk message that everyone sees about the bus
	  number.
	- fixed the MOD_* handling (is not needed now.)
	- made debug messages a module parameter, instead of compile
	  time option.
	- removed all direct addressing of PCI mmio space.  Now uses
	  proper indirection functions, which will make other platforms
	  happy.
	- ioctl call now requires CAP_SYS_RAWIO privileges (can't shut
	  down cards as a normal user anymore.)
	- removed most of the NT like error codes.
	- no longer sit and spin in a udelay() call for huge amounts of
	  time.

There's a changelog available on the web page if you want some more
detail.


Things left to do:
	- remove pci_access_config call and replace it with native
	  kernel call.
	- remove more global symbols
	- incorporate native list types
	- look into removing some of the native PCI bus probing logic to
	  use the kernel provided functions where possible.
	- add support for other archs (ia64)

thanks,

greg k-h

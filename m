Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967257AbWKZDqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967257AbWKZDqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 22:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967284AbWKZDqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 22:46:47 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:33832 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967257AbWKZDqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 22:46:46 -0500
Date: Sat, 25 Nov 2006 19:46:54 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: zippel@linux-m68k.org, jejb <james.bottomley@steeleye.com>
Subject: Re: how to handle indirect kconfig dependencies
Message-Id: <20061125194654.2391db44.randy.dunlap@oracle.com>
In-Reply-To: <20061116200741.fb607fe4.randy.dunlap@oracle.com>
References: <20061116200741.fb607fe4.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 20:07:41 -0800 Randy Dunlap wrote:

> Hi,
> 
> I have a (randconfig) build of 2.6.19-rc5-mm2 with:
> 
> CONFIG_DEBUG_READAHEAD=y
> 
> which selects DEBUG_FS, so DEBUG_FS=y, but DEBUG_FS depends on
> SYSFS, and SYSFS is not set in the randconfig.
> 
> This randconfig causes this build error:
> 
> fs/built-in.o: In function `debugfs_init':
> inode.c:(.init.text+0xdb2): undefined reference to `kernel_subsys'
> 
> so the question is:
> (How) can kconfig follow the dependency chain and either
> - prevent this odd config combination or
> - see that 'select DEBUG_FS' implies 'select SYSFS' and then enable SYSFS
> ?
> 
> I don't believe that the right answer is to add
> 	depends on SYSFS
> to DEBUG_READAHEAD.
> 
> 
> .config is at http://oss.oracle.com/~rdunlap/configs/config-readahead-debugfs

Roman,
Here's another one for your consideration.

USB_APPLEDISPLAY selects BACKLIGHT_LCD_SUPPORT & BACKLIGHT_CLASS_DEVICE;
drivers/backlight/Kconfig depends on SYSFS (but SYSFS=n)

http://oss.oracle.com/~rdunlap/configs/config-backlight-appledisplay

---
~Randy

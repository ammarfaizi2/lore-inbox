Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVAGUYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVAGUYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAGUWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:22:13 -0500
Received: from web54502.mail.yahoo.com ([68.142.225.172]:61803 "HELO
	web54502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261597AbVAGURg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:17:36 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=0ckavLzt3VUkBvZgy7jJoTkfoAspFvdlu+4mpJO5XdnJ+uDLNNHyjbreRitsHfgn0EH0uS3tqkBeKUusSWWFQpGx3sHhcFALIL6/zjCsuCAHH21eTMH5voKErIv9nOI8AVGlXdHNFHoKhjPEBSl9rNk5xWbneaXc11Kep0nzmJ8=  ;
Message-ID: <20050107201730.40634.qmail@web54502.mail.yahoo.com>
Date: Fri, 7 Jan 2005 12:17:30 -0800 (PST)
From: Shakthi Kannan <shakstux@yahoo.com>
Subject: Re: mount PCI-express RAM memory as block device
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501071342290.21110@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your replies Dick Johnson and Arnd
Bergmann.

--- linux-os <linux-os@chaos.analogic.com> wrote:
> From your explanation, it looks like the
> BASE_ADDRESS is not
> the device's on-board memory, but instead, its
> control
> registers, i.e., a simple implementation bug.

The BASE_ADDRESS is a physical address (0xfe8f0000)
that points to the RAM memory on the PCI card, which I
tried to remap so that the kernel can address it using
memcpy.

Initially, I wrote a pci driver (character driver
interface) to test memory read/write operations to
this physical address (after ioremap) using
readl/writel. This worked fine.

--- linux-os <linux-os@chaos.analogic.com> wrote:
> When you ioremap() in the kernel, you get a cookie 
> that you can use (in the kernel) to copy data to and
> from the device.
> This doesn't allow a user to copy data directly. 
> Instead, in your read() and write() routines, you
use > the appropriate copy_to/from_user() routines. 

This being a block driver I only define
block_device_operations. How would I declare and use
the file_operations read(), write() routines?

> If the device is not a block device, then you will 
> have to mount it through the loop device. If it is a
> block device, you can mount it directly after 
> initialization.

Which is where it fails. 

--- Arnd Bergmann <arnd@arndb.de> wrote:
> If you are completely stuck on 2.4.22, it might be
> easier to
> use the old slram driver instead of phram, but
> generally you
> should try to hack on a modern kernel level like
> 2.6.10 anyway.

I shall test it with the 2.6.10 kernel.

Thanks again,

K Shakthi


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 

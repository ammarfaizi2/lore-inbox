Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWIIPCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWIIPCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWIIPCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:02:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7839 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932250AbWIIPCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:02:45 -0400
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87fyf5jnkj.fsf@willow.rfc1149.net>
References: <87fyf5jnkj.fsf@willow.rfc1149.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:25:25 +0100
Message-Id: <1157815525.6877.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-06 am 12:29 +0200, ysgrifennodd Samuel Tardieu:
> +static unsigned char
> +w83697hg_get_reg(unsigned char reg)
> +{
> +	outb_p(reg, W83697HG_EFIR);
> +	return inb_p(W83697HG_EFDR);
> +}

No kernel level locking anywhere in the driver. Yet you could have two
people accessing it at once.


> +wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
> +	  unsigned long arg)
> +{
> +	default:
> +		return -ENOIOCTLCMD;

Should be -ENOTTY

> +	printk(KERN_INFO PFX "Looking for W83697HG at address 0x%x\n", wdt_io);

KERN_DEBUG



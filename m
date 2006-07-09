Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbWGIUvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWGIUvx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWGIUvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:51:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161139AbWGIUvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:51:52 -0400
Date: Sun, 9 Jul 2006 13:51:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1:  /sys/class/net/ethN becoming symlink befuddled
 /sbin/ifup
Message-Id: <20060709135148.60561e69.akpm@osdl.org>
In-Reply-To: <1152469329.9254.15.camel@Homer.TheSimpsons.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<1152469329.9254.15.camel@Homer.TheSimpsons.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2006 20:22:09 +0200
Mike Galbraith <efault@gmx.de> wrote:

> Greetings,
> 
> As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...
> 
> -[pid  8191] lstat64("/sys/class/net/eth1", {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> -[pid  8191] lstat64("/sys/block/eth1", 0xafec0f9c) = -1 ENOENT (No such file or directory)
> 
> ...and wandered off into lala-land.

Well that's amusing.  Ethernet-over-scsi?

> It used to do...
> 
> +[pid  8905] lstat64("/sys/class/net/eth1", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> +[pid  8905] readlink("/sys/class/net/eth1/device", "../../../devices/pci0000:00/0000:00:1e.0/0000:02:09.0", 255) = 53
> +[pid  8905] readlink("/sys/class/net/eth1/device", "../../../devices/pci0000:00/0000:00:1e.0/0000:02:09.0", 255) = 53
> 
> ...and made working network interface.
> 

I'd be suspecting
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.

If you could do a `patch -R' of that one it'd really help, thanks.

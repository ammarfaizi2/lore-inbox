Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUHHUGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUHHUGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUHHUGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:06:15 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:48908 "EHLO
	anchor-post-37.mail.demon.net") by vger.kernel.org with ESMTP
	id S266233AbUHHUGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:06:09 -0400
Message-ID: <411687B0.1070901@superbug.demon.co.uk>
Date: Sun, 08 Aug 2004 21:06:08 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: /dev problems with boot: unable to open an initial console.
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using linux kernel 2.6.7 with udev.

I thought that with this, I would never have to create any files in /dev 
again, because hotplug etc. would do the job for me.

Just after booting the kernel image, it starts running the first process 
id 1 "init".

If /dev is empty, init fails to complete and returns the error message:
"unable to open an initial console."

Once I manually created /dev/console, and /dev/tty0, linux booted up ok, 
and it reached a login prompt.

To me, this seems like a bug in the linux kernel.

I would have expected that when using udev, I would not have had to put 
anything in /dev

Here is what gets mounted at boot time from /etc/mtab

/dev/sdb5 on / type reiserfs (rw,noatime)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev type ramfs (rw)
none on /dev/pts type devpts (rw)
/dev/sdb6 on /u type reiserfs (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/bus/usb type usbfs (rw)

Maybe the problem is that not everything is getting mounted before 
"init" is started, or maybe hotplug is not given enough time to act 
before "init" is started.

I can see this causing problems if one tries to boot from a hotplugable 
device like usb.

Any comments?

James

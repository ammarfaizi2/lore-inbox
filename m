Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266997AbUBMN3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266998AbUBMN3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:29:54 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:64954 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S266997AbUBMN3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:29:52 -0500
To: "Jim Gifford" <maillist@jg555.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initrd Question
In-Reply-To: <1oC26-8eW-9@gated-at.bofh.it>
References: <1oC26-8eW-9@gated-at.bofh.it>
Date: Fri, 13 Feb 2004 14:30:29 +0100
Message-Id: <E1ArdOn-00005C-4T@localhost>
From: der.eremit@email.de
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> echo "Initial RAMDISK Loading Starting..."

Did you get this message when trying your initrd? If not, you probably
forgot to pass the kernel a root=/dev/ram0 boot option.

> insmod /lib/megaraid.ko
> insmod /lib/aic7xxx.ko
> insmod /lib/uhci-hcd.ko
> echo "Mounting proc..."
> mount -n -t proc none /proc
> echo 0x0100 > /proc/sys/kernel/real-root-dev

This makes no sense as you're using pivot_root. The old method requires
terminating the initrd script, then the kernel attempts to mount
real-root-dev. That never happens as your script doesn't exit, but execs
init instead.

> echo "Mounting real root dev..."
> mount -n -o ro /dev/sda2 /new_root

This doesn't even match with the 0x0100 above, now does it?

> echo "Running pivot_root..."
> pivot_root /new_root /new_root/initrd

You should cd into /new_root before running pivot_root, or does the
pivot_root from busybox somehow do this for you?

> if [ -c initrd/dev/.devfsd ]
>   then
>           echo "Mounting devfs..."
>           mount -n -t devfs none dev
> fi

Should you check for /dev/.devfsd on the real root here? I thought .devfsd
is created by the devfsd process, so wouldn't be on the initrd /dev?

-- 
Ciao,
Pascal

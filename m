Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVCVBTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVCVBTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVCVBQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:16:51 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:38997 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262225AbVCVBNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:13:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FkT0PwED+r9Qz/XAl4o0DAnvkFmZurraK88yqOGAcKIoOmhFy3tYEIQwn20WwoZSMWHHmxOOMoNIfhQjZ/hDq/h5IfmGLpLI3S9kssbu1pdpN0lGuebOjd9Cv2pdYyO90WYhBItd+V4upwR9U2Qq1IiY2Dygo+tuTM9NvxBbrCk=
Message-ID: <9e473391050321171374ec7b50@mail.gmail.com>
Date: Mon, 21 Mar 2005 20:13:52 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: current linus bk, error mounting root
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20050322004935.GB10270@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <9e47339105030909031486744f@mail.gmail.com>
	 <20050321154131.30616ed0.akpm@osdl.org>
	 <9e473391050321155735fc506d@mail.gmail.com>
	 <20050321161925.76c37a7f.akpm@osdl.org>
	 <20050322003807.GA10180@kroah.com>
	 <20050321164318.04a5dc82.akpm@osdl.org>
	 <20050322004935.GB10270@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 16:49:36 -0800, Greg KH <greg@kroah.com> wrote:
> The distros that use udev have already all worked out these issues with
> their init scripts and such, so it shouldn't be an issue anymore.
> 
> Jon, what distro are you using?

The mkinitrd script is broken for up2date Fedore Core 3. udev is not
building the sata device in time. The script does: '/sbin/udevstart',
'raidautorun /dev/md0'. I just checked and the sata volumes are
missing out of my array.

This script used to work and changes after 2.6.11 have thrown off the
timing so that it doesn't work anymore.

echo "Loading libata.ko module"
insmod /lib/libata.ko
echo "Loading ata_piix.ko module"
insmod /lib/ata_piix.ko
echo "Loading raid1.ko module"
insmod /lib/raid1.ko
/sbin/udevstart
raidautorun /dev/md0
echo Creating root device
mkrootdev /dev/root
umount /sys
echo Mounting root filesystem
mount -o defaults --ro -v -t ext3 /dev/root /sysroot
mount -t tmpfs --bind /dev /sysroot/dev
echo Switching to new root
switchroot /sysroot
umount /initrd/dev

-- 
Jon Smirl
jonsmirl@gmail.com

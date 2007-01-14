Return-Path: <linux-kernel-owner+w=401wt.eu-S1751197AbXANIqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXANIqF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 03:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXANIqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 03:46:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:60240 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbXANIqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 03:46:03 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BEgFPN/aHql3+8nA0yuMqjD4dEGq3lHSNpacN09umqiyjQc7smi2RVfJ8ptIXXKLUxR4sHI2B28/OoOLySweXf0BbDeuaOPjgptA4Xc1Ydzx26OTSmsrLs01VgiCcj9LNxJVqzr6VyJ2vgkpe6/3YvKziImYETMjx+F1nC+AOgo=
Message-ID: <3ae72650701140046p5c3280a1ofd7b59cece11b773@mail.gmail.com>
Date: Sun, 14 Jan 2007 09:46:02 +0100
From: "Kay Sievers" <kay.sievers@vrfy.org>
To: "Greg KH" <greg@kroah.com>
Subject: Re: No more "device" symlinks for classes
Cc: "Andrey Borzenkov" <arvidjaar@mail.ru>,
       "Pierre Ossman" <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <20070114073937.GA10585@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45A97089.5090004@drzeus.cx>
	 <20070114061104.1C53839AF7F@muan.mtu.ru>
	 <20070114073937.GA10585@kroah.com>
X-Google-Sender-Auth: dde9f4eec34cbd52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/07, Greg KH <greg@kroah.com> wrote:
> On Sun, Jan 14, 2007 at 09:10:59AM +0300, Andrey Borzenkov wrote:
> > Pierre Ossman wrote:
> >
> > > Hi guys,
> > >
> > > I just wanted to know the rationale behind
> > > 99ef3ef8d5f2f5b5312627127ad63df27c0d0d05 (no more "device" symlink in
> > > class devices). I thought that was a rather convenient way of finding
> > > which physical device the class device was coupled to.
> > >
> >
> > Actually I wonder why those links still present even when I told system not
> > to create them?
> >
> > {pts/1}% grep DEPRE /boot/config
> > # CONFIG_SYSFS_DEPRECATED is not set
> > # CONFIG_PM_SYSFS_DEPRECATED is not set
> > {pts/1}% find /sys/class -name device
> > /sys/class/pcmcia_socket/pcmcia_socket2/device
> > /sys/class/pcmcia_socket/pcmcia_socket1/device
> > /sys/class/pcmcia_socket/pcmcia_socket0/device
> > /sys/class/usb_device/usbdev1.1/device
> > /sys/class/usb_host/usb_host1/device
> > /sys/class/scsi_disk/0:0:0:0/device
> > /sys/class/scsi_device/1:0:0:0/device
> > /sys/class/scsi_device/0:0:0:0/device
> > /sys/class/scsi_host/host1/device
> > /sys/class/scsi_host/host0/device
> > /sys/class/net/eth0/device
> > /sys/class/net/eth1/device
> > /sys/class/input/input1/ts0/device
> > /sys/class/input/input1/mouse0/device
> > /sys/class/input/input1/event1/device
> > /sys/class/input/input1/device
> > /sys/class/input/input0/event0/device
> > /sys/class/input/input0/device
> > {pts/1}% uname -a
> > Linux cooker 2.6.20-rc5-1avb #10 Sat Jan 13 14:05:34 MSK 2007 i686 Pentium
> > III (Coppermine) GNU/Linux
>
> Because I haven't finished converting all of the different usages of
> struct class_device to struct device just yet.  When that happens, those
> links go away, as the /sys/class/foo_class/foo is a symlink itself into
> the /sys/devices/ tree.

Right, you only told not to create the links for already converted
subsystems to create the class-devices in /sys/devices. You can never
supress the links for subsystems which still create device-directories
in /sys/class, because you would lose the parent information then and
udev and HAL couldn't work anymore.

Kay
Kay

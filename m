Return-Path: <linux-kernel-owner+w=401wt.eu-S1751153AbXANHxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXANHxG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXANHxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:53:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:40009 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbXANHxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:53:05 -0500
Date: Sat, 13 Jan 2007 23:39:37 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: No more "device" symlinks for classes
Message-ID: <20070114073937.GA10585@kroah.com>
References: <45A97089.5090004@drzeus.cx> <20070114061104.1C53839AF7F@muan.mtu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114061104.1C53839AF7F@muan.mtu.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 09:10:59AM +0300, Andrey Borzenkov wrote:
> Pierre Ossman wrote:
> 
> > Hi guys,
> > 
> > I just wanted to know the rationale behind
> > 99ef3ef8d5f2f5b5312627127ad63df27c0d0d05 (no more "device" symlink in
> > class devices). I thought that was a rather convenient way of finding
> > which physical device the class device was coupled to.
> > 
> 
> Actually I wonder why those links still present even when I told system not
> to create them?
> 
> {pts/1}% grep DEPRE /boot/config
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_PM_SYSFS_DEPRECATED is not set
> {pts/1}% find /sys/class -name device
> /sys/class/pcmcia_socket/pcmcia_socket2/device
> /sys/class/pcmcia_socket/pcmcia_socket1/device
> /sys/class/pcmcia_socket/pcmcia_socket0/device
> /sys/class/usb_device/usbdev1.1/device
> /sys/class/usb_host/usb_host1/device
> /sys/class/scsi_disk/0:0:0:0/device
> /sys/class/scsi_device/1:0:0:0/device
> /sys/class/scsi_device/0:0:0:0/device
> /sys/class/scsi_host/host1/device
> /sys/class/scsi_host/host0/device
> /sys/class/net/eth0/device
> /sys/class/net/eth1/device
> /sys/class/input/input1/ts0/device
> /sys/class/input/input1/mouse0/device
> /sys/class/input/input1/event1/device
> /sys/class/input/input1/device
> /sys/class/input/input0/event0/device
> /sys/class/input/input0/device
> {pts/1}% uname -a
> Linux cooker 2.6.20-rc5-1avb #10 Sat Jan 13 14:05:34 MSK 2007 i686 Pentium
> III (Coppermine) GNU/Linux

Because I haven't finished converting all of the different usages of
struct class_device to struct device just yet.  When that happens, those
links go away, as the /sys/class/foo_class/foo is a symlink itself into
the /sys/devices/ tree.

If you look in the -mm tree there is a patch for the network devices,
and I have patches in my tree (but not -mm) for pcmcia, usb_host,
usb_device, and input.  These patches still need a bit of work before
sending them on to their relative maintainers for acceptance.

Hope this helps explain things,

greg k-h

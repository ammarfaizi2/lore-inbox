Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbULIQoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbULIQoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbULIQoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:44:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:53682 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261559AbULIQnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:43:08 -0500
Date: Thu, 9 Dec 2004 08:42:50 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Message-ID: <20041209164250.GA8847@kroah.com>
References: <87acsrqval.fsf@coraid.com> <20041206215456.GB10499@kroah.com> <87zn0n5vyd.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zn0n5vyd.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 10:32:10AM -0500, Ed L Cashin wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Mon, Dec 06, 2004 at 10:51:46AM -0500, Ed L Cashin wrote:
> >> +CREATING DEVICE NODES
> >> +
> >> +  Two scripts are in scripts/aoe for assisting in creating device
> >> +  nodes for using the aoe driver.  Usage is as follows.
> >> +
> >> +    rm -rf /dev/etherd
> >> +    sh scripts/mkdevs /dev/etherd
> >
> > If you use the /sys/class interface properly, and udev, you don't need
> > this script at all.  Care to add sysfs support to the driver so that
> > people don't have to rely on this?
> 
> Right now genhd.c seems to be giving us some automatic sysfs support
> for the block devices:
> 
> root@makki root# ls /sys/block/
> etherd!e15.3  etherd!e5.2  etherd!e5.6  fd0  md0    ram11  ram15  ram5  ram9
> etherd!e3.0   etherd!e5.3  etherd!e5.7  hda  ram0   ram12  ram2   ram6
> etherd!e5.0   etherd!e5.4  etherd!e5.8  hdb  ram1   ram13  ram3   ram7
> etherd!e5.1   etherd!e5.5  etherd!e5.9  hdc  ram10  ram14  ram4   ram8

Yes, that is automatically handled for you by the block layer.

> Will using class_simple_device_add register our char devices so that
> udev can create the device nodes dynamically?  I'm looking at the
> example in netlink_dev.c.

You need the class_simple* stuff for your char driver.  This is because
the char layer does not automatically handle this for you, and is the
responsibility of every individual driver to implement (yeah, it sucks
at times, sorry...)

Hope this helps,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUJASI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUJASI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUJASFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:05:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:49849 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265800AbUJASBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:01:23 -0400
Date: Fri, 1 Oct 2004 10:53:12 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev remove event not sent untill the device is closed
Message-ID: <20041001175312.GB14015@kroah.com>
References: <200409272252.36016.thomas@stewarts.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409272252.36016.thomas@stewarts.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:52:36PM +0100, Thomas Stewart wrote:
> Hi,
> 
> I'm running 2.6.8.1 with udev-031. I have a usb2serial converter which has a 
> udev rule to give it a persistent name in my dev tree. I want to run a script 
> when the converter is attached, and another when the converter is removed.
> 
> I tried both the /etc/hotplug.d and /etc/dev.d methods to do this (I like the 
> dev.d method better as I can use my persistent device name). Unfortunately I 
> ran into problems.
> 
> I'm catching the tty event as it sets $DEVPATH to something useful 
> (e.g. /devices/sys/class/tty/ttyUSB0). And then running a different script 
> depending on $ACTION.
> 
> I made a short script to do this, and put it in /etc/dev.d/default/ttyUSB.dev:
> #!/bin/sh
> test "$1" != "tty" && exit
> test "$ACTION" == "add"    && /usr/local/bin/on
> test "$ACTION" == "remove" && /usr/local/bin/off
> 
> (I removed the various error checking that actually makes sure the tty event 
> in question was actually the serial converter, and not some other device.)
> 
> This works fine, I can add and remove the converter to my hearts content and 
> both scripts run accordingly.
> 
> However, if I attach the device, open it with say a "cat /dev/ttyUSB0" and 
> then remove the device. No tty events get sent untill I kill the cat.

This is because the tty device remains until the last userspace process
releases the device.  You might want to trigger your script off of the
removal of the USB device instead.

Hope this helps,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTJ3G2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 01:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTJ3G2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 01:28:08 -0500
Received: from mail.mediaways.net ([193.189.224.113]:44005 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262198AbTJ3G2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 01:28:04 -0500
Subject: Re: usb devices get redetected all the time in 2.6.0-test{7,9}
From: Soeren Sonnenburg <kernel@nn7.de>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031029200112.GB4434@kroah.com>
References: <1067411725.1577.19.camel@localhost>
	 <20031029200112.GB4434@kroah.com>
Content-Type: text/plain
Message-Id: <1067495225.1529.14.camel@localhost>
Mime-Version: 1.0
Date: Thu, 30 Oct 2003 07:27:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-29 at 21:01, Greg KH wrote:
> On Wed, Oct 29, 2003 at 08:15:26AM +0100, Soeren Sonnenburg wrote:
> > Hi.
> > 
> > When I attach a camera to a 2.4. based machine hotplug starts up some
> > script to download images of that camera and fine thats it.
> > 
> > In 2.6.0-testX I see kernel messages like:
> > 
> > hub 2-0:1.0: new USB device on port 1, assigned address 2
> > bus usb: add device 2-1
> > bound device '2-1' to driver 'usb'
> > bus usb: add device 2-1:1.0
> > bus usb: remove device 2-1:1.0
> > bus usb: add device 2-1:1.0
> > bus usb: remove device 2-1:1.0
> > bus usb: add device 2-1:1.0
> > bus usb: remove device 2-1:1.0
> > bus usb: add device 2-1:1.0
> > [...]
> > 
> > and several of these hotplug scripts get started... Is this a wanted
> > behaviour and something has to be fixed in userspace or is it a kernel
> > bug ?
> 
> Does this settle down after a bit, or does the add/remove stuff keep
> going on for a while?

I realized that when I disable the hotplug script the camera is detected
only once (as it should).

The script fetches the directory listing off the camera... thus is
probably opening+closing the device once. So I wonder whether this could
somehow trigger an usb disconnect on close() making the usb driver to
redetect the device ?!

> Can you enable CONFIG_USB_DEBUG and see if you get any more information
> in the kernel debug log as to why this is happening?

If still needed I will do.

Soeren


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbTLWBXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 20:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTLWBXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 20:23:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:62903 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264910AbTLWBXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 20:23:15 -0500
Date: Mon, 22 Dec 2003 17:23:10 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 010 release
Message-ID: <20031223012310.GJ5427@kroah.com>
References: <20031223005809.GB5341@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223005809.GB5341@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:58:09PM -0800, Greg KH wrote:
> I've released the 010 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-010.tar.gz

Oh, forgot to mention that udev runs a _lot_ slower now, taking at least
1 second for every device addition.  This makes the initscript or the
test scripts take a long time.

This was done to try to fix the race condition where udev beats the
kernel before it has created all of the sysfs links and files.  I need
some libsysfs changes before this can be done properly, without the big
speed hit (the libsysfs people are working on it.)

If anyone's interested in it, take a look at the FIXMEs in namedev.c.
I tried messing around with just a simple stat() call, but still
couldn't reliably get stuff to work for partitions on usb-storage
devices (which are slow to enumerate.)  Any help here would be
apprecated.

thanks,

greg k-h

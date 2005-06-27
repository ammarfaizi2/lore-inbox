Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVF0Xd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVF0Xd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVF0XcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:32:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:61858 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262140AbVF0X36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:29:58 -0400
Date: Mon, 27 Jun 2005 16:29:48 -0700
From: Greg KH <greg@kroah.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question on "embedded" classes
Message-ID: <20050627232948.GA24904@kroah.com>
References: <42C0897A.8010705@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C0897A.8010705@adaptec.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 07:19:22PM -0400, Luben Tuikov wrote:
> Hi,
> 
> I was wondering what the reason was for allowing
> class and classdev to only be at level 3 and level
> 4 respectively of sysfs (/ is level 0)?
> 
> 1) Some devices would not have any relevance
> ouside the scope of the "parent" device.
> 2) "Hooking" them all at /sys/class/ level
> would create quite a lot of symlinks (and with
> cryptic names in order to reference the proper
> "parent" device in the same directory).
> 
> E.g. Some devices, like SAS host adapters, have "devices
> inside devices" and I'd like to represent this in
> sysfs.
> 
> /sys/class/sas          (a class)
> /sys/class/sas/ha0/     (a classdev)
> /sys/class/sas/ha1/     (a classdev)
> 
> /sys/class/sas/ha0/device -> symlink to PCI device
> /sys/class/sas/ha0/device_name    (text attribute)
> 
> /sys/class/sas/ha0/phys/     (a class)
> /sys/class/sas/ha0/phys/0/   (a classdev)

Nope, this is not allowed.

Classes are not allowed to have children classes.
class devices can not have children, be they class_device or a class.

That is the reason you are getting oopses :)

thanks,

greg k-h

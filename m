Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUBDXoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBDXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:41:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:1719 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264278AbUBDXeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:34:07 -0500
Date: Wed, 4 Feb 2004 15:34:00 -0800
From: Greg KH <greg@kroah.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: odain2@mindspring.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: proper place for devfs_register_chrdev with pci_module_init
Message-ID: <20040204233400.GA5274@kroah.com>
References: <18852317.1075926209540.JavaMail.root@wamui01.slb.atl.earthlink.net> <Pine.LNX.4.53.0402041616230.3277@chaos> <200402041648.29096.odain2@mindspring.com> <Pine.LNX.4.53.0402041723340.3515@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402041723340.3515@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 05:29:31PM -0500, Richard B. Johnson wrote:
> 
> I would call pci_find_class() and continue until a NULL is returned
> or my vendor and device are returned in the structure.

NOOOOO!!!!!

Do NOT do this.  Use pci_register_driver() instead.  Using pci_find_*()
is just broken and wrong for 99% of all pci drivers.

If you do this you do not hook up into sysfs properly.  You do not get
modules automatically loaded for your driver.  You do not get notified
if the device is removed from the system.  And, most importantly, you do
not get exclusive access to the pci device.

As for the original poster, look at one of the many existing char
drivers for examples of what you need to do to register a char driver
properly.  It really has nothing to do with the pci interface at all
(with the exception of when to register it...)

thanks,

greg k-h

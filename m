Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUBEMk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUBEMk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:40:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52352 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265213AbUBEMky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:40:54 -0500
Date: Thu, 5 Feb 2004 07:42:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Greg KH <greg@kroah.com>
cc: odain2@mindspring.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: proper place for devfs_register_chrdev with pci_module_init
In-Reply-To: <20040204233400.GA5274@kroah.com>
Message-ID: <Pine.LNX.4.53.0402050739450.5456@chaos>
References: <18852317.1075926209540.JavaMail.root@wamui01.slb.atl.earthlink.net>
 <Pine.LNX.4.53.0402041616230.3277@chaos> <200402041648.29096.odain2@mindspring.com>
 <Pine.LNX.4.53.0402041723340.3515@chaos> <20040204233400.GA5274@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Greg KH wrote:

> On Wed, Feb 04, 2004 at 05:29:31PM -0500, Richard B. Johnson wrote:
> >
> > I would call pci_find_class() and continue until a NULL is returned
> > or my vendor and device are returned in the structure.
>
> NOOOOO!!!!!
>
> Do NOT do this.  Use pci_register_driver() instead.  Using pci_find_*()
> is just broken and wrong for 99% of all pci drivers.
>
> If you do this you do not hook up into sysfs properly.  You do not get
> modules automatically loaded for your driver.  You do not get notified
> if the device is removed from the system.  And, most importantly, you do
> not get exclusive access to the pci device.
>
> As for the original poster, look at one of the many existing char
> drivers for examples of what you need to do to register a char driver
> properly.  It really has nothing to do with the pci interface at all
> (with the exception of when to register it...)
>
> thanks,
>
> greg k-h


WTF? How do you find out if your board in actually in the system?
You CANNOT load all possible modules, hoping that somebody will
hot-plug in one of the devices a year from now.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264823AbUDWO1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264823AbUDWO1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264825AbUDWO1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:27:25 -0400
Received: from linux-bt.org ([217.160.111.169]:16513 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264823AbUDWO1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:27:15 -0400
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
In-Reply-To: <200404230802.42293.dtor_core@ameritech.net>
References: <200404230142.46792.dtor_core@ameritech.net>
	 <1082723147.1843.14.camel@merlin>
	 <200404230802.42293.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1082730412.23959.118.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 16:26:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > I haven't tested it yet, but the same problem should apply to the
> > bt3c_cs driver for the 3Com Bluetooth card. Are there any patches
> > available that integrates the PCMCIA subsystem into the driver model, so
> > we don't have to hack around it if a firmware download is needed?
> >
> I do not know. But the problem seems to be somewhat widespread - I just got
> oops with the following trace:
> 
>  [<c0182f99>] sysfs_create_link+0x29/0x140
>  [<c01ac578>] kobject_hotplug+0x58/0x60
>  [<c0211490>] class_device_dev_link+0x30/0x40
>  [<c02117ad>] class_device_add+0xed/0x130
>  [<e185ffab>] usb_register_dev+0x12b/0x170 [usbcore]
>  [<e1b2bf2a>] hiddev_connect+0x7a/0x120 [usbhid]
> 
> I think we should not oops, just complain loudly, when we come across a
> kobject which has never beek kobject_add()ed, like in patch below.

I can't tell you anything about the hiddev problem, but for the PCMCIA
subsystem we have the problem that right now it is not integrated into
the driver model. Maybe a dummy integration for PCMCIA would be nice or
can we get a device_simple like we have class_simple?

Regards

Marcel



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbTGZUt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTGZUt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:49:57 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:57801 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S269672AbTGZUtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:49:41 -0400
Subject: Re: request_firmware() backport to 2.4 kernels
From: Marcel Holtmann <marcel@holtmann.org>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726121638.GB31145@ranty.pantax.net>
References: <20030726121638.GB31145@ranty.pantax.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 Jul 2003 23:04:27 +0200
Message-Id: <1059253473.922.18.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manuel,

>  A while back request_firmware() was added to the 2.5 kernel series to
>  support firmware needing drivers keeping the firmware images in
>  userspace. And I also backported it to the 2.4 kernel series on top of
>  procfs, but Marcelo didn't answer emails relating to it (there where
>  probably other more important matters back then).
>  
>  Since then, the 2.4 backport has been deployed and tested with
>  orinoco_usb driver variant (http://orinoco-usb.alioth.debian.org/),
>  as you can see in the download statistics in alioth, there has been
>  more than 400 downloads of the request_firmware enabled version
>  (0.2.1). And drivers on the 2.5/2.6 series are being ported to use
>  request_firmware() interface.

I've tested your patch with 2.4.22-pre8 and a modified version of my
bfusb driver. It is working fine, but I get these log entries:

	hub.c: new USB device 02:0c.0-2, assigned address 2
	firmware_class.c:call_helper: firmware: /sbin/hotplug firmware add
	remove_proc_entry: bfusb003002/loading busy, count=1
	remove_proc_entry: firmware/bfusb003002 busy, count=1
	BlueFRITZ! USB loading firmware
	de_put: deferred delete of loading
	de_put: deferred delete of bfusb003002
	BlueFRITZ! USB device ready

Is this a problem of your patch or is it a general /proc problem?

>  Would it be possible to include it in the -aa kernel tree? That would
>  make it accessible to a wider audience for testing, and make it easier
>  for developers to backport their drivers to the 2.4
>  series.

The patch don't touches any other part of the Linux kernel, so I think
it is a nice and clean extension.

 Documentation/Configure.help                          |    6 
 Documentation/firmware_class/README                   |   58 +
 Documentation/firmware_class/firmware_sample_driver.c |  121 +++
 Documentation/firmware_class/hotplug-script           |   16 
 include/linux/firmware.h                              |   20 
 lib/Config.in                                         |    4 
 lib/Makefile                                          |    3 
 lib/firmware_class.c                                  |  557 ++++++++++++++++++
 8 files changed, 784 insertions(+), 1 deletion(-)

I already ported drivers/bluetooth/bfusb.c to use the request_firmware()
interface and I will port drivers/bluetooth/bt3c_cs.c after this patch
gets merged.

Regards

Marcel



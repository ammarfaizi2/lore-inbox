Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTH3HbK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 03:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbTH3HbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 03:31:10 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:18391 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S261940AbTH3HbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 03:31:05 -0400
Subject: [PATCH 2.4.23-pre1] request_firmware() backport
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2003 09:30:45 +0200
Message-Id: <1062228651.11258.35.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I have collected the patches for the request_firmware() interface
backport for 2.4 done by Manuel Estrada Sainz. It is now in -ac for a
while and I have used it successfully in my -mh patches from 2.4.18
onwards. It works fine and seems to be clean and very stable. Karsten
Keil has tested it together with my ported bfusb.o Bluetooth driver on
the AMD64 platform.

The individual changesets have been already sent to the mailing list
some time ago. But if you want to look at them again, drop me a note and
I send them to you.

One of the andvantages is that we can kick off the bfusb.h file, which
contains the needed firmware for the BlueFRITZ! devices. And in future
more drivers will come :)

Regards

Marcel


Please do a

        bk pull http://linux-mh.bkbits.net/fw-loader-2.4

This will update the following files:

 drivers/bluetooth/bfusb.h                             |52261 ------------------
 Documentation/Configure.help                          |    6 
 Documentation/firmware_class/README                   |   58 
 Documentation/firmware_class/firmware_sample_driver.c |  121 
 Documentation/firmware_class/hotplug-script           |   16 
 drivers/bluetooth/Makefile.lib                        |    1 
 drivers/bluetooth/bfusb.c                             |   38 
 include/linux/firmware.h                              |   20 
 lib/Config.in                                         |    7 
 lib/Makefile                                          |    4 
 lib/firmware_class.c                                  |  581 
 11 files changed, 830 insertions(+), 52283 deletions(-)

through these ChangeSets:

<marcel@holtmann.org> (03/08/19 1.1078.1.5)
   [PATCH] Make request_firmware() compile cleanly
   
   This patch makes the request_firmware() compile on other platforms
   than i386. It adds the missing include <linux/init.h> and replaces
   some ssize_t with int.

<marcel@holtmann.org> (03/08/16 1.1078.1.4)
   [Bluetooth] Make use of request_firmware() for the BlueFRITZ! USB driver
   
   The BlueFRITZ! USB devices need a firmware download every time they are
   plugged in. With request_firmware() the file bfubase.frm is now loaded
   from the userspace and the included firmware is removed.

<marcel@holtmann.org> (03/08/15 1.1078.1.3)
   [PATCH] Firmware loading depends on hotplug support
   
   This patch makes the firmware loading support only selectable if the
   hotplug support is also enabled.

<marcel@holtmann.org> (03/08/11 1.1078.1.2)
   [PATCH] Make request_firmware() compile if hotplug support is disabled
   
   This patch fixes the problem, where hotplug support is disabled and an
   internal kernel driver uses request_firmware(). The driver will compile
   and load now, but it must handle the case where the firmware loading
   fails, because the kernel is build without hotplug support, by itself.

<ranty@debian.org> (03/08/11 1.1078.1.1)
   [PATCH] request_firmware() backport to 2.4 kernels
   
   A while back request_firmware() was added to the 2.5 kernel series
   to support firmware needing drivers keeping the firmware images in
   userspace. And I also backported it to the 2.4 kernel series on top
   of procfs.




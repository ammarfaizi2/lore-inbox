Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUATBN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUATBLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:11:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:45000 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264415AbUATBKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:10:35 -0500
Date: Mon, 19 Jan 2004 17:10:36 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver Core update for 2.6.1
Message-ID: <20040120011036.GA6162@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few kobject and driver core changes for 2.6.1.  The majority
of these are the "class_simple" patches that have been in the -mm tree
for quite a while now.  They add sysfs class support for a wide range of
different class devices, which is required for tools like udev to be
able to do device naming in userspace.  Andrew suggested that I send
them to you now.  All of the different driver subsystem maintainers
(when there is one) have ACKed these changes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/driver-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.

 drivers/base/Makefile       |    2 
 drivers/base/class.c        |   14 +++
 drivers/base/class_simple.c |  201 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/core.c         |    9 +
 drivers/char/lp.c           |    6 +
 drivers/char/mem.c          |    7 +
 drivers/char/misc.c         |   17 +++
 drivers/char/tty_io.c       |   91 ++-----------------
 drivers/input/evdev.c       |    4 
 drivers/input/input.c       |    8 -
 drivers/input/joydev.c      |    4 
 drivers/input/mousedev.c    |    8 +
 drivers/input/tsdev.c       |    4 
 include/linux/device.h      |   10 ++
 include/linux/input.h       |    3 
 include/linux/kobject.h     |    1 
 include/linux/miscdevice.h  |    3 
 include/sound/core.h        |    1 
 lib/kobject.c               |   51 ++++-------
 sound/core/sound.c          |   34 ++++---
 sound/oss/soundcard.c       |   13 ++
 sound/pci/intel8x0.c        |    1 
 sound/sound_core.c          |   10 ++
 23 files changed, 368 insertions(+), 134 deletions(-)
-----


Dmitry Torokhov:
  o kobject: make kobject hotplug function public

Greg Kroah-Hartman:
  o Kobject: prevent oops in kset_find_obj() if kobject_name() is NULL
  o ALSA: add sysfs class support for ALSA sound devices
  o OSS: add sysfs class support for OSS sound devices
  o MISC: add sysfs class support for misc devices
  o MEM: add sysfs class support for mem devices
  o LP: add sysfs class support for lp devices
  o Input: add sysfs class support for input devices
  o TTY: clean up sysfs class support for tty devices
  o Driver Core: add class_simple support

Hollis Blanchard:
  o Driver Core: add device_find() function


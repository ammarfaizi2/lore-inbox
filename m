Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUJUHMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUJUHMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUJUHKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:10:23 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:11912 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269113AbUJUG7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:59:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Sonypi driver model & PM changes
Date: Thu, 21 Oct 2004 01:54:58 -0500
User-Agent: KMail/1.6.2
Cc: stelian@popies.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210154.58301.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been looking at the sysdevs in present in the kernel and noticed that
sonypi was registering itself as a system device. Surely it is possible to
suspend it with interrupyts enabled, so it better be converted to a platform
device. I course of convert I also did some additional changes:

01-sonypi-whitespace-fixes.patch
	- get rid of extra whitespace and convert to the kernel cosing style:
	  ... However, there is one special case, namely functions: they have
	  the opening brace at the beginning of the next line...

02-sonypi-module_param.patch
	- convert sonypi from using MODULE_PARM and __setup to module_param.
	  The parameters are:
		sonypi.camera
		sonypi.compat
		sonypi.fnkeyinit
		sonypi.mask=		- exported through sysfs, writeable
		sonypi.minor=
		sonypi.useinput
		sonypi.verbose		- exported through sysfs, writeable

03-sonypi-pm-changes.patch
	- convert sonypi sysdev to platform device, drop old-style PM code
	  since APM does call device_suspend anyway so the new style handlers
          will be called.

04-sonypi-misc-changes.patch
	- switch sonypi_misc_read to use wake_event_interruptible instead of
	  a homemade copy, fix small race there, make sure that the device
	  is fully initialized before turning the interrupts on.	

05-sonypi-pci_get_device.patch
	- convert from pci_find_device which is obsolete to pci_get_device.

Warning: I do not have the hardware som while the code is compiles and I am
pretty sure it is correct it has not been tested.

Should apply to 2.6.9

-- 
Dmitry

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVBKHFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVBKHFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVBKHFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:05:42 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:38494 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262204AbVBKHFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 0/10] Convert gameport to driver model/sysfs
Date: Fri, 11 Feb 2005 01:58:47 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110158.47872.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches adds a new "gameport" bus to the driver model.
It is implemented very similarly to "serio" bus and also allows
individual drivers to be manually bound/disconnected from a port
by manipulating port's "drvctl" attribute.

01-gameport-renames1.patch
- rename gameport->driver to gameport->port_data in preparation
  to sysfs integration to avoid confusion with real drivers.

02-gameport-renames2.patch
- more renames in gameport in preparations to sysfs integration,
  gameport_dev renamed to gameport_driver, gameport_[un]register_device
  renamed to gameport_[un]register_driver

03-gameport-connect-mandatory.patch
- make connect and disconnect mandatory as these call gameport_open
  and gameport_close which actually bind driver and port together.

04-gameport-dynalloc-prepare.patch
- sysfs/kobjects requires objects be allocated synamically. Prepare
  to dynamic gameport allocation, create gameport_allocate_port and
  gameport_free_port; dynamically allocated ports are freed by core
  upon release. Also add gameport_set_name and gameport_set_phys
  to ease transition.

05-gameport-dynalloc-input.patch
- convert drivers in input/gameport to dynamic gameport allocation.

06-gameport-dynalloc-sound-oss.patch
- convert drivers in sound/oss to dynamic gameport allocation.

07-gameport-dynalloc-sound-alsa.patch
- convert drivers in sound/pci to dynamic gameport allocation.

08-gameport-drivers-sysfs.patch
- add "gameport" bus and have joystick gameport drivers register
  themselves on this bus.

09-gameport-devices-sysfs.patch
- complete gameport sysfs integration. Gameports are registered on
  the "gameport" bus.
 
10-gameport-drvdata.patch
- Get rid of gameport->private, use driver-specific data in device
  structure, access through gameport_get/set_drvdata helpers.

The changes can also be pulled from my tree (which has Vojtech's
input tree as a parent):

	bk pull bk://dtor.bkbits.net/input 

I am CC-ing ALSA list as the changes touch quite a few sound drivers.

Comments/testing is appreciated.

-- 
Dmitry

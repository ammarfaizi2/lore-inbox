Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWJBESy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWJBESy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 00:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWJBESy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 00:18:54 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:347 "EHLO
	asav11.insightbb.com") by vger.kernel.org with ESMTP
	id S932608AbWJBESx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 00:18:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAO4uIEWBToozLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input patches for 2.6.18
Date: Mon, 2 Oct 2006 00:18:50 -0400
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610020018.50731.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for input subsystem. The tree contains a handful of
new drivers (3 touchscreens and stowaway keyboard) and rework of force
feedback device support by Anssi Hannula plus number of other cleanups
and fixes.

Changelog:
----------

Adrian Bunk:
      Input: hid - #if 0 the no longer used hid_find_field_by_usage()

Anssi Hannula:
      Input: move fixp-arith.h to drivers/input
      Input: implement new force feedback interface
      Input: unified force feedback support for memoryless devices
      Input: iforce - switch to the new FF interface
      Input: add force feedback driver for PID devices
      Input: use new FF interface in the HID force feedback drivers
      Input: uinput - switch to the new FF interface
      Input: drop remnants of the old force-feedback interface
      Input: add force feedback driver for PSX-style Zeroplus devices
      Input: update the force feedback documentation

Ashutosh Naik:
      Input: wistron - add support for Acer TravelMate 2424NWXCi

Cjacker Huang:
      Input: i8042 - add Amoi to the MUX blacklist

Dmitry Torokhov:
      Input: rename input.ko into input-core.ko
      Input: elo - handle input_register_device() failures
      Input: send key up events at disconnect
      Input: i8042 - get rid of polling timer
      Input: i8042 - disable MUX mode on Toshiba Equium A110
      Input: atkbd - support Microsoft Natural Elite Pro keyboards
      Input: libps2 - rearrange exports
      Input: constify input core
      Input: fix input module refcounting
      Input: remove cruft that was needed for transition to sysfs
      Input: make input_register_handler() return error codes

Helge Deller:
      Input: logips2pp - add sugnature 56 (Cordless MouseMan Wheel), cleanup
      Input: constify psmouse driver

Lennart Poettering:
      Input: add KEY_BLUETOOTH and KEY_WLAN definitions

Marek Vasut:
      Input: add driver for stowaway serial keyboards

Michael Hanselmann:
      Input: add new BUS_VIRTUAL bus type

Reiner Herrmann:
      Input: wistron - fix setting up special buttons

Rick Koch:
      Input: add driver for Penmount serial touchscreens
      Input: add driver for Touchright serial touchscreens
      Input: add driver for Touchwin serial touchscreens

Shaun Jackman:
      Input: elo - fix checksum calculation
      Input: elo - add support for non-pressure-sensitive touchscreens

Diffstat:
 b/Documentation/input/ff.txt                     |  106 -
 b/drivers/char/keyboard.c                        |    5 
 b/drivers/input/Kconfig                          |   14 
 b/drivers/input/Makefile                         |    2 
 b/drivers/input/evbug.c                          |    3 
 b/drivers/input/evdev.c                          |    3 
 b/drivers/input/ff-core.c                        |  367 ++++++
 b/drivers/input/ff-memless.c                     |  515 ++++++++
 b/drivers/input/fixp-arith.h                     |   87 +
 b/drivers/input/input.c                          |   12 
 b/drivers/input/joydev.c                         |    3 
 b/drivers/input/joystick/iforce/iforce-ff.c      |  118 --
 b/drivers/input/joystick/iforce/iforce-main.c    |  226 +--
 b/drivers/input/joystick/iforce/iforce-packets.c |   15 
 b/drivers/input/joystick/iforce/iforce.h         |   26 
 b/drivers/input/keyboard/Kconfig                 |   11 
 b/drivers/input/keyboard/Makefile                |    1 
 b/drivers/input/keyboard/atkbd.c                 |    4 
 b/drivers/input/keyboard/stowaway.c              |  187 +++
 b/drivers/input/misc/uinput.c                    |   67 -
 b/drivers/input/misc/wistron_btns.c              |   11 
 b/drivers/input/mouse/alps.c                     |    8 
 b/drivers/input/mouse/alps.h                     |    2 
 b/drivers/input/mouse/lifebook.c                 |    8 
 b/drivers/input/mouse/logips2pp.c                |   23 
 b/drivers/input/mouse/psmouse-base.c             |   42 
 b/drivers/input/mouse/sermouse.c                 |    2 
 b/drivers/input/mouse/synaptics.c                |   10 
 b/drivers/input/mousedev.c                       |   21 
 b/drivers/input/power.c                          |    3 
 b/drivers/input/serio/i8042-x86ia64io.h          |    7 
 b/drivers/input/serio/i8042.c                    |  741 ++++++------
 b/drivers/input/serio/i8042.h                    |    9 
 b/drivers/input/serio/libps2.c                   |   20 
 b/drivers/input/touchscreen/Kconfig              |   12 
 b/drivers/input/touchscreen/Makefile             |    1 
 b/drivers/input/touchscreen/elo.c                |  124 +-
 b/drivers/input/touchscreen/penmount.c           |  185 +++
 b/drivers/input/touchscreen/touchright.c         |  196 +++
 b/drivers/input/touchscreen/touchwin.c           |  203 +++
 b/drivers/input/tsdev.c                          |    4 
 b/drivers/usb/input/Kconfig                      |    8 
 b/drivers/usb/input/Makefile                     |    3 
 b/drivers/usb/input/hid-core.c                   |    3 
 b/drivers/usb/input/hid-ff.c                     |    4 
 b/drivers/usb/input/hid-input.c                  |    2 
 b/drivers/usb/input/hid-lgff.c                   |  523 +--------
 b/drivers/usb/input/hid-pidff.c                  | 1330 +++++++++++++++++++++++
 b/drivers/usb/input/hid-tmff.c                   |  399 ------
 b/drivers/usb/input/hid-zpff.c                   |  110 +
 b/drivers/usb/input/hid.h                        |    1 
 b/include/linux/input.h                          |    3 
 b/include/linux/libps2.h                         |    1 
 b/include/linux/serio.h                          |    1 
 b/include/linux/uinput.h                         |   35 
 drivers/char/keyboard.c                          |    4 
 drivers/input/Makefile                           |    6 
 drivers/input/evbug.c                            |    8 
 drivers/input/evdev.c                            |   39 
 drivers/input/input.c                            |   34 
 drivers/input/joydev.c                           |    9 
 drivers/input/misc/wistron_btns.c                |    7 
 drivers/input/mousedev.c                         |    7 
 drivers/input/power.c                            |    4 
 drivers/input/serio/i8042-x86ia64io.h            |    7 
 drivers/input/serio/libps2.c                     |   18 
 drivers/input/touchscreen/Kconfig                |   24 
 drivers/input/touchscreen/Makefile               |    2 
 drivers/input/touchscreen/elo.c                  |   73 -
 drivers/input/tsdev.c                            |    8 
 drivers/usb/input/Kconfig                        |   10 
 drivers/usb/input/Makefile                       |    2 
 drivers/usb/input/fixp-arith.h                   |   87 -
 drivers/usb/input/hid-core.c                     |    2 
 drivers/usb/input/hid-ff.c                       |   45 
 drivers/usb/input/hid-input.c                    |   21 
 drivers/usb/input/hid-lgff.c                     |    2 
 drivers/usb/input/hid-tmff.c                     |    2 
 drivers/usb/input/hid.h                          |   35 
 drivers/usb/input/pid.c                          |  295 -----
 drivers/usb/input/pid.h                          |   62 -
 include/linux/input.h                            |  269 +++-
 include/linux/serio.h                            |    2 
 83 files changed, 4624 insertions(+), 2287 deletions(-)

-- 
Dmitry

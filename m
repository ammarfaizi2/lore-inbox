Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbTBFNEk>; Thu, 6 Feb 2003 08:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbTBFNEk>; Thu, 6 Feb 2003 08:04:40 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:57783 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267118AbTBFNEg>;
	Thu, 6 Feb 2003 08:04:36 -0500
Date: Thu, 6 Feb 2003 14:13:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Update of the input subsystem - 37 csets
Message-ID: <20030206141352.A10182@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Quite a lot of input patches have accumulated in my tree, I'm sending
them to you now.

You can pull the csets from:
	bk://kernel.bkbits.net/vojtech/input

For those who want to see a plain patch:
	http://atrey.karlin.mff.cuni.cz/~vojtech/input-2.5.59.diff

The most important changes include atkbd fixes for some notebooks and
non-PC archs, and passing of pt_regs all the way to keyboard.c so that
magic-sysrq works properly with all kinds of keyboards and multiple
keyboard setups.

Diffstat:

 arch/sparc64/kernel/irq.c                      |    3 
 drivers/acorn/char/keyb_arc.c                  |    1 
 drivers/char/ec3104_keyb.c                     |    2 
 drivers/char/keyboard.c                        |  148 ++++----
 drivers/char/misc.c                            |    3 
 drivers/input/gameport/ns558.c                 |    8 
 drivers/input/joydev.c                         |    9 
 drivers/input/joystick/amijoy.c                |    2 
 drivers/input/joystick/iforce/iforce-packets.c |    5 
 drivers/input/joystick/iforce/iforce-serio.c   |    4 
 drivers/input/joystick/iforce/iforce-usb.c     |   15 
 drivers/input/joystick/iforce/iforce.h         |    2 
 drivers/input/joystick/magellan.c              |    8 
 drivers/input/joystick/spaceball.c             |    8 
 drivers/input/joystick/spaceorb.c              |    8 
 drivers/input/joystick/stinger.c               |    8 
 drivers/input/joystick/twidjoy.c               |    8 
 drivers/input/joystick/warrior.c               |   10 
 drivers/input/keyboard/amikbd.c                |    2 
 drivers/input/keyboard/atkbd.c                 |   59 +--
 drivers/input/keyboard/newtonkbd.c             |    8 
 drivers/input/keyboard/sunkbd.c                |    5 
 drivers/input/keyboard/xtkbd.c                 |    3 
 drivers/input/misc/98spkr.c                    |   95 +++++
 drivers/input/misc/Kconfig                     |    4 
 drivers/input/misc/Makefile                    |    1 
 drivers/input/misc/gsc_ps2.c                   |   13 
 drivers/input/mouse/amimouse.c                 |    2 
 drivers/input/mouse/inport.c                   |    2 
 drivers/input/mouse/logibm.c                   |    1 
 drivers/input/mouse/pc110pad.c                 |    1 
 drivers/input/mouse/psmouse.c                  |   44 +-
 drivers/input/mouse/rpcmouse.c                 |    2 
 drivers/input/mouse/sermouse.c                 |   14 
 drivers/input/serio/ambakmi.c                  |    6 
 drivers/input/serio/ct82c710.c                 |    2 
 drivers/input/serio/i8042.c                    |   16 
 drivers/input/serio/parkbd.c                   |    2 
 drivers/input/serio/q40kbd.c                   |    3 
 drivers/input/serio/rpckbd.c                   |    5 
 drivers/input/serio/sa1111ps2.c                |    6 
 drivers/input/serio/serio.c                    |    4 
 drivers/input/serio/serport.c                  |    5 
 drivers/input/touchscreen/gunze.c              |    7 
 drivers/input/touchscreen/h3600_ts_input.c     |    6 
 drivers/macintosh/adbhid.c                     |   22 -
 drivers/serial/sunsu.c                         |    4 
 drivers/serial/sunzilog.c                      |    4 
 drivers/usb/input/Kconfig                      |   12 
 drivers/usb/input/Makefile                     |    3 
 drivers/usb/input/aiptek.c                     |   31 +
 drivers/usb/input/fixp-arith.h                 |   12 
 drivers/usb/input/hid-core.c                   |   28 -
 drivers/usb/input/hid-ff.c                     |    4 
 drivers/usb/input/hid-input.c                  |   13 
 drivers/usb/input/hid-tmff.c                   |  461 +++++++++++++++++++++++++
 drivers/usb/input/hid.h                        |    6 
 drivers/usb/input/hiddev.c                     |    2 
 drivers/usb/input/powermate.c                  |   25 -
 drivers/usb/input/usbkbd.c                     |    2 
 drivers/usb/input/usbmouse.c                   |    1 
 drivers/usb/input/wacom.c                      |   21 +
 drivers/usb/input/xpad.c                       |    6 
 include/asm-sparc/system.h                     |    2 
 include/asm-sparc64/system.h                   |    2 
 include/linux/hiddev.h                         |    4 
 include/linux/input.h                          |    5 
 include/linux/kbd_kern.h                       |    5 
 include/linux/keyboard.h                       |    1 
 include/linux/pc_keyb.h                        |  130 -------
 include/linux/serio.h                          |   13 
 71 files changed, 981 insertions(+), 408 deletions(-)

Changes:


ChangeSet@1.910, 2003-02-06 12:00:30+01:00, vojtech@suse.cz
  Automatic & manual BK merge

ChangeSet@1.909, 2003-02-05 20:51:14+01:00, vojtech@suse.cz
  input: serio.h - allocate an serio ID for SemTech touchscreen.

ChangeSet@1.908, 2003-02-03 00:08:52+01:00, deller@gmx.de
  input: Enable AT keyboard emulation on PA-RISC.

ChangeSet@1.907, 2003-01-30 10:15:29+01:00, vojtech@suse.cz
  input: sunkbd.c - fix reading beyond end of keycode array.

ChangeSet@1.906, 2003-01-29 20:38:58+01:00, vojtech@suse.cz
  input: psmouse.c - Fix and disable PS2++ debug message.

ChangeSet@1.905, 2003-01-29 10:15:16+01:00, vojtech@suse.cz
  input: psmouse.c: Fix PS2++ packet numbers.

ChangeSet@1.904, 2003-01-27 17:34:52+01:00, vojtech@suse.cz
  input: atkbd.c - Now that atkbd_command() handles RESET_BAT gracefully,
  we can reset the keyboard on reboot instead of setting old scancode
  set. This should help some notebooks which crash after Linux reboots.

ChangeSet@1.903, 2003-01-27 17:33:40+01:00, vojtech@suse.cz
  input: psmouse.c - Proper detection of PS2++ packets, take II

ChangeSet@1.902, 2003-01-26 22:11:45+01:00, vojtech@suse.cz
  input: psmouse.c - Fix Logitech PS2++ extended packet detection.

ChangeSet@1.901, 2003-01-26 16:05:33+01:00, zinx@epicsol.org
  input: tmff.c: Protect tmff_exit by grabbing a spinlock.

ChangeSet@1.900, 2003-01-26 15:49:21+01:00, vojtech@suse.cz
  input: serio.h - add SNES-232 serio type.

ChangeSet@1.899, 2003-01-26 15:21:48+01:00, vojtech@suse.cz
  input: Resurrect usb_set_report for Aiptek and Wacom tablets.

ChangeSet@1.898, 2003-01-26 13:52:29+01:00, zinx@epicsol.org
  input: tmff.c - Fix handling the case where the effect is re-uploaded
  to change strength of the effect.

ChangeSet@1.897, 2003-01-26 13:51:24+01:00, zinx@epicsol.org
  input: hid: use fuzz/flat filtering only for joysticks and gamepads.

ChangeSet@1.896, 2003-01-26 12:56:09+01:00, will@sowerbutts.com
  input: powermate.c: This works around an undocumented firmware bug
  in the Griffin PowerMate knob and fixes the handling of LED brightness.

ChangeSet@1.895, 2003-01-26 11:06:08+01:00, vojtech@suse.cz
  input: Don't require keys/buttons at all for joysticks. There are many
  weird devices that don't have them.

ChangeSet@1.894, 2003-01-25 22:44:45+01:00, zinx@epicsol.org
  input: Add support for ThrustMaster USB Force Feedback devices.

ChangeSet@1.893, 2003-01-25 18:07:05+01:00, vojtech@suse.cz
  input: Give preferential treatment to gameport at 0x201, and use
  the odd addresses for access.

ChangeSet@1.892, 2003-01-25 18:01:14+01:00, vojtech@suse.cz
  Input: Allow throttles without keys.

ChangeSet@1.891, 2003-01-25 17:39:00+01:00, vojtech@suse.cz
  input: Fix a typo the hid.h quirk definitions.

ChangeSet@1.890, 2003-01-25 17:26:02+01:00, vojtech@suse.cz
  Add USB hid blacklist driver entries for OnTrak data acquistion boards
  and a TangTop PS/2->USB converter.

ChangeSet@1.889, 2003-01-25 15:40:41+01:00, davem@redhat.com
  Final step of getting rid of kbd_pt_regs - pass the regs as arguments
  to handler_fn functions in keyboard.c

ChangeSet@1.888, 2003-01-25 14:34:17+01:00, geert@linux-m68k.org
  Amiga keyboard: the release bit indicates a key release, not a key press.

ChangeSet@1.887, 2003-01-25 14:33:15+01:00, geert@linux-m68k.org
  Q40/Q60 keyboard fixes:
    - IRQ definitions were prepended with Q40_
    - <asm/keyboard.h> no longer exists
    - Let q40kbd_init() fails if not running on a Q40/Q60
    - q40kbd_init() must return an error code
    - Make q40kbd_{init,exit}() static

ChangeSet@1.886, 2003-01-23 08:25:40+01:00, rddunlap@osdl.org
  hid-core.c: Add a missing error path on a possible urb allocation failure.

ChangeSet@1.885, 2003-01-21 17:21:50+01:00, tomita@cinet.co.jp
  Support for NEC PC-9800 beeper and support for Kana Lock LED.

ChangeSet@1.884, 2003-01-12 17:10:47+01:00, vojtech@suse.cz
  input: atkbd.c and psmouse.c had a race when reading the ID of the
  attached keyboard/mouse that could cause the device not to be found
  if it replied too fast. Fixed.

ChangeSet@1.883, 2003-01-12 14:05:52+01:00, vojtech@suse.cz
  Get rid of kbd_pt_regs.

ChangeSet@1.882, 2003-01-12 13:34:36+01:00, vojtech@suse.cz
  Pass pt_regs from interrupts (usb, serio, others) all the way to
  keyboard.c so that it can display them properly in SysRq.

ChangeSet@1.881, 2003-01-12 11:24:26+01:00, vojtech@suse.cz
  Merge suse.cz:/home/vojtech/bk/linus into suse.cz:/home/vojtech/bk/input

ChangeSet@1.880, 2003-01-11 23:01:56+01:00, vivienc@nerim.net
  atkbd->ack and psmouse->ack need to be volatile.

ChangeSet@1.879, 2003-01-08 09:46:41+01:00, zaitcev@redhat.com
  Let newly connected keyboards pickup the LED state.

ChangeSet@1.838.115.2, 2002-12-27 11:56:18+01:00, vojtech@suse.cz
  keyboard.c: Only print warnings when unable to generate rawmode when
  the event is a real key, not a button or whatever else.

ChangeSet@1.838.17.4, 2002-12-10 12:45:54-08:00, jsimmons@kozmo.(none)
  Delete: include/linux/pc_keyb.h

ChangeSet@1.838.17.3, 2002-12-10 12:07:45-08:00, jsimmons@kozmo.(none)
  The VT tty layer depends on the input api now. Fixed this dependency. 

ChangeSet@1.838.17.2, 2002-12-10 11:44:59-08:00, jsimmons@kozmo.(none)
  Old PS/2 code removal. 

ChangeSet@1.797.43.1, 2002-11-17 00:57:44+01:00, vojtech@suse.cz
  Avoid possible endless loop sending resend commands in atkbd.c
  with very stupid devices (like CCD-80SX barcode scanner, which
  doesn't trigger the problem only because of luck).


-- 
Vojtech Pavlik
SuSE Labs

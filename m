Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVCGPpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVCGPpl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVCGPpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:45:41 -0500
Received: from styx.suse.cz ([82.119.242.94]:58536 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261172AbVCGPnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:43:33 -0500
Date: Mon, 7 Mar 2005 16:46:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dtor_core@ameritech.net,
       perex@suse.cz, greg@kroah.com, linux-input@atrey.karlin.mff.cuni.cz
Subject: [bk, patches] Input update
Message-ID: <20050307154648.GA16207@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Now that 2.6.11 was released, I've got these nice 128 patches pending
for 2.6.12.

They include many fixes, several new drivers (mainly for touchscreens,
and less common architecture keyboards), refactoring of gameport
core to fix possible races, race fixes in serio.

The patches all have been in -mm for a while, some longer, some shorter,
and got testing in the SuSE kernel as well. I'm pretty confident they
fix a lot, and don't break much.

It's all available from:

	bk://kernel.bkbits.net/vojtech/for-linus

As well as (both as a big patch and split out):

	http://www.ucw.cz/~vojtech/input-2005-03-07

Please pull these changes in your tree.

Thanks,
	Vojtech

=======================================================================

 Documentation/kernel-parameters.txt          |   15 
 drivers/Makefile                             |    2 
 drivers/char/keyboard.c                      |   16 
 drivers/input/Kconfig                        |   25 
 drivers/input/evbug.c                        |    4 
 drivers/input/evdev.c                        |   16 
 drivers/input/gameport/Kconfig               |   48 -
 drivers/input/gameport/cs461x.c              |   37 
 drivers/input/gameport/emu10k1-gp.c          |   46 -
 drivers/input/gameport/fm801-gp.c            |   63 -
 drivers/input/gameport/gameport.c            |  705 ++++++++++++++++--
 drivers/input/gameport/lightning.c           |  180 ++--
 drivers/input/gameport/ns558.c               |  169 +---
 drivers/input/gameport/vortex.c              |   82 +-
 drivers/input/input.c                        |   17 
 drivers/input/joydev.c                       |   39 
 drivers/input/joystick/Kconfig               |   46 -
 drivers/input/joystick/a3d.c                 |  176 ++--
 drivers/input/joystick/adi.c                 |  122 +--
 drivers/input/joystick/analog.c              |  102 +-
 drivers/input/joystick/cobra.c               |   88 +-
 drivers/input/joystick/db9.c                 |    4 
 drivers/input/joystick/gamecon.c             |   23 
 drivers/input/joystick/gf2k.c                |   92 +-
 drivers/input/joystick/grip.c                |  103 +-
 drivers/input/joystick/grip_mp.c             |   97 +-
 drivers/input/joystick/guillemot.c           |   95 +-
 drivers/input/joystick/iforce/iforce-serio.c |   45 -
 drivers/input/joystick/interact.c            |   80 +-
 drivers/input/joystick/joydump.c             |   92 +-
 drivers/input/joystick/magellan.c            |   46 -
 drivers/input/joystick/sidewinder.c          |  157 ++--
 drivers/input/joystick/spaceball.c           |   52 -
 drivers/input/joystick/spaceorb.c            |   46 -
 drivers/input/joystick/stinger.c             |   47 -
 drivers/input/joystick/tmdc.c                |  102 +-
 drivers/input/joystick/turbografx.c          |    6 
 drivers/input/joystick/twidjoy.c             |   44 -
 drivers/input/joystick/warrior.c             |   43 -
 drivers/input/keyboard/Kconfig               |  114 ++
 drivers/input/keyboard/Makefile              |    5 
 drivers/input/keyboard/atkbd.c               |  142 ++-
 drivers/input/keyboard/corgikbd.c            |  361 +++++++++
 drivers/input/keyboard/hil_kbd.c             |  375 +++++++++
 drivers/input/keyboard/hilkbd.c              |  343 ++++++++
 drivers/input/keyboard/hpps2atkbd.h          |   11 
 drivers/input/keyboard/lkkbd.c               |   47 -
 drivers/input/keyboard/locomokbd.c           |  309 +++++++
 drivers/input/keyboard/newtonkbd.c           |   48 -
 drivers/input/keyboard/sunkbd.c              |   52 -
 drivers/input/keyboard/xtkbd.c               |   47 -
 drivers/input/misc/Kconfig                   |   23 
 drivers/input/misc/Makefile                  |    1 
 drivers/input/misc/hp_sdc_rtc.c              |  724 ++++++++++++++++++
 drivers/input/misc/pcspkr.c                  |    4 
 drivers/input/misc/uinput.c                  |  227 +++++
 drivers/input/mouse/Kconfig                  |   31 
 drivers/input/mouse/Makefile                 |    1 
 drivers/input/mouse/alps.c                   |  331 ++++----
 drivers/input/mouse/alps.h                   |   15 
 drivers/input/mouse/hil_ptr.c                |  414 ++++++++++
 drivers/input/mouse/logips2pp.c              |   23 
 drivers/input/mouse/psmouse-base.c           |  149 ++-
 drivers/input/mouse/psmouse.h                |    2 
 drivers/input/mouse/sermouse.c               |   87 +-
 drivers/input/mouse/synaptics.c              |   73 +
 drivers/input/mouse/synaptics.h              |    2 
 drivers/input/mouse/vsxxxaa.c                |   43 -
 drivers/input/mousedev.c                     |   41 -
 drivers/input/power.c                        |   12 
 drivers/input/serio/Kconfig                  |   57 +
 drivers/input/serio/Makefile                 |    2 
 drivers/input/serio/ambakmi.c                |    2 
 drivers/input/serio/ct82c710.c               |    6 
 drivers/input/serio/gscps2.c                 |   10 
 drivers/input/serio/hil_mlc.c                |  949 ++++++++++++++++++++++++
 drivers/input/serio/hp_sdc.c                 | 1055 +++++++++++++++++++++++++++
 drivers/input/serio/hp_sdc_mlc.c             |  358 +++++++++
 drivers/input/serio/i8042-x86ia64io.h        |  333 ++++----
 drivers/input/serio/i8042.c                  |  401 +++++-----
 drivers/input/serio/i8042.h                  |   10 
 drivers/input/serio/maceps2.c                |    2 
 drivers/input/serio/parkbd.c                 |   56 -
 drivers/input/serio/pcips2.c                 |    4 
 drivers/input/serio/q40kbd.c                 |    2 
 drivers/input/serio/rpckbd.c                 |    2 
 drivers/input/serio/sa1111ps2.c              |    2 
 drivers/input/serio/serio.c                  |  546 +++++++++----
 drivers/input/serio/serio_raw.c              |   43 -
 drivers/input/serio/serport.c                |   20 
 drivers/input/touchscreen/Kconfig            |   71 +
 drivers/input/touchscreen/Makefile           |    5 
 drivers/input/touchscreen/corgi_ts.c         |  380 +++++++++
 drivers/input/touchscreen/elo.c              |  315 ++++++++
 drivers/input/touchscreen/gunze.c            |   56 -
 drivers/input/touchscreen/h3600_ts_input.c   |   52 -
 drivers/input/touchscreen/hp680_ts_input.c   |  135 +++
 drivers/input/touchscreen/mk712.c            |  222 +++++
 drivers/input/touchscreen/mtouch.c           |  219 +++++
 drivers/input/tsdev.c                        |   11 
 drivers/serial/sunsu.c                       |    7 
 drivers/serial/sunzilog.c                    |    7 
 drivers/usb/input/ati_remote.c               |   36 
 drivers/usb/input/hid-core.c                 |  278 ++-----
 drivers/usb/input/hid-debug.h                |   12 
 drivers/usb/input/hid-ff.c                   |    1 
 drivers/usb/input/hid-input.c                |   42 -
 drivers/usb/input/hid-lgff.c                 |    1 
 drivers/usb/input/hid.h                      |    3 
 drivers/usb/input/hiddev.c                   |   13 
 drivers/usb/input/mtouchusb.c                |   37 
 drivers/usb/input/pid.c                      |  250 +++---
 drivers/usb/input/pid.h                      |   28 
 drivers/usb/input/powermate.c                |    1 
 drivers/usb/input/wacom.c                    |  335 ++++++--
 include/linux/gameport.h                     |  133 ++-
 include/linux/hiddev.h                       |    4 
 include/linux/input.h                        |    2 
 include/linux/joystick.h                     |    8 
 include/linux/keyboard.h                     |    2 
 include/linux/mod_devicetable.h              |   10 
 include/linux/serio.h                        |   94 +-
 include/linux/uinput.h                       |   92 ++
 include/sound/cs46xx.h                       |    4 
 include/sound/trident.h                      |    4 
 include/sound/ymfpci.h                       |   14 
 scripts/mod/file2alias.c                     |   23 
 sound/oss/cmpci.c                            |  100 +-
 sound/oss/es1370.c                           |   34 
 sound/oss/es1371.c                           |   52 -
 sound/oss/esssolo1.c                         |   47 -
 sound/oss/mad16.c                            |   47 -
 sound/oss/sonicvibes.c                       |   49 -
 sound/oss/trident.c                          |   47 -
 sound/pci/als4000.c                          |  111 +-
 sound/pci/au88x0/au88x0.c                    |    7 
 sound/pci/au88x0/au88x0.h                    |    2 
 sound/pci/au88x0/au88x0_game.c               |   60 -
 sound/pci/azt3328.c                          |  111 +-
 sound/pci/cmipci.c                           |  104 +-
 sound/pci/cs4281.c                           |   91 +-
 sound/pci/cs46xx/cs46xx_lib.c                |   81 --
 sound/pci/ens1370.c                          |  122 ++-
 sound/pci/es1938.c                           |   52 +
 sound/pci/es1968.c                           |   76 +
 sound/pci/sonicvibes.c                       |   55 +
 sound/pci/trident/trident.c                  |    2 
 sound/pci/trident/trident_main.c             |   85 +-
 sound/pci/via82xx.c                          |   89 +-
 sound/pci/ymfpci/ymfpci.c                    |  149 ++-
 sound/pci/ymfpci/ymfpci_main.c               |    9 
 151 files changed, 12216 insertions(+), 3362 deletions(-)

=======================================================================

ChangeSet@1.2007, 2005-03-07 15:30:12+01:00, akropel1@rochester.rr.com
  input: hid-debug.h includes resolv_event, which is not used if DEBUG is only
         enabled in hid-core, but _is_ used when DEBUG is also enabled in hid-input.
         Mark the function with __attribute__((unused)) to silence the warning
         when only hid-core is being DEBUGged.
  
  Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.2006, 2005-03-07 15:29:15+01:00, dtor_core@ameritech.net
  Input: export psmouse module parameters via sysfs:
            /sys/module/psmouse/parameters/proto
            /sys/module/psmouse/parameters/rate
            /sys/module/psmouse/parameters/resetafter
            /sys/module/psmouse/parameters/resolution
            /sys/module/psmouse/parameters/smartscroll
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.2005, 2005-03-07 15:28:44+01:00, dtor_core@ameritech.net
  Input: i8042 - disable MUX mode on some Fujitsu notebooks as it
         does not seem to be working properly and requires psmouse
         module to be reloaded several times for touchpad to be  
         identified correctly.  
         Since none of these notebooks have external PS/2 ports
         disabling MUX should have no drawbacks.  
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.2004, 2005-03-07 15:27:41+01:00, dtor_core@ameritech.net
  input: some whitespace and formatting cleanup in Corgi drivers.
         Also change del_timer to del_timer_sync in corgikbd and
         add missing del_timer_sync to corgi_ts.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.2003, 2005-03-07 15:24:32+01:00, dtor_core@ameritech.net
  input: Fix compiler warning in trident gameport code with enabled debugging
         and compiler error in ymfpci when compiled without gameport support.
  
  From: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.2002, 2005-03-07 15:15:42+01:00, c.lucas@ifrance.com
  input: convert from pci_module_init to pci_register_driver
  
  Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
  Signed-off-by: Domen Puncer <domen@coderock.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.2001, 2005-03-07 15:14:28+01:00, akropel@rochester.rr.com
  input: hid-debug.h uses a C99 feature (range designators) not available in
         gcc-2.95. Since gcc-2.95 is still a supported compiler for 2.6 and the 
         initializers as used here add no functional value, this patch removes
         them. gcc-2.95 is then able to compile hid-core with DEBUG enabled.
  
  Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.2000, 2005-03-07 15:13:27+01:00, lenz@cs.wisc.edu
  input: This patch is for the keyboard on Sharp Zaurus collie and poodle
         models (SL5000, SL5500, and SL5600).  It uses the devices exported
         in arch/arm/common/locomo.c.  The pressed state of the keys is now
         handled by the input layer rather than directly in this driver.
  
  More information about the status of Zaurus (and some extra patches
  if you need to test this out) can be found on my web page at
  http://www.cs.wisc.edu/~lenz/zaurus
  
  Signed-off-by: John Lenz <lenz@cs.wisc.edu>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1999, 2005-03-07 15:12:03+01:00, lethal@linux-sh.org
  New BitKeeper file ``drivers/input/touchscreen/hp680_ts_input.c''

ChangeSet@1.1998, 2005-03-07 15:10:51+01:00, vojtech@suse.cz
  input: Fix a connector name in a comment in lkkbd.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1997, 2005-03-07 15:09:59+01:00, vojtech@suse.cz
  input: Fix ALPS breakage caused by previous refactoring.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1996, 2005-03-07 15:07:54+01:00, vojtech@suse.cz
  input: Fix two typos in i8042 PnP code.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.73, 2005-03-01 14:13:43+01:00, ddstreet@ieee.org
  input: Add the option to use cooked coordinates in MicroTouch
         USB touchscreen driver.
  
  From: Dan Streetman <ddstreet@ieee.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.72, 2005-03-01 14:02:56+01:00, ddstreet@ieee.org
  input: Add MicroTouch (3M) serial touchscreen driver
  
  From: Dan Streetman <ddstreet@ieee.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.99.1, 2005-02-28 11:58:50+01:00, vojtech@suse.cz
  input: Make gameport digital joysticks work on 2.6 and x86_64 again.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.69, 2005-02-28 08:48:22+01:00, vojtech@suse.cz
  input: Add more PnP IDs to i8042 PnP probe table. BIOS manufacturers
         are very creative.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.68, 2005-02-26 09:01:13+01:00, vojtech@suse.cz
  input: Fix string formatting in joydump.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.67, 2005-02-26 08:13:30+01:00, dtor_core@ameritech.net
  input: set gameport devices' bus so they can be bound to drivers.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.66, 2005-02-25 21:21:03+01:00, vojtech@suse.cz
  input: After testing on real world hardware, it's obvious we can't trust
         ACPIPnP nor PnPBIOS to properly report the existence of a keyboard
         and mouse port in all cases. Some BIOSes hide the ports if no mouse
         or keyboard is connected, causing trouble with eg. KVM switches.
  
         The i8042 driver now does read-only probing first, which should
         not cause any problems even if an i8042 controller really is not
         present.
  
         However, on IA64 we still need to trust ACPI, since legacy-free hardware
         is common there and invalid port accesses cause exceptions.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.65, 2005-02-25 15:27:54+01:00, vojtech@suse.cz
  input: Add a missing brace in hid-core.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.64, 2005-02-25 08:17:35+01:00, vojtech@suse.cz
  input: Remove filtering of duplicate events in hid-core. HIDDEV wants them,
         and hid-input doesn't care, since input does the filtering anyway.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.63, 2005-02-25 08:06:21+01:00, dtor_core@ameritech.net
  input: atkbd - "scroll" is a per-device attribute, don't use global
         flag in interrupt handler.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.62, 2005-02-24 22:02:25+01:00, vojtech@suse.cz
  input: Disable scancode event generation in hid-core.c, as it can
         cause floods of events when devices don't honor the set_idle()
         call or report noise on absolute values, until a solution for
         this is found.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.61, 2005-02-24 21:54:53+01:00, vojtech@suse.cz
  input: Print a warning message when PnP fails to find an i8042
         controller.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.60, 2005-02-24 21:38:18+01:00, vojtech@suse.cz
  input: Make the i8042 PnP detection even more BIOS and CONFIG-proof.
         This now should work with almost any BIOS and kernel config
         combination.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.59, 2005-02-24 20:37:21+01:00, vojtech@suse.cz
  input: Separate dualpoint and passthrough flags in ALPS driver.
         Some non-dualpoint devices need passthrough enabled.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.58, 2005-02-24 20:12:05+01:00, vojtech@suse.cz
  input: Fix usage of *_MAX macros. Check keycode in KDIOSKEYCODE and
         EVIOCSKEYCODE macros to be <= KEY_MAX. Check off-by one mistakes
         in keycodemax usage. There was a lot of potential for overwriting
         memory. Also enlarge NR_KEYS to 256 while we're at it.
  
  Found-by: Georgi Guninski <guninski@guninski.com>
  Initial-patch-by: Linus Torvalds <torvalds@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.57, 2005-02-24 15:36:55+01:00, vojtech@suse.cz
  input: Make ALPS protocol synchronization dependent on
         protocol variant to enhance robustness.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.56, 2005-02-24 15:06:24+01:00, vojtech@suse.cz
  input: Fix i8042's interactions with ACPI. Only believe what ACPI
         tells us if it is enabled, if is PnP enabled, and if is
         ACPIPnP enabled. It will still lie to us, but it won't be
         too bad.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.54, 2005-02-24 12:44:37+01:00, vojtech@suse.cz
  input: Update kernel documentation to reflect the
         i8042.noacpi -> i8042.nopnp change.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.53, 2005-02-24 11:31:55+01:00, vojtech@suse.cz
  input: Workaround in i8042 for PnP BIOS reporting incorrect command
         register address. If the address is in the standard range,
         and a non-standard number is reported, we ignore it and use
         the default.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.52, 2005-02-24 10:40:24+01:00, dtor_core@ameritech.net
  Input: fix identation in PID driver.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.51, 2005-02-24 10:39:32+01:00, vojtech@suse.cz
  input: Rename hid_find_field to hidinput_find_field to
         match the naming convention in hid-input
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz> 

ChangeSet@1.1982.10.50, 2005-02-24 10:31:36+01:00, dtor_core@ameritech.net
  input: Fix compilation warning in PID driver and generally
         repair force feedback effect erase routine that could
         never have worked.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.49, 2005-02-24 10:20:01+01:00, dtor_core@ameritech.net
  input: Fix sermouse not to call serio_open() twice.
         Bug introduced in last serio update.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.48, 2005-02-24 10:18:37+01:00, dtor_core@ameritech.net
  input: adjust file2alias utility to export aliases for
         serio drivers (serio:tyNprNidNexN).
         Move serio_device_id from serio.h to mod_devicetable.h
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.47, 2005-02-24 10:04:38+01:00, vojtech@suse.cz
  input: Add support for less usual ALPS touchpads, rearrange code,
         separate touchpoint/passthrough into its own input device.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.46, 2005-02-23 20:43:04+01:00, vojtech@suse.cz
  input: Add a missing ';' to hid-core.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.88.1, 2005-02-23 17:40:00+01:00, vojtech@suse.cz
  input: Fix keyboard scrollwheel support, add horizontal
         wheel support, and enable both by default.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.44, 2005-02-21 11:07:58+01:00, vojtech@suse.cz
  input: Fix a few conditions in power.c, which kept it from doint
         anything at all.
  
  Found-by: BJ Douma <bjdouma@xs4all.nl>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.43, 2005-02-16 09:35:42+01:00, dtor_core@ameritech.net
  Input: fix timer handling race in sidewinder joystick driver by
         switching to gameport's polling facilities.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.42, 2005-02-16 08:51:47+01:00, vojtech@suse.cz
  input: Fix Microtouch USB touchscreen Y axis direction.
         [0,0] should be upper left corner.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.41, 2005-02-15 21:05:48+01:00, vojtech@suse.cz
  input: Properly ignore padding fields in HID reports.
  
  Bug-found-by: Ted <6x0124@yahoo.com.tw>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.40, 2005-02-15 16:05:47+01:00, dtor_core@ameritech.net
  Input: fix race timer handling races in gameport-based joystick drivers
         by moving pollig timer down into gameport and using spinlock to
         protect it.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.39, 2005-02-15 15:14:38+01:00, syrjala@sci.fi
  input: Some changes to ati_remote key assignments:
  - Channel up/down keys are reversed on my ATI Remote Wonder.
  - Use KEY_TV, KEY_DVD and KEY_OK where appropriate.
  - Replace KEY_PLAYCD with KEY_PLAY.
  
  Signed-off-by: Ville Syrjala <syrjala@sci.fi>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.38, 2005-02-15 15:13:33+01:00, syrjala@sci.fi
  input: Make ati_remote clean up properly when removing either the device or the
  module.
  
  Signed-off-by: Ville Syrjala <syrjala@sci.fi>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.37, 2005-02-14 07:59:28+01:00, dtor_core@ameritech.net
  Input: psmouse should probe for "special" protocols only if max
         protocol is greater than IMEX so that proto=imps and    
         proto=exps options work. Fix Kensington case.       
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.36, 2005-02-13 18:58:47+01:00, petero2@telia.com
  input: Store alps hardware version info in the input_dev structure, so that
         it shows up in /proc/bus/input/devices.
   
  Signed-off-by: Peter Osterlund <petero2@telia.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.34, 2005-02-12 20:10:55+01:00, vojtech@suse.cz
  input: HID list handling cleanup, fix two bugs in pid.c and one in hid-core.c
         that the cleanup uncovered. Remove a workaround for BTC keyboard 
         46e:5303, because it's breaking other devices. Instead enable
         QUIRK_NOGET for this keyboard.
         Change set_idle handling to use a '0' report ID, meaning all reports
         instead of iterating over each individual report ID. This shouldn't
         change much, since most normal devices have only one report with
         id '0'.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.33, 2005-02-12 20:05:32+01:00, vojtech@suse.cz
  input: Add pin numbers to parkbd.c documentation.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.31, 2005-02-12 08:18:35+01:00, davej@redhat.com
  input: Looks like someone forgot the ARCH_
  
  Signed-off-by: Dave Jones <davej@redhat.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.10.29, 2005-02-11 17:08:14+01:00, n1gp@hotmail.com
  input: Fix keybit initialization in MK712 touchscreen driver.
         With this, the driver is tested to work properly.
  
  From: Richard Koch <n1gp@hotmail.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.55.10, 2005-02-11 01:23:40-05:00, dtor_core@ameritech.net
  Input: remove gameport->private in favor of using driver-specific data
         in device structure, add gameport_get/set_drvdata to access it.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.9, 2005-02-11 01:21:32-05:00, dtor_core@ameritech.net
  Input: complete gameport sysfs integration, ports are now
         devices in driver model. Implemented similarly to serio.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.8, 2005-02-11 01:21:02-05:00, dtor_core@ameritech.net
  Input: integrate gameport drivers info dribver model/sysfs,
         create "gameport" bus. drivers' connect() routines
         now return error code instead of void.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.7, 2005-02-11 01:20:30-05:00, dtor_core@ameritech.net
  Input: convert sound/pci to dynamic gameport allocation.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.6, 2005-02-11 01:20:08-05:00, dtor_core@ameritech.net
  Input: convert sound/oss to dynamic gameport allocation.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.5, 2005-02-11 01:19:36-05:00, dtor_core@ameritech.net
  Input: convert input/gameport to dynamic gameport allocation.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.4, 2005-02-11 01:18:48-05:00, dtor_core@ameritech.net
  Input: prepare for dynamic gameport allocation:
         - provide functions to allocate and free gameports;
         - provide functions to properly set name and phys;
         - dynamically allocated gameports are automatically
           announced in kernel logs and freed when unregistered.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.3, 2005-02-11 01:18:29-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for gameport
         drivers since that's where gameport_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.2, 2005-02-11 01:09:59-05:00, dtor_core@ameritech.net
  Input: more renames in gameport in preparations to sysfs integration
         - gameport_dev -> gameport_driver
         - gameport_[un]register_device -> gameport_[un]register_driver
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.55.1, 2005-02-11 01:09:43-05:00, dtor_core@ameritech.net
  Input: rename gameport->driver to gameport->port_data in preparation
         to sysfs integration.
    
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

ChangeSet@1.1982.50.1, 2005-02-09 20:48:10+01:00, vojtech@suse.cz
  input: Fix Elo touchscreen touch detection.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.151, 2005-02-09 10:17:53+01:00, jbj1@ultraemail.net
  input: Fix a code example in a comment in hiddev.c
  
  From: Jens B. Jorgensen <jbj1@ultraemail.net>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.150, 2005-02-09 10:09:47+01:00, vojtech@suse.cz
  input: Add support for serial ELO touchscreens, including
         Elo IntelliTouch, AccuTouch and SecureTouch.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.148, 2005-02-09 08:24:55+01:00, dtor_core@ameritech.net
  Input: alps - fix protocol validation rules causing touchpad
         to lose sync if an absolute packet is received after
         a relative packet with negative Y displacement.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.147, 2005-02-08 19:04:58+01:00, castet.matthieu@free.fr
  input: this patch turns off the pc speaker when pcspkr.ko is unloaded,
         else it would never stop
  
  Signed-off-by: Matthieu Castet <castet.matthieu@free.fr>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.145, 2005-02-08 18:00:02+01:00, svrmgrl@gmx.net
  input: Add a new ID to the Logitech ForceFeedback joystick driver.
  
  From: Rainer Kümmerle <svrmgrl@gmx.net>
  Acked-by: Johann Deneux <johann.deneux@it.uu.se>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.144, 2005-02-08 17:53:43+01:00, hal@realmsys.com
  input: Fix range checks for the HIDIOC[GS]USAGES ioctl() to allow
         reading full number of bytes.
  
  From: Hal Tolley <hal@realmsys.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.143, 2005-02-08 17:37:12+01:00, vojtech@suse.cz
  input: Move #include <linux/interrupt.h> inside #ifdef __KERNEL__
         in serio.h, to make it userspace-compilable.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.142, 2005-02-08 17:35:59+01:00, vojtech@suse.cz
  input: Change touchscreen drivers NOT to rescale their values
         to a 4:3 shape.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.140, 2005-02-08 10:27:30+01:00, stuart_hayes@dell.com
  input: A Chicony keyboard doesn't like get_report on its non-exisiting
         PS/2 mouse interface. Add to HID blacklist.
  
  From: Stuart Hayes <stuart_hayes@dell.com>
  Seen-by: Pete Zaitcev <zaitcev@redhat.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.139, 2005-02-08 10:20:19+01:00, akpm@osdl.org
  input: On some architectures the atomic ops return `long'. Fix
         a printk() in serio.c to take that into account.
  
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.138, 2005-02-08 10:18:37+01:00, dtor_core@ameritech.net
  Input: make sure that all instances of ns558 are released
         upon module unload.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.137, 2005-02-08 08:53:09+01:00, rufus-kernel@hackish.org
  input: For now, a bug in the PSX controllers support in gamecon prevents
  hot-swapping of such controllers. If a controllers is removed then all
  the controllers stop working and cpu usage gets high. The attached patch
  (against 2.6.11-rc3) corrects this bug by checking the information read
  from the controller. If the message length is bigger than the maximum
  possible, then it means the controller is not there and therefore this
  value should be discarded.
  
  Note that this is a re-send of a previous patch now that the patch of
  Peter (which had to be applied before this one) has been intregrated in
  the vanilla kernel. It's Peter's version modified to apply cleanly
  against 2.6.11-rc3 plus a fix in the comment.
  
  Signed-off-by: Peter Nelson <rufus-kernel@hackish.org>
  Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>

ChangeSet@1.1982.22.136, 2005-02-07 21:13:22+01:00, krautz@gmail.com
  input: Make the polling interval for mice a configurable parameter
         of the HID driver. This is useful when a faster response
         from a mouse is beneficial, ie games.
  
  Signed-off-by: Mikkel Krautz <krautz@gmail.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.135, 2005-02-07 20:46:26+01:00, vojtech@silver.ucw.cz
  input: Fix i8042 PnP printk()'s and pnp_driver name.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.134, 2005-02-07 19:00:24+01:00, castet.matthieu@free.fr
  input: Now that ACPIPnP is available, replace ACPI probing in i8042
         with PnP probing.
  
  From: Matthieu Castet <castet.matthieu@free.fr>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.133, 2005-02-07 18:32:36+01:00, duraid@octopus.com.au
  input: Properly set input.phys in Griffin Powermate driver.
  
  From: Duraid Madina <duraid@octopus.com.au>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.132, 2005-02-07 18:30:35+01:00, vojtech@silver.ucw.cz
  input: Do a kill_fasync() in input handlers on device disconnect
         to notify a client using poll() that the device is gone.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.131, 2005-02-07 13:09:39+01:00, dtor_core@ameritech.net
  Input: fix compie error in twidjoy.c
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.130, 2005-02-07 10:53:26+01:00, vojtech@suse.cz
  input: This patch fixes an oops in ns558 when no ports are found and
  at the same time the driver gets registered with the PnP subsystem.
  Since there is no need for port->type struct member, it removes it.
  Patch based on a patch from Matthieu Castet <castet.matthieu@free.fr>
  and Adam Belay <ambx1@neo.rr.com>
    
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.128, 2005-02-06 20:56:49+01:00, bunk@stusta.de
  input: This patch removes the bouncing email address of Victor Krapivin from
  MODULE_AUTHOR.
  
  Signed-off-by: Adrian Bunk <bunk@stusta.de>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.127, 2005-02-06 20:47:57+01:00, juhl-lkml@dif.dk
  input: ere's a patch that removes a few pointless comparisons; "scancode" is
  unsigned so it can never be <0 which makes the test pointless.
  Also, there are a few instances where signed and unsigned variables are
  comared, and as far as I can tell they really should just all be unsigned.
  
  Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.126, 2005-02-06 20:19:36+01:00, pingc@wacom.com
  input: This patch adds support for a Wacom new tablet, Intuos3, and its associated
  tools.
  
  From: Ping Cheng <pingc@wacom.com>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.124, 2005-02-06 19:56:01+01:00, vojtech@silver.ucw.cz
  input: Fix ExplorerPS/2 wheel emulation for wheel events > 8 ticks.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.123, 2005-02-06 19:49:20+01:00, vojtech@silver.ucw.cz
  input: Typo fix in parkbd.c comment
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.122, 2005-02-06 18:04:33+01:00, vojtech@silver.ucw.cz
  input: Document the adapter schematic needed for parkbd.c, right
         in the source.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.121, 2005-02-06 15:55:16+01:00, akropel1@rochester.rr.com
  I have a buggy USB HID device (APC SmartUPS) in which the designers
  forgot that ReportCount is a global item. Consequently, according to the
  report descriptor, several reports have multiple copies of the same
  usage in each field. When you actually query the device, however, only a
  single copy of the usage is returned. hid-core catches the expected vs.
  actual length mismatch and fails the transfer. This effectively makes
  the buggy reports inaccessible even though enough data is present to
  populate one usage (which is all userspace wants anyway).
  
  This patch changes hid-core to only warn (if debug is enabled) on such
  reports rather than failing the transfer.
  
  Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.120, 2005-02-06 15:46:02+01:00, cl81@gmx.net
  input: Typo fix in atkbd.c comment
  
  From: Christian Ludwig <cl81@gmx.net>
  Signed-off-by: Adrian Bunk <bunk@stusta.de>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.119, 2005-02-06 14:34:19+01:00, deller@gmx.de
  input: HP HIL support (from PARISC Linux tree).
  
  From: Helge Deller <deller@gmx.de>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.118, 2005-02-06 13:58:37+01:00, vojtech@silver.ucw.cz
  input: Fix poll() behavior of input handlers on disconnect.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.117, 2005-02-06 11:18:28+01:00, vojtech@silver.ucw.cz
  input: Add MCC devices to HID blacklist, cleanup whitespace along
         the way.
  
  From: Mark Glines <mark-pmd@glines.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.115, 2005-02-06 10:15:36+01:00, dtor_core@ameritech.net
  Input: add resume method to serio bus so ports are properly
         set up at resume time. Remove calls to serio_reconnect
         from i8042 as they should now be reconnected in course
         of regular resume process.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.114, 2005-02-06 10:13:52+01:00, vojtech@silver.ucw.cz
  input: New driver for ICS MicroClock MK712 TouchScreens.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.113, 2005-02-05 20:08:22+01:00, rpurdie@rpsys.net
  input: Add support for Sharp SL-C7xx touchscreen (Corgi).
  
  From: Richard Purdie <rpurdie@rpsys.net>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.112, 2005-02-05 20:06:12+01:00, rpurdie@rpsys.net
  input: Add support for Sharp Zaurus SL-C7cc Corgi keyboards.
  
  From: Richard Purdie <rpurdie@rpsys.net>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.111, 2005-02-05 13:25:50+01:00, dtor_core@ameritech.net
  Input: make serio drivers register asynchronously. This should
         speed up boot process as some drivers take a long time
         probing for supported devices.
  
         Also change __inline__ to inline in serio.h
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.110, 2005-02-05 07:23:23+01:00, bunk@stusta.de
  input: This patch makes two needlessly global functions static.
  
  Signed-off-by: Adrian Bunk <bunk@stusta.de>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.109, 2005-02-04 20:06:07+01:00, petero2@telia.com
  input: Only parse a "z == 127" packet as a relative Dualpoint stick
  packet if the touchpad actually is a Dualpoint device.  The Glidepoint
  modelsdon't have a stick, and can report z == 127 for a very wide finger.
  If such a packet is parsed as a stick packet, the mouse pointer will
  typically jump to one corner of the screen.
  
  Signed-off-by: Peter Osterlund <petero2@telia.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.108, 2005-02-04 20:04:21+01:00, petero2@telia.com
  input: When hardware tapping is disabled on an ALPS touchpad, the touchpad
  generates exactly the same data for a single tap and a fast double
  tap.  The effect is that the second tap in the double tap sequence is
  lost.
  
  To fix this problem, this patch enables hardware tapping and converts
  the resulting tap and gesture bits to standard finger pressure values
  (z), which is what mousedev.c and the userspace X driver expects.
  
  Signed-off-by: Peter Osterlund <petero2@telia.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.106, 2005-02-04 15:41:37+01:00, zippel@linux-m68k.org
  input: Cleanup the Kconfig menus for the input subsystem.
  
  From: Roman Zippel <zippel@linux-m68k.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.105, 2005-02-04 15:35:12+01:00, vojtech@suse.cz
  input: Add support for the Logitech MX1000 mouse in PS/2 mode.

ChangeSet@1.1982.22.104, 2005-02-04 14:35:55+01:00, gijoe@poczta.onet.pl
  input: Add support for Logitech MX300 mouse in PS/2 mode.
  
  From: Daniel Johnson <gijoe@poczta.onet.pl>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.103, 2005-02-04 14:25:26+01:00, petero2@telia.com
  input: Correct Y axis range for ALPS touchpads.
  
  From: Peter Osterlund <petero2@telia.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.102, 2005-02-04 14:23:40+01:00, petero2@telia.com
  input: Here it is, with the suggestions from Pete and Dmitry included. The
  patch does the following:
  
  * Compensates for the lack of floating point arithmetic by keeping
    track of remainders from the integer divisions.
  * Removes the xres/yres scaling so that you get the same speed in the
    X and Y directions even if your screen does not the same aspect ratio
    as your touchpad.
  * Sets scale factors to make the speed for synaptics and alps equal to
    each other and equal to the synaptics speed from 2.6.10.
  
  Signed-off-by: Peter Osterlund <petero2@telia.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.101, 2005-02-04 14:20:48+01:00, petero2@telia.com
  input: Some Synaptics touchpads have a middle mouse button that also works
  as a scroll wheel.  Scroll data is reported as packets with w == 2 and
  the scroll amount in byte 1, treated as a signed character.  For some
  reason, the smallest possible wheel movement is reported as a scroll
  amount of 4 units.  This amount is typically spread out over more than
  one packet, so the driver has to accumulate scroll delta values to
  correctly deal with this.
  
  Signed-off-by: Peter Osterlund <petero2@telia.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.100, 2005-02-04 14:16:34+01:00, petero2@telia.com
  input: mousedev_packet() incorrectly clears list->ready when called with
  "tail == head - 1".  The effect is that the last mouse event from the
  hardware isn't reported to user space until another hardware mouse
  event arrives.  This can make the left mouse button get stuck when
  tapping on a touchpad.  When this happens, the button doesn't unstick
  until the next time you interact with the touchpad.
  
  Signed-off-by: Peter Osterlund <petero2@telia.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.99, 2005-02-04 14:13:08+01:00, rddunlap@osdl.org
  input: joydump_connect: reduce stack usage from 2048 to 44 bytes (on i386)
  by allocating 'buf' dynamically;
          struct joydump buf[BUF_SIZE]; // 2048 bytes
  
  Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.98, 2005-02-04 14:09:42+01:00, micah@navi.cx
  input: This patch adds support to uinput for Linux's force feedback interface.
         With these changes, it's possible to write drivers for force feedback
         joysticks and similar devices in userspace.  It also adds a way to set the
         physical path of devices created via uinput, and it has a couple trivial
         bugfixes.
  
  Signed-off-by: Micah Dowty <micah@navi.cx>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.97, 2005-02-04 14:06:43+01:00, vojtech@suse.cz
  input: Don't even try to reset the i8042 controller when it's not
         willing to talk to us at all - it's probably not there.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.96, 2005-02-04 13:49:36+01:00, prarit@sgi.com
  Input: i8042 - call i8042_platform_exit to release resources
         acquired by i8042_platform_init when controller
         initialization fails.
  
  Signed-off-by: Prarit Bhargava <prarit@sgi.com>
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.95, 2005-02-04 13:47:18+01:00, bunk@stusta.de
  Input: Make some needlessly global code static.
  
  Signed-off-by: Adrian Bunk <bunk@stusta.de>
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.94, 2005-02-04 13:44:14+01:00, dtor@mail.ru
  Input: serio - export id.type, id.proto, id.id and id.extra as
         sysfs attributes to assist hotplug scripts in recovering
         lost boot-time serio hotplug events.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.93, 2005-02-04 13:43:30+01:00, dtor@mail.ru
  Input: i8042 - fix 'noloop' module parameter description
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.92, 2005-02-04 13:42:32+01:00, dtor@mail.ru
  Input: make serio's connect routines return error code
         instead of void.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.91, 2005-02-04 13:40:52+01:00, dtor@mail.ru
  Input: make serio implementation more in line with standard
         driver model implementations. serio_register_port is
         always asynchronous to allow freely registering child
         ports. When deregistering serio core still takes care
         of destroying children ports first.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.90, 2005-02-04 13:39:25+01:00, dtor@mail.ru
  Input: replace serio's type field with serio_id structure and
         add id_table to serio drivers to split initial matching
         and probing routines for better sysfs integration and
         to assist hotplug scripts in loading proper drivers.
         Add serio_hotplug to notify userspace about new ports.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.89, 2005-02-04 13:36:53+01:00, dtor@mail.ru
  Input: remove serio->private in favor of using driver-specific data
         in device structure, add serio_get_drvdata/serio_put_drvdata
         to access it.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.88, 2005-02-04 13:33:07+01:00, dtor@mail.ru
  Input: use msecs_to_jiffies instead of manually calculating
         delay for Toshiba bouncing keys workaround to the code
         works with HZ != 1000.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.87, 2005-02-04 13:24:54+01:00, dtor@mail.ru
  Input: use msecs_to_jiffies instead of homegrown ms_to_jiffies
         when setting timer for autorepeat handling. This will
         make sure that autorepeat is scheduled correctly when
         HZ != 1000.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.86, 2005-02-04 13:22:01+01:00, dtor@mail.ru
  Input: twidjoy - apparently Kconfig and Makefile disagreed on the
         name for config option so the module was never built.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.85, 2005-02-04 13:18:43+01:00, dtor@mail.ru
  Input: synaptics - use DMI to detect Toshiba Satellite notebooks
         and automatically reduce touchpad reporting rate to 40 pps
         as they have trouble handling high rate (80 pps).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.84, 2005-02-04 13:17:07+01:00, dtor@mail.ru
  Input: evdev - return -EINVAL from evdev_read if read buffer
         is too small.
  
         Based on a patch by James Lamanna.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.83, 2005-02-04 13:14:06+01:00, dtor@mail.ru
  Input: rearrange serio event processing to get rid of duplicate
         events - do not sumbit event into the event queue if similar
         event has not been processed yet; also once event has been
         processed check the queue and delete events of the same type
         that have been accumulated in the mean time.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.82, 2005-02-04 13:08:36+01:00, dtor@mail.ru
  Input: i8042 - make use of new serio start() and stop() callbacks
         to ensure that i8042 interrupt handler that is shared among
         several ports does not reference deleted ports. Also rename
         i8042_valies structure to i8042_port, consolidate handling
         of KBD, AUX and MUX ports, rearrange interrupt handler code.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.81, 2005-02-04 12:57:11+01:00, dtor@mail.ru
  Input: add serio->start() and serio->stop() callback methods that
         are called whenever serio port is finishes being registered
         or unregistered. The callbacks are useful for drivers that
         share interrupt between several ports and there is a danger
         that interrupt handler will reference port that was just
         unregistered.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

ChangeSet@1.1982.22.80, 2005-02-04 12:55:58+01:00, dtor@mail.ru
  Input: i8042 - move panicblink with the rest of module parameters,
         add proper entry to kernel-parameters.txt
          
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

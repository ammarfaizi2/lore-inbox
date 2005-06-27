Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVF0PCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVF0PCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVF0O4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:56:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:11488 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261501AbVF0NPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:15:07 -0400
Date: Mon, 27 Jun 2005 15:15:05 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Input patches for 2.6.12+
Message-ID: <20050627131505.GB9180@ucw.cz>
References: <200506250217.56648.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506250217.56648.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 02:17:56AM -0500, Dmitry Torokhov wrote:

> Hi Vojtech,
> 
> Please consider "blessing" the following pull from my input tree:
> 
> git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> 
> It mostly contains bits of your old bk-input tree that have not
> been merged yet, Wacom update, new Acecad tablet driver, and some
> patches from me (gameport support cleanup in OSS, some Lifebook
> changes).
> 
> The changes were in -mm for some time now.
> 
> Thank you.

Dmitry, thanks for your work collecting these and moving from my BK to
GIT.

The patches indeed are all OK for merging.

Linus, please pull this tree into yours.

> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Mon, 06 Jun 2005 12:28:29 -0500
> 
> Input: wacom - fix formatting in accordance to CodingStyle
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Ping Cheng <pingc@wacom.com> Mon, 06 Jun 2005 12:25:50 -0500
> 
> Input: Wacom driver update
>        - add support for Cintiq 21UX
>        - fix a Graphire bug
>        - merge wacom_intuos3_irq into wacom_intuos_irq
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Stephane VOLTZ <svoltz@numericable.fr> Mon, 06 Jun 2005 12:22:37 -0500
> 
> Input: add driver for Acecad Flair USB tablets
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:40:01 -0500
> 
> Input: psmouse - export protocol as a sysfs per-device attribute
>        to allow easy switching at run-time.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:39:53 -0500
> 
> Input: cleanup ps2_command() timeout handling in libps2.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:39:51 -0500
> 
> Input: add ps2_drain() to libps2 to allow reading and discarding
>        given number of bytes from device. Change ps2_command to
>        allow using 0 as command ID and actually pass it to the
>        device instead of working as a drain.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:39:44 -0500
> 
> Input: pmouse - introduce proper locking so state-changing
>        operations do not iterfere with each other.
>        Also make sure that serio core takes serio->drv_sem
>        not only for connect/disconnect but for reconnect
>        too.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:39:36 -0500
> 
> Input: mousedev - do not wake up readers when receiving 0-motion
>        event.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Luke Kosewski <lkosewsk@nit.ca> Wed, 01 Jun 2005 12:39:28 -0500
> 
> Input: do not corrupt system-wide procfs fops.
> 
> entry->proc_fops is a pointer to struct file_operations. When we
> call create_proc_entry(...), it pointis to proc_file_operations,
> deep in fs/proc/generic.c. By adding a 'poll' member to this struct
> we effectively force the 'poll' member on every file in /proc,
> which is wrong (they all fail select(...) calls).
> 
> This patch changes a copy of entry->proc_fops and reassigns it rather
> than changing the original member.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Ian Campbell <icampbell@arcom.com> Wed, 01 Jun 2005 12:39:25 -0500
> 
> Input: return correct value when setting up absolute device via uinipt.
> 
> uinput_alloc_device() is supposed to return the number of bytes read,
> the value is returned to uinput_write() and from there to userspace. If
> EV_ABS is set then it returns the value from uinput_validate_absbits()
> instead, which is zero when everything is ok instead of the count.
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>
> Acked-by: Aristeu Rozanski <aris@cathedrallabs.org>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Ivan Casado Ruiz <casadoi@yahoo.co.uk> Wed, 01 Jun 2005 12:39:18 -0500
> 
> Input: ALPS - fix forward/back buttons on Ahtec laptop.
> 
> I have an Ahtec laptop with a ALPS GlidePoint device, with 4 buttons.
> With Linux hernel 2.6.12rc4 and rc5 I'm unable to use the vertical
> scroll buttons (BACK and FORWARD).
> 
> BACK gets detected as BTN_MIDDLE and FORWARD is undetected.
> 
> I've modified the drivers/input/mouse/alps.c from 2.6.12rc5 and now it
> works fine!
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Adrian Bunk <bunk@stusta.de> Wed, 01 Jun 2005 12:39:11 -0500
> 
> Input: kill empty comment in gameport support section of
>        cs4281 ALSA driver.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:39:04 -0500
> 
> Input: ES1371 (OSS) - do not carry around gameport code if gameport
>        core support is disabled.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:39:00 -0500
> 
> Input: ES1370 (OSS) - do not carry around gameport code if gameport
>        core support is disabled.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:38:53 -0500
> 
> Input: make sure that joystick support in CMPCI driver can only be
>        selected if either gameport is built-in or _both_ gameport
>        and cmpci are built as modules.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:38:46 -0500
> 
> Input: mad16 (OSS) - do not carry around gameport code if gameport core
>        support is disabled.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:38:43 -0500
> 
> Input: sonicvibes (OSS) - do not carry around gameport code if gameport
>        core support is disabled.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:38:37 -0500
> 
> Input: trident (OSS) - do not carry around gameport code if gameport
>        core support is disabled, some formatting changes.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:38:33 -0500
> 
> Input: ESS Solo (OSS) - do not carry around gameport code if gameport
>        core support is disabled.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:38:16 -0500
> 
> Input: switch gameport core to using kthread API instead of
>        using daemonize() and signals. This way kgameportd will
>        never be accidentially killed.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Wed, 01 Jun 2005 12:38:12 -0500
> 
> Input: switch serio core to using kthread API instead of using
>        daemonize() and signals. This way kseriod will never be
>        accidentially killed.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:30:37 -0500
> 
> Input: apparently Lifebook touchscreens have double resolution
>        compared to "classic" PS/2 mice, provide appropriate
>        resolution setting handler.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:30:32 -0500
> 
> Input: lifebook - adjust initialization routines to be in line with
>        the rest of protocols in preparation to dynamic protocol
>        switching.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:30:28 -0500
> 
> Input: lifebook - various cleanups:
>        - do not try to set rate and resolution in init method, let
>          psmouse core do it for us. This also removes special quirks
>          from the core;
>        - do not disable mouse before doing full reset - meaningless;
>        - some formatting and whitespace cleanups.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Kenan Esau <kenan.esau@conan.de> Sun, 29 May 2005 12:30:22 -0500
> 
> Input: Add Fujitsu Lifebook B-series touchscreen driver.
> 
> From: Kenan Esau <kenan.esau@conan.de>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Vojtech Pavlik <vojtech@suse.cz> Sun, 29 May 2005 12:30:15 -0500
> 
> Input: Make EVIOSCSABS work in evdev.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Adam Kropelin <akropel1@rochester.rr.com> Sun, 29 May 2005 12:30:08 -0500
> 
> Input: HID items of width 32 (bits) or greater are incorrectly extracted
>        due to a masking bug in hid-core.c:extract(). This patch fixes it
>        up by forcing the mask to be 64 bits wide.
> 
> Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Marian-Nicolae V. Ion <marian_ion@noos.fr> Sun, 29 May 2005 12:30:01 -0500
> 
> Input: Add a new I-Force device to the iforce driver.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:52 -0500
> 
> Input: fix open/close races in joystick drivers - add a semaphore
>        to the ones that register more than one input device.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:45 -0500
> 
> Input: remove user counters from drivers/input/touchscreen since
>        input core takes care of calling open and close methods
>        only when needed.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:38 -0500
> 
> Input: remove user counters from drivers/usb/input since input
>        core takes care of calling open and close methods only
>        when needed.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:30 -0500
> 
> Input: remove user counters from drivers/input/mouse since input
>        core takes care of calling open and close methods only
>        when needed.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:25 -0500
> 
> Input: add semaphore and user count to input_dev structure;
>        serialize open and close calls and ensure that device's
>        open and close methods are only called when first user
>        opens it or last user closes it.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:19 -0500
> 
> Input: maple_keyb - remove useless dc_kbd_open and dc_kbd_close
>        functions as they are not doing anything.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:08 -0500
> 
> Input: mtouchusb was indented with spaces instead of tabs, pass
>        through Lindent and adjust results.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:01 -0500
> 
> Input: whitespace fixes in drivers/usb/input
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:28:55 -0500
> 
> Input: whitespace fixes in driver/input/joystick
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:28:50 -0500
> 
> Input: whitespace fixes in drivers/input/touchscreen
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:28:42 -0500
> 
> Input: whitespace fixes in drivers/input/keyboard
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:28:29 -0500
> 
> Input: whitespace fixes in drivers/input/mouse
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Vojtech Pavlik <vojtech@suse.cz> Sun, 29 May 2005 12:28:14 -0500
> 
> Input: Fix a warning in hid-core.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Vojtech Pavlik <vojtech@suse.cz> Sun, 29 May 2005 12:28:00 -0500
> 
> Input: Make hid-core issue a SET_IDLE request before GET_REPORT, like
>        Windows does. This should make life easier for devices that were
>        tested with Windows only.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Hans-Christian Egtvedt <hc@mivu.no> Sun, 29 May 2005 12:27:45 -0500
> 
> Input: Add driver for ITM Touch USB touchscreens.
> 
> From: Hans-Christian Egtvedt <hc@mivu.no>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Richard Purdie <rpurdie@rpsys.net> Sun, 29 May 2005 12:27:06 -0500
> 
> Input: Corgi keyboard driver - correct two keys which are much more useful
>        as function keys instead of special keys.
> 
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Vojtech Pavlik <vojtech@suse.cz> Sun, 29 May 2005 12:26:50 -0500
> 
> Input: Fix a warning in evdev's 32-bit emulation code.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Juergen Kreileder <jk@blackdown.de> Sun, 29 May 2005 12:26:43 -0500
> 
> Input: Add support for 32-bit emulation on 64-bit platforms for evdev.
> 
> Signed-off-by: Juergen Kreileder <jk@blackdown.de>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Jeremy Fitzhardinge <jeremy@goop.org> Sun, 29 May 2005 12:26:31 -0500
> 
> Input: This patch implements compat_ioctl for joydev.
> 
>        I've tested it with a Logitech WingMan Rumblepad on an x86-64
>        machine, and on an ia32 machine to make sure I didn't break
>        anything.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Vojtech Pavlik <vojtech@suse.cz> Sun, 29 May 2005 12:25:43 -0500
> 
> Input: Kill Aureal Vortex 1/2 gameport driver. ALSA Aureal driver
>        offers the gameport part already.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Vojtech Pavlik <vojtech@suse.cz> Sun, 29 May 2005 12:25:33 -0500
> 
> Input: Crystal SoundFusion (cs461x) gameport support isn't needed
>        either, since ALSA handles it nicely.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> author Vojtech Pavlik <vojtech@suse.cz> Sun, 29 May 2005 12:25:01 -0500
> 
> Input: Probe PnP gameports first, ISA after that.
> 
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> --------------------------
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSKDDJS>; Sun, 3 Nov 2002 22:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264633AbSKDDJS>; Sun, 3 Nov 2002 22:09:18 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:55424 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S263326AbSKDDJQ>; Sun, 3 Nov 2002 22:09:16 -0500
Date: Mon, 4 Nov 2002 14:15:09 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>, gpm@lists.linux.it
Subject: 2.5.45 / touchpad no longer works right
Message-ID: <20021104031509.GC3088@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just did an upgrade from 2.4.19-ac1 to 2.5.45 so that I could start
testing the new kernel. All's more or less well (apart from a few
compile errors and an oops) except that my touchpad no longer appears to
work with gpm. It works fine as a 2 button ps2 mouse (-t ps2 or exps2)
but as a synps2 it now gives the following errors:

Nov  4 13:21:27 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** info [gpn.c(369)]: 
Nov  4 13:21:27 theirongiant /usr/local/gpm/sbin/gpm[2967]: Started gpm successfully. Entered daemon mode.
Nov  4 13:21:27 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** info [synaptics.c(2468)]: 
Nov  4 13:21:27 theirongiant /usr/local/gpm/sbin/gpm[2967]: PS/2 Touchpad sending additional READY, ID CODE. 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** err [synaptics.c(2474)]: 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: Sending reset command to PS/2 TouchPad failed: No ACK, got 08. 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** err [synaptics.c(2481)]: 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: Reseting PS/2 TouchPad failed: No READY, got 00. 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** err [synaptics.c(2484)]: 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: Reseting PS/2 TouchPad failed: Wrong ID, got 02. 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** err [synaptics.c(2338)]: 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: PS/2 device doesn't appear to be a synaptics touchpad 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** err [synaptics.c(2378)]: 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: PS/2 device doesn't appear to be a synaptics touchpad 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: *** info [synaptics.c(1895)]: 
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]:      Firmware version 0.0 
...
Nov  4 13:21:29 theirongiant /usr/local/gpm/sbin/gpm[2967]: Unrecognized Synaptic PS/2 Touchpad packet: 28 AA 55 FF 01 08
...

This is with gpm 1.20.1-cvs (rc1 on the tarball) and whilst using
/dev/psaux and /dev/input/mouse0.

I've had similar issues with early 2.4.x kernels, which is what
prevented me from going to them early on. Now it's happening again. :/

Any help would be appreciated as with this as it stands I need to go
back to 2.4.19-ac1 so that I can use the touchpad properly. Also, if
there's anything I can do to help debug, please holler.

Thanks.

Relevant bit of .config:

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=y
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTHXMah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTHXMah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:30:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15123 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263488AbTHXMaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:30:30 -0400
Date: Sun, 24 Aug 2003 13:30:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Bad serio/atkbd configuration possible (was: Re: Compilation errors in 2.6.0-test4, serial as modules)
Message-ID: <20030824133026.D16635@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <032c01c36a36$2335ea20$24ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <032c01c36a36$2335ea20$24ee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Aug 24, 2003 at 08:50:51PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 08:50:51PM +0900, Norman Diamond wrote:
> Sorry I cannot keep up with the list.  Questions or advice, personal mail
> please.

It's not serial, but serio.

What you seem to have below is an invalid configuration file.
CONFIG_KEYBOARD_ATKBD must not be "y" if CONFIG_SERIO is "m".

For some reason, the following doesn't seem to be working quite right:

config KEYBOARD_ATKBD
        tristate "AT keyboard support" if EMBEDDED || !X86
        default y
        depends on INPUT && INPUT_KEYBOARD && SERIO

> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=m
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=m
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=m
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=m
> CONFIG_MOUSE_SERIAL=m
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=m
> CONFIG_INPUT_UINPUT=m

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


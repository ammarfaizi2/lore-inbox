Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSGNIC1>; Sun, 14 Jul 2002 04:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSGNIC0>; Sun, 14 Jul 2002 04:02:26 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:50923 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315455AbSGNICY>;
	Sun, 14 Jul 2002 04:02:24 -0400
Date: Sun, 14 Jul 2002 10:05:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714100509.B25887@ucw.cz>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <20020713214801.GA276@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020713214801.GA276@wizard.com>; from tyketto@wizard.com on Sat, Jul 13, 2002 at 02:48:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 02:48:01PM -0700, A Guy Called Tyketto wrote:

>         I just gave this a try with 2.5.25-dj2, and I still don't have a 
> working keyboard. Mouse works fine; no response from the keyboard. revelant 
> parts of .config below:
> 
> CONFIG_INPUT=y
> CONFIG_INPUT_KEYBDEV=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_EVDEV=m
> # CONFIG_INPUT_EVBUG is not set
> CONFIG_GAMEPORT=m
> CONFIG_SOUND_GAMEPORT=m
> CONFIG_GAMEPORT_FM801=m
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_I8042_REG_BASE=60
> CONFIG_I8042_KBD_IRQ=1
> CONFIG_I8042_AUX_IRQ=12
> CONFIG_SERIO_SERPORT=m
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y

The .config is OK.

>         /proc/interrupts shows:
> 
>            CPU0       
>   0:     108187          XT-PIC  timer
>   2:          0          XT-PIC  cascade
>   4:        182          XT-PIC  serial
>   5:          1          XT-PIC  parport0
>   8:          1          XT-PIC  rtc
>  10:        530          XT-PIC  eth0
>  12:        830          XT-PIC  i8042
>  14:       3754          XT-PIC  ide0

Unfortunately this doesn't list interrupts, which happened, but are no
longer claimed by any driver - and the i8042 driver frees the interrupt
when it detects no device.

>         From the above part of .config, IRQ1 should be set for the keyboard, 
> while IRQ 12 for the AUX port. 12 is set, 1 is not. dmesg shows:
> 
> mice: PS/2 mouse device common for all mice
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: ImPS/2 Microsoft IntelliMouse on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12

So it detected both the KBD and AUX ports properly, but for some reason
it couldn't identify the attached keyboard.

Can you #define ATKBD_DEBUG in drivers/input/keyboard/atkbd.c? 
Then you'll see what happened in' dmesg'.

>         So I don't really know what is causing my keyboard (PS/2) to not work 
> with the new API. I also don't know how others are getting it to work.. any 
> insight?

Most likely you have a somewhat unusual keyboard - it may be responding
too slow perhaps, so that the driver times out - or doesn't support some
of the commands the driver expects to use.

Or the mouse kills the keyboard. This also can happen - they share
common resources. This would need more debugging then.

So, what's the keyboard, what's the mouse, and what's the mainboard
exactly? 

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbSJHLZK>; Tue, 8 Oct 2002 07:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbSJHLZK>; Tue, 8 Oct 2002 07:25:10 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:41872 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262087AbSJHLZI>;
	Tue, 8 Oct 2002 07:25:08 -0400
Date: Tue, 8 Oct 2002 13:27:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Dreher <dreher@math.tu-freiberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 input problems and sleeping functions
Message-ID: <20021008132726.B16894@ucw.cz>
References: <200210081015.MAA09863@delphin.mathe.tu-freiberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210081015.MAA09863@delphin.mathe.tu-freiberg.de>; from dreher@math.tu-freiberg.de on Tue, Oct 08, 2002 at 01:05:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 01:05:32PM +0200, Michael Dreher wrote:
> Hi all, 
> 
> with 2.5.41 I can't type the " | " anymore. If I type it, I get
> 
> atkbd.c: Unknown key (set 2, scancode 0x6a, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x6a, on isa0060/serio0) released.

Interesting. You can use 'setkeycode 6a 43' for an immediate fix, and
I'll fix the atkbd.c table in the next release.

> relevant part or dmesg (I hope):
> 
> register interface 'mouse' with class 'input
> mice: PS/2 mouse device common for all mice
> register interface 'event' with class 'input
> input: PS/2 Generic Mouse on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> Moreover, sometimes the usb mouse dies. Pulling it out and plugging it back
> gives me
> 
> Debug: sleeping function called from illegal context at 
> include/asm/semaphore.h:119
> Call Trace:
>  [<c0113a4d>] __might_sleep+0x54/0x5b
>  [<c02082af>] usb_hub_events+0x5f/0x29d
>  [<c020851d>] usb_hub_thread+0x30/0xce
>  [<c02084ed>] usb_hub_thread+0x0/0xce
>  [<c0112981>] default_wake_function+0x0/0x32
>  [<c0105461>] kernel_thread_helper+0x5/0xb

Bug in USB hub code.

-- 
Vojtech Pavlik
SuSE Labs

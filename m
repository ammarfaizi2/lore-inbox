Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSGROms>; Thu, 18 Jul 2002 10:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318119AbSGROms>; Thu, 18 Jul 2002 10:42:48 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:31433 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318118AbSGROml>;
	Thu, 18 Jul 2002 10:42:41 -0400
Date: Thu, 18 Jul 2002 16:45:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020718164536.A30363@ucw.cz>
References: <20020717101001.GE14581@tahoe.alcove-fr> <20020717140804.B12529@ucw.cz> <20020717132459.GF14581@tahoe.alcove-fr> <20020717154448.A19761@ucw.cz> <20020717135823.GG14581@tahoe.alcove-fr> <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr> <20020717172235.A20474@ucw.cz> <20020717153336.GK14581@tahoe.alcove-fr> <20020718144130.GB2326@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020718144130.GB2326@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Thu, Jul 18, 2002 at 04:41:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 04:41:30PM +0200, Stelian Pop wrote:
> On Wed, Jul 17, 2002 at 05:33:36PM +0200, Stelian Pop wrote:
> 
> > The i8042 version used is the one you send me, plus the #if 0 surrounding
> > the aux probe code.
> > 
> > Result: keyboard works, mouse still doesn't.
> [...]
> 
> Ok, I've hacked a bit on the input drivers (trying to look at the
> differences between the pc_keyb.c and the new initialisation sequences),
> with some limited success.
> 
> What I found out is that the mouse is not responding to any of
> the commands in psmouse.c:psmouse_probe. However, if I comment out
> the 'return -1' statements from this function, the mouse will
> be recognised as a default PS/2 mouse. 
> 
> Later, in psmouse_initialise, the PSMOUSE_CMD_ENABLE will fail too
> (no response from the mouse). But since the error is not propagated
> to serio the device remains registered.
> 
> And later, the mouse will get enabled somehow and will function
> perfectly. I didn't succed in finding out what exactly enables it,
> even if I strongly suspect some interraction between the keyboard
> enable and aux port enable... 
> 
> Any further idea ?

Yes. Can you try, with i8042 debugging enabled, after the kernel boots,
moving the mouse? I suspect the data will appear in the log ...

> 
> What I also did, maybe you'll find this interesting, is recording 
> the events sent by the pc_keyb.c driver to the i8042 port (by tracing
> the inb/outb in include/asm-i386/keyboard.h):
> 
> kbd_read_status: 1c
> kbd_write_command: a7
> kbd_read_status: 1e
> kbd_read_status: 1c
> kbd_write_command: 60
> kbd_read_status: 1e
> kbd_read_status: 1c
> kbd_write_output: 65
> kbd_read_status: 14
> kbd_write_output: ed
> kbd_read_status: 15
> kbd_read_input: fa
> kbd_read_status: 14
> kbd_read_status: 14
> kbd_write_output: 00
> kbd_read_status: 15
> kbd_read_input: fa
> kbd_read_status: 14
> kbd_read_status: 14
> kbd_write_command: a8
> kbd_read_status: 1c
> kbd_write_command: d4
> kbd_read_status: 1e
> kbd_read_status: 1c
> kbd_write_output: f4
> kbd_read_status: 14
> kbd_read_status: 14
> kbd_write_command: 60
> kbd_read_status: 1e
> kbd_read_status: 3d
> kbd_read_input: fa
> kbd_read_status: 3c
> kbd_write_output: 47
> kbd_read_status: 34
> kbd_write_output: f4
> kbd_read_status: 15
> kbd_read_input: fa
> kbd_read_status: 14
> kbd_read_status: 14
> kbd_write_command: d4
> kbd_read_status: 1e
> kbd_read_status: 1c
> kbd_write_output: ffffffff
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: aa
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff4
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff2
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff3
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: ffffffc8
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff3
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: 64
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff3
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: 50
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff2
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: ffffffff
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: aa
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff4
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: fffffff2
> kbd_read_status: 35
> kbd_read_input: fa
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: 60
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: 65
> kbd_read_status: 34
> kbd_write_command: a7
> kbd_read_status: 3c
> kbd_write_command: a8
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_command: d4
> kbd_read_status: 3e
> kbd_read_status: 3c
> kbd_write_output: f4
> kbd_read_status: 34
> kbd_read_status: 34
> kbd_write_command: 60
> kbd_read_status: 3e
> kbd_read_status: 3d
> kbd_read_input: fa
> kbd_read_status: 3c
> kbd_write_output: 47
> kbd_read_status: 34
> kbd_write_output: f4
> kbd_read_status: 15
> kbd_read_input: fa
> kbd_read_status: 14
> kbd_read_status: 15
> kbd_read_input: 22
> kbd_read_status: 14
> kbd_read_status: 15
> kbd_read_input: a2
> kbd_read_status: 14
> kbd_read_status: 15
> kbd_read_input: 22
> kbd_read_status: 14
> kbd_read_status: 15
> kbd_read_input: a2
> kbd_read_status: 14
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 02
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 01
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 01
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 03
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 05
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 01
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 06
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 05
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 09
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 09
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 28
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: ff
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 09
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 0a
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 0a
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 28
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 06
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: ff
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 05
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 04
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 01
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 05
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 04
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 01
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 08
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 01
> kbd_read_status: 34
> kbd_read_status: 35
> kbd_read_input: 00
> kbd_read_status: 34
> Stelian.
> -- 
> Stelian Pop <stelian.pop@fr.alcove.com>
> Alcove - http://www.alcove.com

-- 
Vojtech Pavlik
SuSE Labs

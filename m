Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSGQPTp>; Wed, 17 Jul 2002 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSGQPTp>; Wed, 17 Jul 2002 11:19:45 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:40625 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314596AbSGQPTo>;
	Wed, 17 Jul 2002 11:19:44 -0400
Date: Wed, 17 Jul 2002 17:22:35 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020717172235.A20474@ucw.cz>
References: <20020716143415.GO7955@tahoe.alcove-fr> <20020717095618.GD14581@tahoe.alcove-fr> <20020717120135.A12452@ucw.cz> <20020717101001.GE14581@tahoe.alcove-fr> <20020717140804.B12529@ucw.cz> <20020717132459.GF14581@tahoe.alcove-fr> <20020717154448.A19761@ucw.cz> <20020717135823.GG14581@tahoe.alcove-fr> <20020717162904.B19935@ucw.cz> <20020717145523.GJ14581@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020717145523.GJ14581@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Wed, Jul 17, 2002 at 04:55:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 04:55:23PM +0200, Stelian Pop wrote:
> On Wed, Jul 17, 2002 at 04:29:04PM +0200, Vojtech Pavlik wrote:
> 
> > > I should enhance however that it works with the old pc_keyb driver.
> > 
> > Yes, I know. That's why I suggested skipping the detection, as the
> > pc_keyb driver doesn't do that.
> > 
> > Try this:
> > 
> > --- i8042.c.old	Wed Jul 17 16:05:57 2002
> > +++ i8042.c	Wed Jul 17 16:27:54 2002
> > @@ -571,6 +571,8 @@
> >  
> >  	i8042_flush();
> >  
> > +#if 0
> [...]
> 
> Argh, with this patch, the mouse still doesn't work but I also
> lose the keyboard (but keyboard press/release events are
> however present in the logs...)!
> 
> [...]
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>  hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
>  hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
> mice: PS/2 mouse device common for all mice
> i8042.c: fa <- i8042 (flush, kbd) [0]
> i8042.c: 20 -> i8042 (command) [0]
> i8042.c: 47 <- i8042 (return) [0]
> i8042.c: 60 -> i8042 (command) [1]
> i8042.c: 56 -> i8042 (parameter) [1]
> i8042.c: a8 -> i8042 (command) [1]
> i8042.c: 60 -> i8042 (command) [1]
> i8042.c: 56 -> i8042 (parameter) [1]
> serio: i8042 AUX port at 0x60,0x64 irq 12
> i8042.c: 60 -> i8042 (command) [1]
> i8042.c: 46 -> i8042 (parameter) [1]
> serio: i8042 KBD port at 0x60,0x64 irq 1
> NET4: Linux TCP/IP 1.0 for NET4.0
> [...]
> i8042.c: 39 <- i8042 (interrupt, kbd, 0) [96160]
> i8042.c: b9 <- i8042 (interrupt, kbd, 0) [96260]
> i8042.c: 39 <- i8042 (interrupt, kbd, 0) [97310]
> i8042.c: b9 <- i8042 (interrupt, kbd, 0) [97410]
> i8042.c: 39 <- i8042 (interrupt, kbd, 0) [102010]
> i8042.c: b9 <- i8042 (interrupt, kbd, 0) [102110]

Are you sure you didn't change the config? Because this really looks
like if noone is actually even trying to probe. Which is quite
impossible, unless CONFIG_KEYBOARD_ATKBD and CONFIG_MOUSE_PS2 are
disabled.

-- 
Vojtech Pavlik
SuSE Labs

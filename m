Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267785AbTAXQzD>; Fri, 24 Jan 2003 11:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267784AbTAXQzC>; Fri, 24 Jan 2003 11:55:02 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:32129 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267785AbTAXQzB>; Fri, 24 Jan 2003 11:55:01 -0500
Message-ID: <3E3171FC.FE9139CE@cinet.co.jp>
Date: Sat, 25 Jan 2003 02:03:56 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.59-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Hiroshi Miura <miura@da-cha.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
References: <20030124031453.0A29F11775F@triton2> <20030124065741.B19571@ucw.cz>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix atkbd_set2_keycode table in atkbd.c for jp106 keyboard.

Vojtech Pavlik wrote:
> 
> On Fri, Jan 24, 2003 at 12:14:53PM +0900, Hiroshi Miura wrote:
> 
> > After re-writting a console layer, a japanese keyboard is not supported (or degraded).
> > This patch fixs it.
> 
> This patch doesn't work, all normal keyboards - not just japanese ones have id of 0xab02.
I agree this point. It's difficult to detect jp106 keyboard automatically.
Many venders use common internal circuits with us keyborad.

> > A USB keyboard driver may have same problem, but I don't have one.
> >
> > --- linux-2.5.59/drivers/input/keyboard/atkbd.c       2002-12-03 07:59:41.000000000 +0900
> > +++ edited/linux-2.5.59/drivers/input/keyboard/atkbd.c        2003-01-24 09:13:11.000000000 +0900
> > @@ -309,6 +309,12 @@
> >       if (atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_GSCANSET))
> >               atkbd->oldset = 2;
> >
> > +     if (atkbd->id == 0xab02) {
> > +             printk("atkbd: jp109(106) keyboard found\n");
> > +             param[0] = atkbd_set;
> > +             atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET);
> > +             return 5;
> > +     }
> >  /*
> >   * For known special keyboards we can go ahead and set the correct set.
> >   * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
> > @@ -531,6 +537,12 @@
> >       else
> >               memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
> >
> > +     if (atkbd->set == 5) {
> > +             atkbd->keycode[0x13] = 0x70;  /* Hiragana/Katakana */
> > +             atkbd->keycode[0x6a] = 0x7c;  /* Yen, pipe 124*/
I think he catches good point. Kernel 2.0-2.4 use keycode 124 (0x7c) for scancode 0x6a.
2.5 uses keycode 183. This breaks jp106 keymaps. We cannot type '\' and '|' from jp106
keyboard on 2.5 kernel.
I believe there is no impact by changing keycode 183 to 124.

> >
> > --
> > Hiroshi Miura  --- http://www.da-cha.org/
> > NTTDATA Corp. Marketing & Business Strategy Planning Dept. --- miurahr@nttdata.co.jp
> 
> --
> Vojtech Pavlik
> SuSE Labs

Regard,
Osamu Tomita

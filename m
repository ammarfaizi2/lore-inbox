Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbSJWOWs>; Wed, 23 Oct 2002 10:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSJWOWr>; Wed, 23 Oct 2002 10:22:47 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:51016 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265024AbSJWOWV>; Wed, 23 Oct 2002 10:22:21 -0400
Message-ID: <3DB6B20B.B02BE681@cinet.co.jp>
Date: Wed, 23 Oct 2002 23:28:27 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: "'LKML '" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (13/26) key board
References: <E6D19EE98F00AB4DB465A44FCF3FA46903A30A@ns.cinet.co.jp> <20021023112628.F28139@ucw.cz>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Wed, Oct 23, 2002 at 02:09:12PM +0900, Osamu Tomita wrote:
> > Thanks for comments.
> >
> > -----Original Message-----
> > From: Vojtech Pavlik
> > To: Osamu Tomita
> > Cc: LKML; Linus Torvalds
> > Sent: 2002/10/22 19:43
> > Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (13/26)
> > keyboard
> >
> > > I won't merge this unless it's cleaned up, kana support either made
> > > generic or put into keymaps, and the below problems resolved.
> >
> > > ... no way I'll add another default keymap when now we have unified
> > > keycodes. And we do support japanese keycodes/keymappings.
> > Japanese keycodes/keymapping support! We are very happy. IMHO To realize
> > this, emulations include shift-state modifier are needed??
> > Please point me where is source code, and we don't touch defkeymaps.
> 
> Tell me what exactly you need and if it cannot be done, I'll try to
> implement it in a generic way.
Thanks! Our needs are very simple. We want to get identical letter(keycode?)
with key top letter. For example, get "{" by shift + "[", "+" by shift + ";".
hardware of jp106 keyboard is similar with us keyboard, but key top letters
have differeces. Also PC-9800 keyboard has similar key top letter, according 
to JIS(Japanese Industrial Standards).
So I always load keymap when use jp106 keyboard.
 
> > >> diff -urN linux/drivers/char/keyboard.c
> > > Either there is a need for a special kanji mode changing function for
> > > japanese keyboards or there is not. Either way, it isn't PC-98 specific.
> 
> > I think it's for emergency(or rescue) purpose. For example, system cannot
> > boot due to illegal kanji named file, input kenji to select one and change
> > it. We plan direct character code input. In kanji-mode, do convert from
> > hex numeric input to kanji. But not implemented yet.
> 
> No problem, but this should be handled by a keymap (if possible). If
> not, the keymap code needs to be extended to be able to handle this.
I'll try, But I cannot do soon.

> > >> +#ifndef CONFIG_PC9800
> > >>  #define KBD_DEFLEDS 0
> > >> +#else
> > >> +#define KBD_DEFLEDS (1 << VC_NUMLOCK)
> > >> +#endif
> > > You want numlock on by default?
(snip)
> > >>  static void fn_scroll_forw(struct vc_data *vc)
> > >>  {
> > >> +#ifndef CONFIG_PC9800
> > >>    scrollfront(0);
> > >> +#else
> > >> +  scrollfront(3);
> > >> +#endif
> > >>  }
> > > Huh?
> > Due to our implementation of console driver. For old PC-9800, we use only
> > video ram. If don't, scrolling is _very_ slow. So our console can scroll
> > less than half lines of screen. If call with 0, screen doesn't scroll.
> 
> I see. However, I believe this should be handled in your implementation
> of the scrolling, and not affecting keyboard.c code.
I agree. This should be in VT module.

> > >> diff -urN linux/include/linux/logibusmouse.h
> > linux98/include/linux/logibusmouse.h
> > >> --- linux/include/linux/logibusmouse.h     Tue Aug  3 01:54:29 1999
> > >> +++ linux98/include/linux/logibusmouse.h   Fri Aug 17 22:15:13 2001
> > > Hmm, this file isn't used at all in 2.5. Why patching it?
> > IMHO Those (pc_keyb.h too) are remaining to compile user mode application.
> > I think it's a very rare, but ....
> 
> pc_keyb.h maybe. logibusmouse.h definitely not, no application is
> supposed to use those defines.
I see. I remove it from patch.

Regards
Osamu Tomita

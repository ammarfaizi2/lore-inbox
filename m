Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUE3KZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUE3KZp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUE3KZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:25:44 -0400
Received: from main.gmane.org ([80.91.224.249]:65477 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262006AbUE3KU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:20:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sun, 30 May 2004 12:20:32 +0200
Message-ID: <MPG.1b23d2eba99fff039896a6@news.gmane.org>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-205-140.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a couple of answers on the things I still have doubts on. Note 
that I'm using the 2.6.5 as reference. If anything has 
thoroughly changed in 2.6.6 or 7-rc1, just let me know.

Vojtech Pavlik wrote:
> On Sat, May 29, 2004 at 05:12:31PM +0200, Giuseppe Bilotta wrote:
> > Backward compatibility, or support for the functionality not 
> > yet supported by the current model at the current development 
> > level. For example (see other post), a standard set of keycodes 
> > for multimedia keys on multimedia keyboards, with as much a 
> > widespread support for such things as X currently provides.

[snip]

> The support is present in the kernel. You can use setkeycode to load that
> table. Only X won't use it.

[snip]

> The emulated rawmode (which is needed for USB anyway) is supposed to
> work well enough. It supports multimedia keys (and generates
> Microsoft-compatible scancodes for most of them), and can be configured
> to work with any keyboard using setkeycode.

By looking at the header files, or into the documentation, I 
have problems finding what keycode is supposed to be assigned 
to have a key act as the corresponding "Microsoft-compatible" 
keyboard.

My thoughts are that, even without an event driver interface 
for X, it is possible to use the present model provided that 
the emulated rawmode provides the widest possible set of 
features provided by the union of 'all' available keyboards. 
With a (possibly documented) set of keycodes that needs to be 
assigned to get this or that function.

With my limited knowledge (i.e. by what I see looking at the 
source files and include headers) I see the kernel lacking in 
two fields:

* X allows for the shift, ctrl, alt, meta, super, hyper (left 
and right) modifiers. In the kernel headers I only see 
references to shift ctrl and alt. (Actually X also has a wild 
bunch of other modifiers for group shift, composition etc.)

* No (documented) set of keycodes to assign to get mapped to 
multimedia/internet keys (volume up/down, play, stop, next, 
prev, email, internet, blah blah blah)

If we want to go the 'full emulation' way, such things must be 
set in a standard, documented way. Which is not the case yet, 
unless I'm just going blind.

> > Stick to 2.4.x or hand-patching the raw mode emulation 
> > table and recompiling are the only sane options to keep full 
> > functionality *at the moment*.
> 
> No. The sane option at the moment (which isn't perfect, I admit), is to
> use setkeycode to make the kernel understand the multimedia keys (you
> can verify it does using evtest), and then to configure X to understand
> the kernel-generated scancodes. That way you get full functionality
> without any hacks.

And I noticed there was this excellent "keyfuzz" utility 
recently released which is aimed at providing exactly this 
feauture. But it doesn't work as expected. Not yet. Because 
keycodes have to be assigned by trial and error and trying to 
re-do assignments causes strange effects since scancodes start 
shifting as well in a very strange way. Which is why at a 
certain point (over a month now) I just gave up and patched 
atkbd.c directly to have it work with my keyboard.

> > Which is not really that nice a 
> > set of options, if you ask me. Especially considering the, uhm, 
> > speed with which X and friends are fixed.
> 
> That's the main problem, actually. Were it a little bit less slow, we'd
> have X using the event interface by now and all the discussion would be
> moot.

Of course. But X is what it is and we're stuck in this 
situation.

> > I do agree with you that it should be entirely up to the kernel 
> > to provide this kind of HAL. But since
> > 
> > 1. the kernel still doesn't fully provide it anyway (see 
> > multimedia keys)
> 
> It understands MS-compatible multimedia keys by default. For
> incompatible scancode sets, you need to use setkeycode. Setkeycode
> works.

Setkeycodes works by trial and error. MS-compatible multimedia 
keys scancodes are not exactly well-documented, not anywhere I 
can see. Also, does MS-compatible mutlimedia scancodes emulate 
the whole set of keys some ridiculous humongous keys provide?

> > When the kernel will provide a complete enough HAL, we can 
> > start talking about 'not needing a real raw mode'. *In the mean 
> > time*, real raw mode *is* needed.
> 
> As Andries convinced me, it'll always be needed, if only for debugging
> and setting up the translation tables easily (without checking the
> kernel log).
> 
> I'll buy some food and start hacking at it today evening.

Thank you very much :)

> > And differently from you, I do not think that *forcing* people 
> > to change to the new system by not providing any form of 
> > transition capability *is* the way to go.
> 
> Note that I did provide a transition capability, although it isn't a
> perfect one. If I didn't, there would be _no_ raw mode and X wouldn't
> work at all, which might have been better. ;)

It would have been interesting to see the reactions :)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)


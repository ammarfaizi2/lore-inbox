Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266089AbUANN7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266015AbUANN7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:59:08 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:13030 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266089AbUANN7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:59:04 -0500
Date: Wed, 14 Jan 2004 14:59:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olaf Hering <olh@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: bad scancode for USB keyboard
Message-ID: <20040114135902.GA28454@ucw.cz>
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net> <3FFB6E9E.6040500@develer.com> <20040107085104.GA14771@ucw.cz> <20040111163050.GA28671@zombie.inka.de> <20040111184445.GA30711@ucw.cz> <20040114135433.GA26587@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114135433.GA26587@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 02:54:33PM +0100, Olaf Hering wrote:
>  On Sun, Jan 11, Vojtech Pavlik wrote:
> 
> > On Sun, Jan 11, 2004 at 05:30:50PM +0100, Eduard Bloch wrote:
> > 
> > > #include <hallo.h>
> > > * Vojtech Pavlik [Wed, Jan 07 2004, 09:51:04AM]:
> > > 
> > > > The reason is that this key is not the ordinary backslash-bar key, it's
> > > > the so-called 103rd key on some european keyboards. It generates a
> > > > different scancode.
> > > 
> > > Fine, but there are a lot of USB keyboard that _work_ that way, where
> > > the "103rd" key is really positioned as the one and the only one '# key.
> > > And the current stable X release does NOT know about the new scancode.
> > > You realize that you intentionaly broke compatibility within a stable
> > > kernel release?
> > 
> > Good point. And I'm suffering the consequences already. Up to the
> > change, I didn't know that so many keyboards are actually using this
> > key, so I supposed it'll be a rather low-impact change. I stand
> > corrected now.
> > 
> > Linus, Andrew, please apply this fix:
> > 
> > ChangeSet@1.1511, 2004-01-11 19:41:05+01:00, vojtech@suse.cz
> >   input: Fix emulation of PrintScreen key and 103rd Euro key for XFree86.
> 
> I tried the 2.6.1-mm2 tree and changed the 84 to 43, but that doesnt
> help my USB keyboard. Showkey does still show 84.
> 
> static unsigned short x86_keycodes[256] =
> ...
>          80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> ...
> 
> Maybe adbhid needs a similar tweak? I could not find the place, yet.

showkey _will_ still show 84, because the keycode still is 84. Only the
rawmode emulation was fixed. I really don't want to make the keycode 43
because the 103rd key it is a different key than backslash. 

So on console you still need to change your keymap. I could change the
keycode to be something else than 84, but that'd not help much. I'm
currently toying with the idea of detecting a keymap that expects the
key to generate code 43 and do a workaround for it ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

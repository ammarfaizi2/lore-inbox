Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132863AbRDPGbG>; Mon, 16 Apr 2001 02:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbRDPGa5>; Mon, 16 Apr 2001 02:30:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:862 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132858AbRDPGaj>; Mon, 16 Apr 2001 02:30:39 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
In-Reply-To: <20010413150219.A440@napalm.go.cz> <20010414002120.A15596@win.tue.nl> <9b83i5$ha7$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Apr 2001 00:29:11 -0600
In-Reply-To: "H. Peter Anvin"'s message of "13 Apr 2001 16:53:41 -0700"
Message-ID: <m1itk5tl1k.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> In article <20010414002120.A15596@win.tue.nl> of
> linux.dev.kernel, you write:
> > On Fri, Apr 13, 2001 at 03:02:19PM +0200, Jan Dvorak wrote:
> > 
> > > i recently met with a new (Unisys) keyboard, which have (among 'normal'
> > > windows keys) 3 more keys on top of arrows, labeled by pictures as
> > > halfsun, halfmoon, and power switch. Following patch adds 'support' for them
> 
> > 
> > > +#define E0_MSPOWER	128
> > > +#define E0_MSHALFMOON	129
> > > +#define E0_MSHALFSUN	130
> > 
> > No, these codes cannot be larger than 127 today.
> > You can use the utility setkeycodes to assign keycodes to these keys.
> > 
> > [One of the things for 2.5 is 15- or 31-bit keycodes.
> > The 7-bits we have today do no longer suffice. I have a 132-key keyboard.]

If we can try to keycodes in 8-bits it would be nice.  The difficulty
is that X cannot handle more than 8-bits without telling it you have
multiple keyboards.  The keycode (at least in X) is exported to
X applications.  This is certainly something to coordinate with the
XFree folks about.  If you really need more then 8-bits. 

> By the way, it's for things like this that I suggested using a keycode
> which can be algorithmically mapped from scan codes once we go to a
> larger keycode space.  For example, if your key generates E0 63, it
> would *always* have keycode 0x00E3 (227).  For PC keyboards, I believe
> the following mapping algorithm should work onto a 15-bit keycode
> space (all numbers in hex):
> 
> 	xx	   -> 00xx
> 	E0 xx	   -> 00xx | 0080
> 	E1 xx yy   -> yyxx
> 
> (I can't remember which one of the E1 bytes that has the make/break
> bit, it should obviously go at the top.)
> 
> This assumes that there isn't a null byte form of E1, in which case it
> really can't be made to fit, but I don't think so.
> 
> This means you don't have to configure two levels (scancodes ->
> keycodes and keycodes -> keymap); since currently the keycodes are
> keyboard-specific anyway there is no benefit to the two levels.

Hmm.  I'd love to see how a mapping that takes everything into account
works.  In a classic pc compatible keyboard E1 is only used for the
Pause key.  And you need to special case Print-Screen/SysRq
Pause/Break, anyway to collapse then into one keycode to really get
your keycodes correct.   So I'm not certain that after special case
the two totally hosed keys if you need to handle more than the E0
prefix in which case you really only need one more bit.

Eric

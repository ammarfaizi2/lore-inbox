Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268156AbTAKWWN>; Sat, 11 Jan 2003 17:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268159AbTAKWWN>; Sat, 11 Jan 2003 17:22:13 -0500
Received: from dp.samba.org ([66.70.73.150]:32391 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268156AbTAKWWM>;
	Sat, 11 Jan 2003 17:22:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Miles Bader <miles@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty 
In-reply-to: Your message of "Fri, 10 Jan 2003 21:36:02 -0800."
             <Pine.LNX.4.44.0301102134150.9532-100000@home.transmeta.com> 
Date: Sun, 12 Jan 2003 00:42:55 +1100
Message-Id: <20030111223100.6C9CD2C055@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301102134150.9532-100000@home.transmeta.com> you wri
te:
> 
> On Sat, 11 Jan 2003, Rusty Russell wrote:
> > 
> > Just in case someone names a variable over 2000 chars, and uses it as
> > an old-style module parameter?
> 
> No. Just because variable-sized arrays aren't C, and generate crappy code.
> 
> >  	for (i = 0; i < num; i++) {
> > +		char sym_name[strlen(obsparm[i].name)
> > +			     + sizeof(MODULE_SYMBOL_PREFIX)];
> 
> It's still there.

OK, *please* explain to me in little words so I can understand.

Variable-sized arrays are C, as of C99.  They've been a GNU extension
forever.

While gcc 2.95.4 generates fairly horrible code, gcc 3.0 does better
(the two compilers I have on my laptop).

Both generate correct code.

Speed is certainly of absolutely no importance here.

Changing it to do a kmalloc every time around the loop is complex,
inefficient, unneccessary, and introduces another failure path.

In summary, I can't see any reason why the clearest, simplest code
should be avoided.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

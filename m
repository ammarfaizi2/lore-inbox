Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318860AbSHRGOJ>; Sun, 18 Aug 2002 02:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318861AbSHRGOI>; Sun, 18 Aug 2002 02:14:08 -0400
Received: from waste.org ([209.173.204.2]:59366 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318860AbSHRGOI>;
	Sun, 18 Aug 2002 02:14:08 -0400
Date: Sun, 18 Aug 2002 01:18:02 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Dmitri <dmitri@users.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818061802.GP21643@waste.org>
References: <20020818044242.GI21643@waste.org> <Pine.LNX.4.44.0208172151440.1829-100000@home.transmeta.com> <20020818050549.GT30425@usb.networkfab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818050549.GT30425@usb.networkfab.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 10:05:49PM -0700, Dmitri wrote:
> 
> Wouldn't it be much easier to ask -very few- people (GnuPG/SSL/SSH teams
> primarily)  to use /dev/super-reliable-mathematically-proven-random if
> available, instead of asking much larger crowd to hack their code? 

Most people (including OpenSSH!) are already using /dev/urandom where
appropriate.

If you care about the difference between /dev/random and /dev/urandom,
then you ought to care about the difference _actually being there_. If
your entropy estimates are not conservative, then your system will
leak entropy faster than it takes it in and then /dev/random and
/dev/urandom will by identical _by definition_.

> This will be backward compatible, and at the same time offers a much
> better randomness for those who care about it. Myself, I read
> 128-bit session keys for multiple, not-so-secure, short connections
> from /dev/random and it would be sad if it runs out of data.

Why would that be sad? It's at least billions of times easier to break
a 128-bit key than to guess the internal state of /dev/urandom, even
if the system has no entropy sources.

> Also, /dev/random may take data from /dev/super-...random until it sucks 
> it dry, and then switches to less secure sources. This will guarantee that 
> the enthropy of readings is -not worse than-, and for moderate requests is 
> much better.

Simple enough:

mv /dev/random /dev/super-random
ln -s /dev/urandom /dev/random

Backward compatible and everything.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

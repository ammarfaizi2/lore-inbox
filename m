Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSKVGGS>; Fri, 22 Nov 2002 01:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSKVGGR>; Fri, 22 Nov 2002 01:06:17 -0500
Received: from auto-matic.ca ([216.209.85.42]:29195 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265523AbSKVGGR>;
	Fri, 22 Nov 2002 01:06:17 -0500
Date: Fri, 22 Nov 2002 01:19:55 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
       David McIlwraith <quack@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
Message-ID: <20021122061955.GA11151@mark.mielke.cc>
References: <1037875005.1863.0.camel@localhost.localdomain> <Pine.LNX.4.10.10211210503090.3892-100000@master.linux-ide.org> <20021121170224.GB5315@mark.mielke.cc> <3DDD1611.9010003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD1611.9010003@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 12:21:21PM -0500, Jeff Garzik wrote:
> Mark Mielke wrote:
> >   #ifdef __GNUC__
> >   #  define INLINE extern inline
> >   #else
> >   #  define INLINE inline
> >   #endif
> [...]
> Please review prior posts in this thread, notably from Andrew Morton and 
> Cort Dougan.  They describe a much better method of doing this.
> It still doesn't handle macros, though they are much less of a worry 
> since Linux kernel emphasizes inlines over macros.

I just scanned it over and it isn't exactly the same as what I suggested.

Re-stating for clarity: Header files should use 'extern inline'
('inline' for C99) to declare inline functions in "GPL-mode" and
'extern' (or no qualifer) should be used to declare only the prototype
in "non-GPL-mode". The benefit of this is that GPL code continues to
work as is with no speed degradation, but non-GPL source code will not
require GPL code in the object code.

Converting 'extern inline' to 'static inline' doesn't accomplish very much,
except to force referenced code to be inlined into each object code. This
is the opposite effect of 'ensure that no GPL code is compiled into a
non-GPL object file'.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


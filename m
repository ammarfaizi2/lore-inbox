Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSKVUJ6>; Fri, 22 Nov 2002 15:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKVUJ6>; Fri, 22 Nov 2002 15:09:58 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:2233 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S265513AbSKVUJ5>;
	Fri, 22 Nov 2002 15:09:57 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 22 Nov 2002 13:13:51 -0700
To: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
Message-ID: <20021122131351.C30808@duath.fsmlabs.com>
References: <20021122162312.32ff4bd3.sfr@canb.auug.org.au> <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com> <20021122115454.A481@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021122115454.A481@work.bitmover.com>; from lm@bitmover.com on Fri, Nov 22, 2002 at 11:54:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"IMHO"?  Larry, you're never humble about your opinions :)

} IMHO, the thing that the early Unix systems did wrong was to not have 
} u8, u16, u32, etc as basic ctypes in sys/types.h.  And C should have 
} had a way to fake it if they weren't native.
} 
} Anyone who has ported a networking stack or worked on driver knows exactly
} what I'm talking about.
} 
} And while I'm whining, 
} 
} 	assert(strlen(any typedef) < 8));

Plan9 takes it a step further and tackles the char/8-byte issue.  A
printable character is a 16-byte entity - a rune - while char is an 8-byte
quantity.  Doing everything in UNICODE forced the issue, I think.

Even better, everything was designed to run with different byte-ordering
schemes so:

ulong
getlong(void)
{
	ulong l;

	l = (getchar()&0xFF)<<24;
	|= (getchar()&0xFF)<<16;
	l |= (getchar()&0xFF)<<8;
	l |= (getchar()&0xFF)<<0;
	return l;
}

always works correctly.  They even ripped out the darn c-preprocessor and
just made a smarter optimization compiler.

Improvements in C without ending up with something like C# or C++.  Can't
beat that with a stick.

Ah, yes... the streets are paved with gold in the land of Plan9.

} I like my stack variable declarations to line up.  I despise some_long_name_t
} typedefs with a passion.

There is a special kind of mind that allows people to follow 5 levels worth
of typedef to struct including stuct with typedefs in them.  It involves
having a very unhealthy outlook on the world.

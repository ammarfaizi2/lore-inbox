Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbSLDQqS>; Wed, 4 Dec 2002 11:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbSLDQqS>; Wed, 4 Dec 2002 11:46:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46350 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266975AbSLDQqR>; Wed, 4 Dec 2002 11:46:17 -0500
Date: Wed, 4 Dec 2002 08:54:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0212040843160.1960-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, Stephen Rothwell wrote:
> 
> To use this,an architecture must create asm/compat.h and provide typedefs
> for (currently) compat_time_t, compat_suseconds_t, struct compat_timespec.

Ok, this looks fine to me. At this point my only issues are purely
cosmetic, namely that "suseconds" thing made me go "wtf?". I have _never_
actually seen it used, it's one of those stupid typedefs that have no
point to them.

Since the only use of "suseconds" is in the "compat_timeval" definition,
and since you already have a "compat_timespec", my reaction is to ask why
we don't just make "compat_timeval" be the arch-supplied typedef, and drop
that strange "suseconds" thing entirely?

That avoids a very awkward name, _and_ it looks more natural to pair
compat_timeval and compat_timespec anyway.

(Yeah, I know we use suseconds_t in the "real" timeval declaration, and I 
think that's strange too.)

I'll do that change by hand, and apply this to get the ball rolling, ok?

			Linus


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291853AbSBHVRi>; Fri, 8 Feb 2002 16:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291839AbSBHVQn>; Fri, 8 Feb 2002 16:16:43 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10231
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291846AbSBHVQY>; Fri, 8 Feb 2002 16:16:24 -0500
Date: Fri, 8 Feb 2002 13:16:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020208211628.GC343@mis-mike-wstn>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202081328060.1095-100000@home.transmeta.com> <3C642F52.ABD14619@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C642F52.ABD14619@mandrakesoft.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 03:04:34PM -0500, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > 
> > On Fri, 8 Feb 2002, Ingo Molnar wrote:
> > >
> > > and regarding the reintroduction of BKL, *please* do not just use a global
> > > locks around such pieces of code, lock bouncing sucks on SMP, even if
> > > there is no overhead.
> > 
> > I'd suggest not having a lock at all, but instead add two functions: one
> > to read a 64-bit value atomically, the other to write it atomically (and
> > they'd be atomic only wrt each other, no memory barriers etc implied).
> > 
> > On 64-bit architectures that's just a direct dereference, and even on x86
> > it's just a "cmpxchg8b".
> 
> Are there architectures out there that absolutely must implement this
> with a spinlock?  Your suggested API of functions to read/write 64-bit
> values atomically would work for such a case, but still I am just
> curious.
> 

SMP 486s would need that (if there is such a beast).  What point does x86
get the 64 bit instructions?  If after 586, then it would definately need a
spinlock or somesuch in those functions.

Mike

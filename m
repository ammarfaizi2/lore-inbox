Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281895AbRKUOwv>; Wed, 21 Nov 2001 09:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKUOwl>; Wed, 21 Nov 2001 09:52:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3437 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281434AbRKUOwc>; Wed, 21 Nov 2001 09:52:32 -0500
To: root@chaos.analogic.com
Cc: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Nov 2001 07:33:31 -0700
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
Message-ID: <m17ksk19dw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Wed, 21 Nov 2001, Jan Hudec wrote:
> 
> > > >     *a++ = byte_rev[*a]
> > > It looks perferctly okay to me. Anyway, whenever would you listen to a
> > > C++ book talking about good C coding :p
> > 
> 
> It's simple. If any object is modified twice without an intervening
> sequence point, the results are undefined. The sequence-point in
> 
> 	*a++ = byte_rev[*a];
> 
> ... is the ';'.
> 
> So, we look at 'a' and see if it's modified twice. It isn't. It
> gets modified once with '++'. Now we look at the object to which
> 'a' points. Is it modified twice? No, it's read once in [*a], and
> written once in "*a++ =".
> 
> So, it's perfectly good code with a well defined behavior as far as
> 'C' is concerned. 

Nope.  In particular it isn't defined if [*a] is evaluated before
or after a++ is evaluated.  

> I think it is ugly, however, the writer probably
> thought it was beautiful. If somebody went around and fixed all
> the ugly code, it would still be ugly in someone else's eyes.

True, but not significant.  You can find a set of people whose opinion
matters (say core kernel maintainers) and not have that looks ugly in
their eyes.   In any case broken code is broken.

Eric

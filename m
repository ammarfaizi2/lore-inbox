Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285572AbRLGVhx>; Fri, 7 Dec 2001 16:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285569AbRLGVhl>; Fri, 7 Dec 2001 16:37:41 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:30343 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S285559AbRLGVhY>; Fri, 7 Dec 2001 16:37:24 -0500
Message-ID: <3C11368F.4020408@antefacto.com>
Date: Fri, 07 Dec 2001 21:37:19 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Michael Poole <poole@troilus.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>	<Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>	<20011207185847.A20876@wotan.suse.de>	<87wuzyq4ms.fsf@sanosuke.troilus.org> <3C110C0B.4030102@antefacto.com> <87snampvww.fsf@sanosuke.troilus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole wrote:

> Padraig Brady <padraig@antefacto.com> writes:
> 
> 
>>This breaks for the case discussed @
>>http://sources.redhat.com/ml/bug-glibc/2001-11/msg00079.html
>>I.E. if you have a multithreaded lib being linked by
>>single threaded apps (Note multithreaded lib, not just a
>>threadsafe lib (I.E. the lib calls pthread_create())).
>>
> 
> That's an interesting, but very contrived, example.  Can you find a
> single multi-threaded lib that uses FILE*'s shared with the
> application using it?


Well you have to deal with the general case. A single threaded

app linking against a multithreaded lib. It mightn't be just
shared FILE*'s that could cause problems.


> Linus's suggestion to add hooks to pthread_create() gets around that
> problem, anyway.


I don't think this will work as I said before current apps that
use _unlocked() functions directly manipulate the stdio structures,
hence a "new smarter locking stdio" would never get used by existing
compiled apps.

> Alternatively, the multi-threaded library could
> require any application linking to it to define _REENTRANT.


It could, but what if an existing interface (lib) is changed

from signle to multithreaded. You can't preclude this.


> After all, it's silly to talk about a 'multi-threaded' library linked
> to a 'single-threaded' application -- the application plus any
> libraries, as a whole, are either multithreaded or not.  They have to
> be on the same page to deal with *any* locking issues.
> 
> -- Michael

Padraig.


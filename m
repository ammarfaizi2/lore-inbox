Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSE1R0a>; Tue, 28 May 2002 13:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSE1R03>; Tue, 28 May 2002 13:26:29 -0400
Received: from [66.150.46.254] ([66.150.46.254]:4997 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S316855AbSE1R01>;
	Tue, 28 May 2002 13:26:27 -0400
Message-ID: <3CF3BDC4.8030401@wgate.com>
Date: Tue, 28 May 2002 13:26:28 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.0rc1) Gecko/20020509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] POSIX personality
In-Reply-To: <Pine.LNX.4.33.0205211603340.15094-100000@penguin.transmeta.com> <13860000.1022077174@baldur.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote:
> --On Tuesday, May 21, 2002 04:08:52 PM -0700 Linus Torvalds
> <torvalds@transmeta.com> wrote:
> 
> 
>>>One reason for it would be that it would be more efficient. All the
>>>various shared state needed for POSIX thread group emulation could be
>>>put into a  single structure with a single reference count.
>>
>>Now, that's a separate issue - the issue of the exact _granularity_ of
>>the  bits, and how you group things together.
>>
>>On that front, I don't have any strong feelings - but I suspect that it 
>>almost always ends up being fairly obvious when it is "right" to group 
>>things together, and when it isn't.
>>
>>For example, we probably could have had just one bit for (FS | FILES),
>>and  the same is probably true of (SIGHAND | THREAD), but on the whole we 
>>haven't really had any gray areas when it comes to the grouping. And I 
>>don't see any coming up.
>>
>>Does that mean that we might have a CLONE_POSIXDAMAGE that just covers all
>>the strange POSIX stuff that make no sense anywhere else? Maybe. But I'd
>>want that to be just another bit with the same semantic behaviour as the
>>existing ones, _not_ be some external "POSIX personality".
> 
> 
> I've been thinking along those lines myself.  At this point I'd suggest we
> implement them as separate, then if in the future no one ever uses them
> separately we can consider combining them.  I know this can raise some
> backward compatibility issues but in theory if anyone cares we wouldn't do
> it.

I would be worried about the future compatibility here.  It would be easier
to be compatible to start with a single bit and then add individual bits for
those features that need to be broken out when it is know to be needed.
Folding the bits back in is not as easy as you now have to still support
the individual but yet unneeded.

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.



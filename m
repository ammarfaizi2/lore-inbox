Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310538AbSCPTpb>; Sat, 16 Mar 2002 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310539AbSCPTpW>; Sat, 16 Mar 2002 14:45:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12813 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310538AbSCPTpE>;
	Sat, 16 Mar 2002 14:45:04 -0500
Message-ID: <3C93A0A6.5030307@mandrakesoft.com>
Date: Sat, 16 Mar 2002 14:44:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com> <20020316091452.E10086@work.bitmover.com> <3C938027.4040805@mandrakesoft.com> <20020316093832.F10086@work.bitmover.com> <3C938966.3080302@mandrakesoft.com> <20020316110144.H10086@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>>Yes it is "altering history"... but... OTOH the user has just told 
>>BitKeeper, in no uncertain terms, that he is altering history only to 
>>make it more correct.
>>

>*All* of this stuff is trivial if you don't care about passing it on, if
>your repository is a backwater dead end.  But that's not the case.
>So you have to decide that you want the events to propagate and if you
>do, then we can do something about it.
>

Re-read my message, assuming I have a clue :)  This fits just fine into 
the distribute BK system, across any number of pushes and pulls.

I -would- want to pass on the fact that I merged multiple changesets 
into a single one...

Think about this example:
* I merge a GNU patch into tree A, creating cset 1.111.
* Marcelo merges the same GNU patch into tree B, creating cset 1.222.
* Time passes.  People clone repos off of both trees.
* I 'bk pull' from tree B.  Through the merge process, this creates a 
brand new "symlink cset", 1.333, which propagates the notion that my 
cset 1.111 is a complete copy of 1.222, so we should just read the data 
and revision history from 1.222.
* Now, I 'bk push' some changes to Marcelo.  This pushes, among other 
things, the magic symlink cset 1.333.  It does not push 1.111, since 
1.333 was the change to the local repo that told it not to.  Think of 
this like "cset -x" except smarter.  "cset -x", as I understand it, 
creates a new cset which is essentially the reverse of the specified 
cset.  Our symlink cset says to BitKeeper (a) not bother with 
patch-and-unpatch if both 1.111 and 1.222 are found to be missing 
downstream, and (b) if 1.111 but 1.222 are present downstream, to remove 
the data associated with 1.111, turning it into a symlink to 1.222.

This fits perfectly well into the BK distributed system, and works 
across any number of bk pushes and pulls.  Basically, "symlink csets" 
would show up in 'bk changes', much like merge csets show up in 'bk 
changes' now.

And you are no longer inserting the data N times.  The symlink csets 
take care of that.

And further, for people scattered all over the world with 1.111 cset, 
the 1.333 cset will slowly worm its way across the world, acting like a 
janitor and cleaning up BK repositories with duplicated patches :) 
 Isn't that neat? :)
(assuming that 1.333 cset is propagated out to the world, of course)

>I'm starting to get psyched about this, I think I see a picture that 
>works, I need to chew on it for a bit though.
>

whichever works :)

    Jeff, who really should sleep now :)



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290969AbSAaG0E>; Thu, 31 Jan 2002 01:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290970AbSAaGZz>; Thu, 31 Jan 2002 01:25:55 -0500
Received: from altus.drgw.net ([209.234.73.40]:60178 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S290969AbSAaGZs>;
	Thu, 31 Jan 2002 01:25:48 -0500
Date: Thu, 31 Jan 2002 00:23:55 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Larry McVoy <lm@work.bitmover.com>, Alexander Viro <viro@math.psu.edu>,
        Larry McVoy <lm@bitmover.com>, Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131002355.X14339@altus.drgw.net>
In-Reply-To: <20020130195154.R22323@work.bitmover.com> <Pine.GSO.4.21.0201302335370.15689-100000@weyl.math.psu.edu> <20020130210835.F21235@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130210835.F21235@work.bitmover.com>; from lm@bitmover.com on Wed, Jan 30, 2002 at 09:08:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:08:35PM -0800, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 11:58:11PM -0500, Alexander Viro wrote:
> > Suppose I have 5 deltas - A, B, C, D, E.  I want to kill A.
> 
> If you just want to make A's changes go away, that's trivial:
> 
> 	bk get -e -xA foo.c
> 	bk delta -y"kill A's changes"
> 
> all done.

The real problem with this approach is it leads to information overload.

Go look at linuxppc_2_4_devel with sccstool and try to track major 
changes over the last 6 months. 

You can't. You are completely overwhelmed by the day-to-day thrashing of 
'bug fix this, bug fix that', and all the lines on the screen from the 
wacky merges we wind up doing in that tree.

I think what Linus and Viro really want is not to rewrite history
(although there are times when it would be nice), but say "I don't think
this change is worth looking at". Keep the data in the database, because
you have to to maintain consistency, but don't let me see it unless I ask
3 times, and say please.

This is the reason why I have a 'linuxppc_2_4_galileo' tree.. it's got a 
bunch of crap that will *only* ever be usefull to archeologists who want 
to figure out my or someone else's thought process. The code is ugly. The 
only reason I have another tree is because I want to work with other 
people and keep a record for myself in case I break something in the 
process.

Now, because I don't want to pollute the main tree, once this works, I'm 
going to merge this stuff manually with dirdiff over to 2_4_devel, and 
check it in.

And you're going to lose that information anyway (well, except on 
openlogging.org, but that's just comments), because once I have this 
working and checked into _devel, the _galileo tree is going to get 
deleted because nobody cares.

It is usefull to note that the human brain has evolved the capacity to
forget. Yes, sometimes it makes a mistake and forgets the wrong thing,
but let's not be too quick to forget there may be a lesson here, and 
everything is NOT always worth keeping. 

If you don't have some capacity to 'lose' information in your distributed
database, there will come a point in time that it will stop being
scalable. Either moore's law may break, or information will be going in
faster than you can keep up by depending on faster CPU's/more memory/disk
space to handle all that history.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz

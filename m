Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290927AbSAaFJQ>; Thu, 31 Jan 2002 00:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290929AbSAaFI5>; Thu, 31 Jan 2002 00:08:57 -0500
Received: from bitmover.com ([192.132.92.2]:28590 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290927AbSAaFIg>;
	Thu, 31 Jan 2002 00:08:36 -0500
Date: Wed, 30 Jan 2002 21:08:35 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Larry McVoy <lm@bitmover.com>, Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130210835.F21235@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
	Rob Landley <landley@trommello.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Eli Carter <eli.carter@inet.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130195154.R22323@work.bitmover.com> <Pine.GSO.4.21.0201302335370.15689-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0201302335370.15689-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jan 30, 2002 at 11:58:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 11:58:11PM -0500, Alexander Viro wrote:
> Suppose I have 5 deltas - A, B, C, D, E.  I want to kill A.

If you just want to make A's changes go away, that's trivial:

	bk get -e -xA foo.c
	bk delta -y"kill A's changes"

all done.

If you want to make A go away out of the graph, that's only possible if
you have the only copy of the graph containing A.  Since BK replicates
the history, you only get to do what you want before you push your changes
to someone else.  No surgery after you let the cat out of the bag.

You have a repository and you haven't propogated all this stuff to
someplace else, then this is easy, we'll just rebuild the history minus A.
You or I could write a shell script using BK commands to do it in about
10 minutes.

It's a distributed, replicated file system which uses the revision history
to propogate changes.  If you don't care about talking to anyone else,
you can do whatever you want.  If you want to give someone your history
and then change it, no way.  That's rewriting what happened.

Now does it make more sense?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

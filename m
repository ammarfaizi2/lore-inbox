Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSHGNgd>; Wed, 7 Aug 2002 09:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSHGNgd>; Wed, 7 Aug 2002 09:36:33 -0400
Received: from mark.mielke.cc ([216.209.85.42]:23817 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317351AbSHGNgc>;
	Wed, 7 Aug 2002 09:36:32 -0400
Date: Wed, 7 Aug 2002 09:39:44 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Wedgwood <cw@f00f.org>
Cc: Steve <steve@primalhost.com>, linux-kernel@vger.kernel.org
Subject: Re: Using Poll
Message-ID: <20020807093944.A13594@mark.mielke.cc>
References: <007701c23dc6$d26fb3b0$1e2efea9@steveuyfdnjo6s> <20020807065458.GC11181@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020807065458.GC11181@tapu.f00f.org>; from cw@f00f.org on Tue, Aug 06, 2002 at 11:54:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 11:54:58PM -0700, Chris Wedgwood wrote:
> On Wed, Aug 07, 2002 at 01:59:22PM +1000, Steve wrote:
> >   Hey,
> >           I recentally enquried about the FD Limit Size.. and how to
> >   enlarge it.. I was told to use the poll system instead.. How Do i
> >   use this Poll System?
> Can you explain a little more what you are trying to do here?  poll(2)
> is documented so I am not sure what you are asking...

He is probably talking about configuring the system to support more than
1024 file descriptors per process.

On Linux (POSIX?), fd_set is only 1024 bits long, making select() unusable,
or at least, not portably usable.

Since poll() uses an int to represent the file descriptor, poll() works
in situations that select() does not, although I would suspect that poll()
with this many active file descriptors (assuming one was actually waiting
for an event on 1024+ file descriptors) will probably kill sink quite a few
system seconds into the process over time.

Steve: As Chris mentions, poll(2) is documented. "man poll" will tell you
everything you need to know.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


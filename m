Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131975AbRBQWQB>; Sat, 17 Feb 2001 17:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRBQWPw>; Sat, 17 Feb 2001 17:15:52 -0500
Received: from web2104.mail.yahoo.com ([128.11.68.248]:4883 "HELO
	web2104.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131975AbRBQWPl>; Sat, 17 Feb 2001 17:15:41 -0500
Message-ID: <20010217221540.23972.qmail@web2104.mail.yahoo.com>
Date: Sat, 17 Feb 2001 14:15:40 -0800 (PST)
From: Fireball Freddy <fireballfreddy@yahoo.com>
Subject: Comparing buffer cache algorithms on 2.2.17.  Suggestions?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

  Trying to implement some different buffer caching
algorithms in Linux.  This is just for comparison
purposes for a thesis, not suggesting any problem with
the current scheme.  Here is what I'm attempting:

  o Eliminate BUF_CLEAN, BUF_DIRTY, and BUF_LOCKED
lists in favor of a single BUF_LRU list.  This because
I don't see the point of maintaining three lists...
the only time I need to find all the dirty blocks is
on a sync of some sort.  I don't mind if the sync
takes a while longer if the normal operating condition
is faster.

  Once I have the cache working on a single list
(assuming I can!) I plan on using an I/O generator to
get some repeatable traces so I can compare the
following:

  o LRU vs SLRU with static region percentages vs SLRU
with dynamic region percentages
  o Periodic flushing of dirty blocks enabled vs
disabled
  o Write-through caching vs write-back caching vs
adaptive (switching between wt and wb based on recent
activity) vs my own method (write to disk on first
write, only to buffer after that, write to disk again
when block is flushed, if dirty)
  o Of course, I'll also do a run with the default
Linux 2.2.17 to see how it compares with the others

  It looks like the ext2 fs is going to complicate
this somewhat, as it sets blocks dirty and/or writes
them itself sometimes.  Not sure how I'm going to get
around this... will probably ignore it for now.

  I'd appreciate any advice on this undertaking. 
Specifically, how many things (tools, etc) is this
going to break, warnings about common pitfalls, and
other suggestions.  I would like to have started this
on 2.4, but I wanted to work on a release that had
been out for a bit, so I'd know that any problems were
caused by *me* and not just kernel bugs.  :)

  Also, are there any specific people to whom I should
direct memory management questions?  I've had some in
the past few months but haven't been able to get
answers.  Or should I post them to this list (I assume
not).  Finally, I have noticed references to a
kernelnewbies chat room.  I prefer newsgroups to
chat... is there a good mailing list devoted to kernel
newbies?

  Thanks to everyone for your hard work, and apologies
for adding one more e-mail to the pile.

    Andy Cottrell

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262092AbTCRBhc>; Mon, 17 Mar 2003 20:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbTCRBhc>; Mon, 17 Mar 2003 20:37:32 -0500
Received: from ns0.cobite.com ([208.222.80.10]:56582 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S262092AbTCRBh3>;
	Mon, 17 Mar 2003 20:37:29 -0500
Date: Mon, 17 Mar 2003 20:48:16 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Larry McVoy <lm@bitmover.com>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030317233332.GC529@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0303172037530.6286-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Larry McVoy wrote:

> On Tue, Mar 18, 2003 at 12:25:44AM +0100, Andrea Arcangeli wrote:
> > yes, this is very helpful thanks ;). I'd suggest you to also parse the
> > logic tag and to print a warning if there's an error and not only to
> > trust the timestamps. 
> 
> The time stamps we're talking about are *in* the revision history. 
> We do all checkins to all files with the same timestamp in the same
> changeset.  

Ok.  A version of 'cvsps' which can correctly parse Larry's log format
into patchsets is up on the website (www.cobite.com/cvsps).  It's version
2.0b3.

Larry's timestamps actually made this hack really easy.  All files 
committed with the exact time are recreated into a patchset.  Here, for 
example is 'patchset 8156':

--------------------
PatchSet 8156
Date: 2003/03/05 03:11:19
Author: torvalds
Branch: HEAD
Tag: v2_5_64
Log:
Linux 2.5.64

BKrev: 3e656ad75XghvjRCVNEGWy20cX0qwg

Members:
        ChangeSet:1.8156->1.8157
        Makefile:1.340->1.341


(note, this is a pretty boring patchset, I just wanted to show it 
basically works).

The patchset id is in-sync with Larry's ChangeSet commits (but off by one
from the beginning).

You can do:  'cvsps -s 8156 -g' to generate a diff of this entire
patchset, and even get the correct results.

> 
> If you thought that we were talking about on disk timestamps, that's 
> way too fragile but these are fine.
> 
> > certain logic tag out of the tree. This logic tag will be the
> > "changeset" number for us, but one that is also persistent and no only
> > unique 
> 
> (Logical tag 1.XXXX) 
> 

The checkin (Logical Tag x.yyy) log messages are currently not validated, 
and are discarded.  Only the 'main' message with the BKrev: is associated 
with each patchset.

> is in each file's checkin comments and the 1.XXXX is the ChangeSet file's
> rev for that changeset.

Seems to work.

> > I also wonder if it wouldn't be better if Larry would simply tag the CVS
> > with the logic tag number since the first place, rather than writing it

Not necessary, each changeset is available via cvsps with 'cvsps -s 
<logical change number>' as well as searching by file, by date, by tag, by 
log message etc.

> That means that *all* files get tags.  There would be 8300 x 15,000 files
> times sizeof(tag).  That's too big.
> 

Uggh.

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


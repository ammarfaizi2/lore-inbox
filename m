Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbTCJVib>; Mon, 10 Mar 2003 16:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbTCJVib>; Mon, 10 Mar 2003 16:38:31 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:16645 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261492AbTCJVi3>; Mon, 10 Mar 2003 16:38:29 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303102150.h2ALoVME001043@81-2-122-30.bradfords.org.uk>
Subject: Filesystem write priorities, (Was: Re: [RFC] Improved inode number allocation for HTree)
To: schwab@suse.de (Andreas Schwab)
Date: Mon, 10 Mar 2003 21:50:31 +0000 (GMT)
Cc: phillips@arcor.de, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, tytso@mit.edu, adilger@clusterfs.com,
       chrisl@vmware.com, bzzz@tmi.comex.ru
In-Reply-To: <jebs0iq5c6.fsf@sykes.suse.de> from "Andreas Schwab" at Mar 10, 2003 10:28:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> |> > Though the journal only becomes involved when blocks are modified,
> |> > unfortunately, because of atime updates, this includes all directory
> |> > operations.  We could suggest to users that they should disable
> |> > atime updating if they care about performance, but we ought to be
> |> > able to do better than that.
> |> 
> |> On a separate note, since atime updates are not usually very important
> |> anyway, why not have an option to cache atime updates for a long time,
> |> or until either a write occurs anyway.
> 
> mount -o noatime

Well, yes, I use noatime by default, but I was thinking that there
might be users who wanted to gain most of the performance that using
noatime would, who still wanted access times available generally, but
who were not bothered about loosing them on an unclean shutdown.

Infact, taking this one step further, we could have assign directories
priorities, analogous to nice values for processes, and make the
lazyness of writes dependant on that.

So, for example, on a webserver, you could assign databases a high
priority for writes, but your webserver log a low priority.  If the
box crashed, the data most likely to be lost would be the webserver
log, rather than the database.

Another benefit would be that you could spin down disks, and not have
them spin up just to write data to the webserver log - that could be
committed to the disk just once an hour, but a database write could
cause it to spin up immediately.

John.

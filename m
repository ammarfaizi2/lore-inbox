Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbRAaQSb>; Wed, 31 Jan 2001 11:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbRAaQSV>; Wed, 31 Jan 2001 11:18:21 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:54022 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S129805AbRAaQSF>;
	Wed, 31 Jan 2001 11:18:05 -0500
From: tytso@snap.thunk.org
Date: Wed, 31 Jan 2001 10:32:39 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
Message-ID: <20010131103239.A1796@think>
In-Reply-To: <Pine.LNX.3.95.1010126084632.208A-100000@chaos.analogic.com> <3A73565B.6EBC7F77@ngforever.de> <9523bg$7dc$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <9523bg$7dc$1@cesium.transmeta.com>; from hpa@zytor.com on Sun, Jan 28, 2001 at 01:35:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 01:35:44PM -0800, H. Peter Anvin wrote:
> *renamed*, i.e. does the tools (e2fsck &c) use "/lost+found" by name,
> or by inode?  As far as I know it always uses the same inode number

e2fsck uses /lost+found by name, not by inode.  It will recreate a new
lost+found directory if one doesn't exist.  *However*, if the
filesystem is badly corrupted, it's possible that when it allocates
blocks for the lost+found directory, it might override a datablock
that might possibly be recoverable if one were truly desparate and
using a disk editor to search for keywords.  (This would only happen
if part of the inode table had gotten corrupted due to a hardware
error --- i.e., such as the anecdotal evidence of DMA units that write
garbage to the disk because during a power failure, where it is
conjectured that the +5V power rail drops below the critical working
of the memory faster than +12V power rail drops below the critical
working volutage of the disk drive --- so that the record in the inode
table that a certain disk block was in use is erased.)

So if you really dislike lost+found, go ahead and delete it.  It
removes a somewhat tiny safeguard, but being able to take advantage of
it requires wizard-level skills (there are no tools to do this
automatically, since it requires human intuition and a knowledge of
what file you might be trying to save.)  So it would probably only be
used in the case of someone who had 10 year's of Ph.D. research that
wasn't backed up, and this was the only way they could get the data
back.  And although not doing disk backups is grounds for general
redicule, losing ten years of graduate research would probably be
reguarded by most as cruel and unusual punishment.  But if you're not
in a Ph.D. program, it doesn't matter, yes?  (And in any case, we ALL
do backups, all the time, religiously and on a regular schedule,
RIGHT?  :-)

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbTDBUJN>; Wed, 2 Apr 2003 15:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbTDBUJN>; Wed, 2 Apr 2003 15:09:13 -0500
Received: from geranium.noc.ucla.edu ([169.232.48.11]:44735 "EHLO
	geranium.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S261801AbTDBUJM>; Wed, 2 Apr 2003 15:09:12 -0500
Date: Wed, 2 Apr 2003 12:20:21 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: linux-kernel@vger.kernel.org, jfs-discussion@www-124.southbury.usf.ibm.com
Subject: Re: oops with JFS 1.1.2 and 2.4.20
In-Reply-To: <200304021348.22551.shaggy@austin.ibm.com>
Message-ID: <Pine.LNX.4.53.0304021213490.24469@potato.cts.ucla.edu>
References: <Pine.LNX.4.53.0304021120460.16450@potato.cts.ucla.edu>
 <200304021348.22551.shaggy@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Dave Kleikamp wrote:

> Chris,
>
> Thanks for the report.  I think it's possible that this bug and the one
> you reported to the jfs-discussion list may be triggered by the same
> problem.  There seems to be some corruption to the partition's metadata.
> The XT_GETPAGE error should have caused the superblock to be marked
> dirty, so that on the next reboot, fsck will run completely, rather than
> just replaying the journal.  This should detect and fix whatever
> corruption caused the problem.  Let me know if you continue to see any
> more traps or syslog errors.

The lockup is completely reproducable.  I've got several hundred perl
processes that are doing SNMP polling and updating RRD files.  At the same
time, an rm -rf is started on the same partition that the is holding the
perl script and RRD files.  The rm -rf is removing some directories and
files that are being updated by the perl script.  The perl script
recreates the directories and files if they don't exist.  It's likely that
a number of the files/directories are open for read and/or write at the
time of removal.

When the machine booted, fsck did run completely.  I wasn't in front of it
and was not able to capture any messages.  Unfortunately the machine is in
production and can't go down, so I had to revert to ext2.

> We need to do a bit more "hardening" of the JFS code so that problems
> caused by bad on-disk metadata don't cause traps.  It would be better to
> mark the partition and return an error (where possible).
>
> Determining the cause of the corruption is much harder.  If you continue
> to see problems, we may be able to determine a repeatable way to create
> the problem and get a better idea of what the root cause is.

I'll try to come up with a test case that duplicates the disk access
issues.


-Chris


> Thanks,
> Shaggy
> --
> David Kleikamp
> IBM Linux Technology Center
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

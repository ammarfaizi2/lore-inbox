Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTDBThF>; Wed, 2 Apr 2003 14:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbTDBThF>; Wed, 2 Apr 2003 14:37:05 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:17992 "EHLO
	dyn94194207.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261302AbTDBThB>; Wed, 2 Apr 2003 14:37:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Chris Stromsoe <cbs@cts.ucla.edu>, linux-kernel@vger.kernel.org
Subject: Re: oops with JFS 1.1.2 and 2.4.20
Date: Wed, 2 Apr 2003 13:48:22 -0600
User-Agent: KMail/1.4.3
Cc: jfs-discussion@www-124.southbury.usf.ibm.com
References: <Pine.LNX.4.53.0304021120460.16450@potato.cts.ucla.edu>
In-Reply-To: <Pine.LNX.4.53.0304021120460.16450@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304021348.22551.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 April 2003 13:31, Chris Stromsoe wrote:
> A decoded oops report, the output from /proc/fs/jfs/*, and the
> ver_linux output is included below.  The kernel is stock 2.4.20 with
> JFS 1.1.2 from http://oss.software.ibm.com/jfs/
>
>
> -Chris

Chris,
Thanks for the report.  I think it's possible that this bug and the one 
you reported to the jfs-discussion list may be triggered by the same 
problem.  There seems to be some corruption to the partition's 
metadata.  The XT_GETPAGE error should have caused the superblock to be 
marked dirty, so that on the next reboot, fsck will run completely, 
rather than just replaying the journal.  This should detect and fix 
whatever corruption caused the problem.  Let me know if you continue to 
see any more traps or syslog errors.

We need to do a bit more "hardening" of the JFS code so that problems 
caused by bad on-disk metadata don't cause traps.  It would be better 
to mark the partition and return an error (where possible).

Determining the cause of the corruption is much harder.  If you continue 
to see problems, we may be able to determine a repeatable way to create 
the problem and get a better idea of what the root cause is.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center


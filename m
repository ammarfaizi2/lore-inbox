Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAIOG4>; Tue, 9 Jan 2001 09:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130349AbRAIOGq>; Tue, 9 Jan 2001 09:06:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:1229 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129415AbRAIOFm>;
	Tue, 9 Jan 2001 09:05:42 -0500
Date: Tue, 9 Jan 2001 14:03:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: adefacc@tin.it, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109140334.C4284@redhat.com>
In-Reply-To: <3A546385.C50B1092@tin.it> <20010105234604.C301@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010105234604.C301@bug.ucw.cz>; from pavel@suse.cz on Fri, Jan 05, 2001 at 11:46:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, 2001 at 11:46:04PM +0100, Pavel Machek wrote:
> 
> > Max. file size:	 		1 TB	(?)
> > Max. file system size:		2 TB	(?)
> 
> Again, maybe on i386 with ext2.

Actually, the 2TB limit affects all architectures, as we assume that
block indexes fit into 32 bits.  Blocks are passed around as unsigned
longs in some cases, but even on 64-bit machines that doesn't help us
as the limit still persists in the filesystem (32-bit block numbers)
and device drivers (ints and 4-byte sector numbers used when
generating SCSI commands).

Auditing the whole driver path to allow 64-bit block numbers, and
adding the logic to generate the 5th sector address byte in the scsi
command when we're doing 10-byte commands, are all possible extensions
for 2.5.  For now, though, the 2TB device limit is with us for all
architectures and all filesystems on 2.4.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

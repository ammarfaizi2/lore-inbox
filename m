Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRCPG2q>; Fri, 16 Mar 2001 01:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbRCPG2f>; Fri, 16 Mar 2001 01:28:35 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:2065 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129855AbRCPG20>; Fri, 16 Mar 2001 01:28:26 -0500
Date: Fri, 16 Mar 2001 01:27:45 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] report
Message-ID: <681360000.984724065@tiny>
In-Reply-To: <Pine.GSO.4.21.0103160056060.10709-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, March 16, 2001 01:03:20 AM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

>> Ok, I was more talking about the ugliness that is reiserfs_panic (how
>> many times do we need a commented out for(;;)?).  For panic() calling
>> sys_sync, I think there non-filesystem related panics where we do want
>> to sync.
> 
> panic doesn't sync if called from interrupt (thanks $DEITY).
> It is pointless to sync during boot.
> sync from driver panic is not better than one from fs.
> 
> What does it leave? I hadn't checked each panic(), but it seems that
> if we ever want syncing upon panic() it's safer to do sys_sync() by
> hands before calling panic(). If it is actually ever needed, that is.
> 
> 

A quick grep -r shows over 700 panic callers (outside reiserfs).  Most look
like init messages, or things that generally happen during interrupts.
But, I think there are too many to assume that nobody could benefit from a
sync.

Does that mean they _need_ the sync?  Probably not.

-chris


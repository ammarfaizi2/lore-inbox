Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRCPFxC>; Fri, 16 Mar 2001 00:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRCPFww>; Fri, 16 Mar 2001 00:52:52 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:46096
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S129740AbRCPFwj>; Fri, 16 Mar 2001 00:52:39 -0500
Date: Fri, 16 Mar 2001 00:51:59 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] report
Message-ID: <667310000.984721919@tiny>
In-Reply-To: <Pine.GSO.4.21.0103160030230.10709-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, March 16, 2001 12:32:56 AM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

> 
> 
> On Fri, 16 Mar 2001, Chris Mason wrote:
> 
>> > ObReiserfs_panic: what the hell is that ->s_lock bit about? panic()
>> > _never_ tries to do any block IO. It looks like a rudiment of something
>> > that hadn't been there for 5 years, if not longer. The same goes for
>> > ext2_panic() and ufs_panic(), BTW... I would suggest crapectomey here.
>> 
>> Ugh, that should have been dragged out and shot...patch will come in the
>> AM.
>> 
> Unfortunately it's nastier than I thought. panic() does sys_sync(). And
> IMO it really shouldn't. Notice that ->s_lock doesn't prevent
> ->write_inode() and friends from being called.
> 
> I suspect that the right fix is to drop the ->s_lock bogosity along with
> sys_sync() call in panic()...

Ok, I was more talking about the ugliness that is reiserfs_panic (how many
times do we need a commented out for(;;)?).  For panic() calling sys_sync,
I think there non-filesystem related panics where we do want to sync.

-chris


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbRAERmp>; Fri, 5 Jan 2001 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRAERmb>; Fri, 5 Jan 2001 12:42:31 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:52751 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129593AbRAERmZ>; Fri, 5 Jan 2001 12:42:25 -0500
Date: Fri, 05 Jan 2001 12:41:39 -0500
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>, Chris Evans <chris@scary.beasts.org>
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs patch for 2.4.0-final
Message-ID: <767090000.978716499@tiny>
In-Reply-To: <Pine.LNX.4.21.0101051454110.1295-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 05, 2001 02:54:53 PM -0200 Rik van Riel
<riel@conectiva.com.br> wrote:

> On Fri, 5 Jan 2001, Chris Evans wrote:
>> On Fri, 5 Jan 2001, Chris Mason wrote:
>> 
>> > > Could someone create one single patch for the 2.4.0 ?
>> > > 
>> > I put all the code into CVS, and Yura is making the official patch now.
>> 
>> Since 2.4.0 final should fix a few i/o performance issues
>> (particuarly under heavy write loads), a quick few ext2 vs.
>> reiserfs benchmarks would make very interesting reading ;-)
> 
> An easy way to gain a performance edge on ext2 would
> be to do proper write clustering in the reiserfs
> ->writepage() function...  </hint>
> 

;-)

The current 2.4 code has lots of room for tuning, since I've been trying to
keep it clean/stable for now (and our dbench numbers show it).  The first
optimization is tuning for reiserfs_get_block, I think writepage clustering
will be easier (and more beneficial) if we work out the buffer.c changes
I've been posting.

I also want to change the log block allocation a bit, so the log blocks are
allocated as the transaction progresses, instead of all at the end.  I
think that will make us much more VM friendly, and let me get rid of the
inode writing kludges.  It'll be a busy weekend ;-)

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

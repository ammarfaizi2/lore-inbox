Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRDYUcI>; Wed, 25 Apr 2001 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRDYUb5>; Wed, 25 Apr 2001 16:31:57 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:46093
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S131665AbRDYUbq>; Wed, 25 Apr 2001 16:31:46 -0400
Date: Wed, 25 Apr 2001 16:28:06 -0400
From: Chris Mason <mason@suse.com>
To: Pavel Machek <pavel@suse.cz>, viro@math.psu.edu,
        kernel list <linux-kernel@vger.kernel.org>,
        jack@atrey.karlin.mff.cuni.cz
cc: torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
Message-ID: <466810000.988230486@tiny>
In-Reply-To: <20010425220120.A1540@bug.ucw.cz>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, April 25, 2001 10:01:20 PM +0200 Pavel Machek <pavel@suse.cz>
wrote:

> Hi!
> 
>> > Hi!
>> > 
>> > I had a temporary disk failure (played with acpi too much). What
>> > happened was that disk was not able to do anything for five minutes
>> > or so. When disk recovered, linux happily overwrote all inodes it
>> > could not read while disk was down with zeros -> massive disk
>> > corruption.
>> > 
>> > Solution is not to write bad inodes back to disk.
>> > 
>> 
>> Wouldn't we rather make it so bad inodes don't get marked dirty at all?
> 
> I guess this is cheaper: we can mark inode dirty at 1000 points, but
> you only write it at one point.

Whoops, I worded that poorly.  To me, it seems like a bug to dirty a bad
inode.  If this patch works, it is because somewhere, somebody did
something with a bad inode, and thought the operation worked (otherwise,
why dirty it?).  

So yes, even if we dirty them in a 1000 different places, we need to find
the one place that believes it can do something worthwhile to a bad inode.

-chris



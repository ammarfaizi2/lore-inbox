Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129586AbRBVQe3>; Thu, 22 Feb 2001 11:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130295AbRBVQeU>; Thu, 22 Feb 2001 11:34:20 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:39179 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129586AbRBVQeH>; Thu, 22 Feb 2001 11:34:07 -0500
Date: Thu, 22 Feb 2001 11:33:39 -0500
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <2617490000.982859619@tiny>
In-Reply-To: <Pine.LNX.4.10.10102211929070.1129-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 21, 2001 07:30:47 PM -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:
> On Thu, 22 Feb 2001, Daniel Phillips wrote:
>> 
> 
> I'd love to hear the results from R5, as that seems to be the reiserfs
> favourite, and I'm trying it out in 2.4.2 because it was so easy to plug
> in..

Quick details, since I don't think I've seen them on l-k yet.  r5 was
chosen because it is more tuned to the reiserfs disk format.  The location
of a directory item on disk is determined by the hash of the name, and r5
is designed to put similar names close to each other on disk.

The benchmark that shows this best is creating X number of files in a
single dir (named 0001, 0002, 0003 etc).  r5 greating increases the chances
the directory item for 00006 will be right next to the item for 00007.  If
the application accesses these files in the same order they were created,
this has benefits at other times than just creation.  The benchmarks Ed
posted give a general idea for other naming patterns, but this one is best
case:

Time to create 100,000 files (10 bytes each) with r5 hash: 48s
Time to create 100,000 files (10 bytes each) with tea: 3m58s

The percentage increase just gets bigger as you create more and more files.
That doesn't mean this is a real world case, but it is what the hash was
designed for.  

-chris


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSCLXNa>; Tue, 12 Mar 2002 18:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSCLXNU>; Tue, 12 Mar 2002 18:13:20 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:46478 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289272AbSCLXM2>; Tue, 12 Mar 2002 18:12:28 -0500
Date: Tue, 12 Mar 2002 18:11:41 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [RFC] write_super is for syncing
Message-ID: <223400000.1015974701@tiny>
In-Reply-To: <212850000.1015973327@tiny>
In-Reply-To: <205630000.1015970453@tiny> <3C8E7E0C.816A3527@zip.com.au> <212850000.1015973327@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, March 12, 2002 05:48:47 PM -0500 Chris Mason <mason@suse.com> wrote:

>>> if (s_dirt & S_SUPER_DIRTY) call me from kupdate and on sync
>>> if (s_dirt & S_SUPER_DIRTY_COMMIT) call me on sync only.
>>> 
>> 
>> I'm not quite sure why these flags exist?  Would it not be
>> sufficient to just call ->write_super() inside kupdate,
>> and ->commit_super in fsync_dev()?  (With a ->write_super
>> fallback, of course).
> 
> fsync_dev(dev != 0) is easy, you can ignore the dirty flag
> and call commit_super on the proper device.
> 
> But, the loop in sync_supers(dev == 0) is harder, it expects
> some flag it can check, and it expects the callback to the FS
> will clear that flag.  Adding a new flag seemed like more fun
> than redoing the locking and super walk.  I'm curious to hear what 
> Al thinks of it though.

Of course, that's slightly more likely if I actually cc the right
address.

-chris


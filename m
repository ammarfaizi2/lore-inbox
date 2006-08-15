Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965306AbWHOJD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965306AbWHOJD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWHOJD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:03:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65493 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965306AbWHOJD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:03:57 -0400
Date: Tue, 15 Aug 2006 19:03:43 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060815190343.A2743401@wobbly.melbourne.sgi.com>
References: <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com> <20060808185405.B2528231@wobbly.melbourne.sgi.com> <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com> <20060811083546.B2596458@wobbly.melbourne.sgi.com> <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com> <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com> <20060814120032.E2698880@wobbly.melbourne.sgi.com> <9a8748490608140049t492742cx7f826a9f40835d71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9a8748490608140049t492742cx7f826a9f40835d71@mail.gmail.com>; from jesper.juhl@gmail.com on Mon, Aug 14, 2006 at 09:49:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 09:49:10AM +0200, Jesper Juhl wrote:
> On 14/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > LEAFN node level is 1 inode 412035424 bno = 8388608
> > 
> > Ooh.  Can you describe this test case you're using?
> ...
> These filesystems vary in size from 50G to 3.5T
> 
> The XFS filesystems contain rsync copies of filesystems on as many servers.
> The workload that triggers the problem is when all the servers start
> updating their copy via rsync - Then within a few hours the problem
> triggers.
> 
> So to recreate the same scenario you'll want 28 servers doing rsync of
> filesystems of various sizes between 50G & 3.5T to a central server
> running 2.6.18-rc4 with 28 XFS filesystems.
> ...
> There are millions of files. The data the server recievs is copies of
> websites. Each server that sends data to the server with the 28 XFS
> filesystems hosts between 1800 and 2600 websites, so there are lots of
> files and every concievable strange filename.

Wow, a special kind of hell for a filesystem developer...! ;-)

Its not clear to me where the rename operation happens in all of
this - does rsync create a local, temporary copy of the file and
then rename it?  Is it that central server going down or one of
those 28 other server machines?  (I assume it is, I can't see an
opportunity for renaming out there...).

When you hit it again, could you grab the contents of the inode
(you'll get that from xfs_repair -n, e.g. 412035424 above) with
xfs_db (see last entry in the XFS FAQ which describes how to do
that), then mail that to me please?  If you can get the source
and target names in the rename that'll help alot too... I can
explain how to use KDB to get that, but maybe you have another
debugger handy already?

thanks!

-- 
Nathan

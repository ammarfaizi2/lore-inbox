Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbREEQSK>; Sat, 5 May 2001 12:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbREEQSA>; Sat, 5 May 2001 12:18:00 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:20232
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S132737AbREEQRl>; Sat, 5 May 2001 12:17:41 -0400
Date: Sat, 05 May 2001 12:16:47 -0400
From: Chris Mason <mason@suse.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Maximum files per Directory
Message-ID: <476470000.989079407@tiny>
In-Reply-To: <20010505154920.A4571@pcep-jamie.cern.ch>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, May 05, 2001 03:49:20 PM +0200 Jamie Lokier
<lk@tantalophile.demon.co.uk> wrote:

> Chris Mason wrote:
>> > Is there a reason that
>> > reiserfs chose to have "large number of directories" represented by "1"
>> > and not "LINK_MAX+1"?
>> 
>> find and a few others consider a link count of 1 to mean there is no link
>> count tracking being done.
> 
> Indeed, and thank you for getting this right!
> 
> Btw, is it possible to add dirent->d_type information to reiserfs, and
> would there be any performance gain in doing so?

reiserfs doesn't store that information in its directory items right now,
but there are plenty of free bits to do so.  It wouldn't be hard to add the
feature, and yes there should be a performance gain.

> 
> I have code to add d_type for every other filesystem that can support it
> without additional disk reads, but I couldn't figure out whether
> reiserfs can do it or whether stat() following readdir() is cheap anyway.

stat is actually a little more expensive than ext2, since we have to search
for the inode data in the tree.  It is a fast search, but...

-chris




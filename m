Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314244AbSEBDhw>; Wed, 1 May 2002 23:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314258AbSEBDhv>; Wed, 1 May 2002 23:37:51 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:63628 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S314244AbSEBDhu>;
	Wed, 1 May 2002 23:37:50 -0400
Subject: Re: [STATUS 2.5]  May 1, 2002
From: Stephen Lord <lord@sgi.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@zip.com.au>, Mike Fedyk <mfedyk@matchmail.com>,
        Guillaume Boissiere <boissiere@attbi.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <m1adrjz1f0.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 01 May 2002 22:29:17 -0500
Message-Id: <1020310158.8097.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-01 at 22:14, Eric W. Biederman wrote:
> Stephen Lord <lord@sgi.com> writes:
> > 
> > Most of the performance benefits of delayed allocate are that
> > you do not the hard work of allocating the disk space in each
> > write call, you get to do it once, in potentially larger chunks,
> > and often not in the user's context.
> 
> Except for moving the work out of the users context, ext2 gets
> a similar benefit by reserving disk space ahead of time.  So it isn't
> clear that you need to have a delayed allocation to achieve this.
> 
> Eric

Doesn't everyone reserve more than the write asks for?

Delayed allocation as implemented in XFS means that during a write
call which has to make more room in a file, a super block counter
is changed, and the extent information is recorded in an in memory
structure associated with the inode.

Yes, if you have all your metadata buffers sitting in memory and are
not journalling changes then all you are doing is a different set of
memory manipulations which are noise on modern cpus when compared with
actually moving the file data out to disk.

Steve



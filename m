Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274997AbRIYN3W>; Tue, 25 Sep 2001 09:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274998AbRIYN3M>; Tue, 25 Sep 2001 09:29:12 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:1526 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S274997AbRIYN3H>; Tue, 25 Sep 2001 09:29:07 -0400
Date: Tue, 25 Sep 2001 14:28:54 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: foner-reiserfs@media.mit.edu
Cc: Nikita@Namesys.COM, Stephen Tweedie <sct@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20010925142854.A5384@redhat.com>
In-Reply-To: <15276.34915.301069.643178@beta.reiserfs.com> <200109222044.QAA11638@out-of-band.media.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109222044.QAA11638@out-of-band.media.mit.edu>; from foner-reiserfs@media.mit.edu on Sat, Sep 22, 2001 at 04:44:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 22, 2001 at 04:44:21PM -0400, foner-reiserfs@media.mit.edu wrote:

>     Stock reiserfs only provides meta-data journalling. It guarantees that
>     structure of you file-system will be correct after journal replay, not
>     content of a files. It will never "trash" file that wasn't accessed at
>     the moment of crash, though.
> 
> Thanks for clarifying this.  However, I should point out that the
> failure mode is quite serious---whereas ext2fs would simply fail
> to record data written to a file before a sync, reiserfs seems to
> have instead -swapped random pieces of one file with another-,
> which is -much- harder to detect and fix.

Not true.  ext2, ext3 in its "data=writeback" mode, and reiserfs can
all demonstrate this behaviour.  Reiserfs is being no worse than ext2
(the timings may make the race more or less likely in reiserfs, but
ext2 _is_ vulnerable.)

e2fsck only restores metadata consistency on ext2 after a crash: it
can't possibly guarantee that all the data blocks have been written.

ext3 will let you do full data journaling, but also has a third mode
(the default), which doesn't journal data, but which does make sure
that data is flushed to disk before the transaction which allocated
that data is allowed to commit.  That gives you most of the
performance of ext3's fast-and-loose writeback mode, but with an
absolute guarantee that you never see stale blocks in a file after a
crash.

Cheers,
 Stephen

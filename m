Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262131AbSJNSP4>; Mon, 14 Oct 2002 14:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262135AbSJNSP4>; Mon, 14 Oct 2002 14:15:56 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14033 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262131AbSJNSPx>;
	Mon, 14 Oct 2002 14:15:53 -0400
Date: Mon, 14 Oct 2002 14:16:26 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
X-X-Sender: shadow@trafford.andrew.cmu.edu
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes
 for 2.4.19-pre5-ac3)
In-Reply-To: <20021014190444.A24577@infradead.org>
Message-ID: <Pine.LNX.4.44L-027.0210141405590.18909-100000@trafford.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Christoph Hellwig wrote:

> > > On Mon, Oct 14, 2002 at 10:31:41AM -0400, Derrick J Brashear wrote:
> > > > Well, given the previous commentary I would have expected the hook to have
> > > > already existed, and if it had we would have changed to conform to it
> > > > months ago.
> > >
> > > Which hook?
> >
> > For this system call. The message from Alan I quoted which was from April.
>
> Call me stupid, but where did you quote it?  Would you mind
> including it again?

The first message I posted, with the first iteration of the patch.
There was some discussion around then (which I wasn't reading for, but
only came back to later) which essentially suggested that an nfsservctl
style hook for the AFS system call would be a reasonable way to deal.

As far as that goes, I think the best thing from where I'm sitting would
be actually 2 versions of this, one which takes a set of longs and can be
used as now for 2.4 kernels, and one with a new interface for 2.5 kernels.
That's not really a hard and fast position, perhaps it is in the best
interests of everyone for there to be only one version of this function
for the "new interface".

Incidentally, nothing in the kernel source tree provides an example
"explanation of the usage of nfsservctl"; I'll be happy to work out the
new interface and provide appropriate information, but is there some place
in particular such things end up being documented? I'm not averse to
submitting information to go in /Documentation but it doesn't appear
there's precedent for that.

Without further ado, previous quoted text:

7 Apr 2002, Alan said in message ID E16uGg1-0006Ln-00_at_the-village.bc.nu:
> And, unless this is reversed the OpenAFS kernel module won't load (it
> needs sys_call_table.):

Correct. There was agreement a very long time ago that code should not
patch
the syscall table (for one its not safe). AFS probably needs fixing so the
AFS syscall hook is exported portably and nicely in the syscall code.

This wants fixing in 2.5 too - basically

static int (*afs_syscall)(...);
sys_afs_syscall(...)
{
        if(afs_syscall)
                return afs_syscall(....)
        return -ENOSYS;
}

EXPORT_SYMBOL(afs_syscall)





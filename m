Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTHaWvY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbTHaWvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:51:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:13961 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263036AbTHaWt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:49:58 -0400
Date: Sun, 31 Aug 2003 23:49:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030831224937.GA29239@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com> <20030829230521.GD3846@matchmail.com> <20030830221032.1edf71d0.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830221032.1edf71d0.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Fri, 29 Aug 2003 16:05:21 -0700
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
> > Does this mean that userspace has to take into consideration that the isn't
> > coherent for adjacent small memory accesses on sparc?  What could happen if
> > it doesn't, or does it need to at all?
> 
> For shared memory, we enforce the correct mapping alignment
> so that coherency issues don't crop up.
> 
> How does this program work?  I haven't taken a close look
> at it.  Does it use MAP_SHARED or IPC shm?

It uses POSIX shared memory and (necessarily) MAP_SHARED, which
doesn't constrain the mapping alignment.

I had wondered if some kernels used page faults to maintain coherence
between multiple shared mappings of the same file.  It's one of the
things the program checks, and I have seen it mentioned on l-k, which
made me think it might be implemented.  None of the results for any
architecture show it, though.

If userspace does create multiple shared mappings at non-coherent
offsets, what is the recommended method for switching between
accessing one page (or page cluster?) and accessing the other.  Is it
msync(), a special system call to flush parts of the data cache, a
machine instruction, or something else?

Thanks,
-- Jamie



ps. The program has code to try IPC shm instead.  Change "#ifdef
SHM_DIR_PREFIX" in __page_alias_map to "#if 0", and add
-DHAVE_SYSV_SHM to the GCC command line.  It should fail the same test
sizes with a different message.

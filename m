Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbVLRM2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbVLRM2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 07:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbVLRM2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 07:28:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20497 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932697AbVLRM2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 07:28:16 -0500
Date: Sun, 18 Dec 2005 13:28:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: 7eggert@gmx.de
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051218122818.GB23349@stusta.de>
References: <5k8PZ-4xt-9@gated-at.bofh.it> <5k9sD-5yh-13@gated-at.bofh.it> <5knFp-kU-51@gated-at.bofh.it> <5korL-1xX-33@gated-at.bofh.it> <5kpRh-3sK-11@gated-at.bofh.it> <5kq0L-3FB-37@gated-at.bofh.it> <5kOma-4K1-23@gated-at.bofh.it> <5kRk3-xO-11@gated-at.bofh.it> <E1EnrYH-00019M-Ep@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EnrYH-00019M-Ep@be1.lrz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 06:57:44AM +0100, Bodo Eggert wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > I'm with you that we need a safety net, but I don't see a problem with
> > this being between 3kB and 4kB. The goal should be to _never_ use more
> > than 3kB stack having a 1kB safety net.
> > 
> > And in my experience, many stack problems don't come from code getting
> > more complex but from people allocating 1kB structs or arrays of
> > > 2k chars on the stack. In these cases, the code has to be fixed and
> > "make checkstack" makes it easy to find such cases.
> > 
> > And as a data point, my count of bug reports for problems with in-kernel
> > code with 4k stacks after Neil's patch went into -mm is still at 0.
> 
> Would you run a desktop with an nfs server on xfs on lvm on dm on SCSI?
> Or a productive server on -mm?
> 
> IMO it's OK to push 4K stacks in -mm, but one week of no error reports from
> a few testers don't make a reliable system.
> [...]

It isn't that 4k stacks were completely untested.

Fedore enables it for a long time.

Even RHEL4 always uses 4k stacks - and RHEL is a distribution many 
people use on their production servers.

> > Unfortunately, "is not really something to encourage" doesn'a make
> > "happens in real-life applications" impossible...
> 
> The same applies to using kernel stack. Therefore I'll want to choose
> a bigger stack for my server, which runs less than 100 processes.

You can always manually adjust THREAD_SIZE if you really want to, but 
there should be no reason to do so.

There are so many possible programming errors in kernel code, and stack 
usage problems are amongst the ones you can find relatively easy...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283189AbRLDPV5>; Tue, 4 Dec 2001 10:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283209AbRLDPUn>; Tue, 4 Dec 2001 10:20:43 -0500
Received: from mail313.mail.bellsouth.net ([205.152.58.173]:18451 "EHLO
	imf13bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S283204AbRLDPTd>; Tue, 4 Dec 2001 10:19:33 -0500
Message-ID: <3C0CE97F.74AFFDBC@mandrakesoft.com>
Date: Tue, 04 Dec 2001 10:19:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Donald Becker <becker@scyld.com>, Davide Libenzi <davidel@xmailserver.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet> <E16BGhe-0000Pq-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On December 4, 2001 03:09 am, Donald Becker wrote:
> > To bring this branch back on point: we should distinguish between
> > design for an arbitrary and unpredictable goal (e.g. 128 way SMP)
> > vs. putting some design into things that we are supposed to already
> > understan
> >    [...]
> >    a VFS layer that doesn't require the kernel to know a priori all of
> >      the filesystem types that might be loaded
> 
> Right, there's a consensus that the fs includes have to fixed and that it
> should be in 2.5.lownum.  The precise plan isn't fully evolved yet ;)
> 
> See fsdevel for the thread, 3-4 months ago.  IIRC, the favored idea (Linus's)
> was to make the generic struct inode part of the fs-specific inode instead of
> the other way around, which resolves the question of how the compiler
> calculates the size/layout of an inode.
> 
> This is going to be a pervasive change that someone has to do all in one
> day, so it remains to be seen when/if that is actually going to happen.
> 
> It's also going to break every out-of-tree filesystem.

ug.  what's wrong with a single additional alloc for generic_ip?  [if a
filesystem needs to do multiple allocs post-conversion, somebody's doing
something wrong]

Using generic_ip in its current form has the advantage of being able to
create a nicely-aligned kmem cache for your private inode data.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


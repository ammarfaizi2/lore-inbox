Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbSKZPSj>; Tue, 26 Nov 2002 10:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbSKZPSj>; Tue, 26 Nov 2002 10:18:39 -0500
Received: from thunk.org ([140.239.227.29]:52689 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266347AbSKZPSi>;
	Tue, 26 Nov 2002 10:18:38 -0500
Date: Tue, 26 Nov 2002 10:22:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Manish Lachwani <manish@Zambeel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 SMP hangs ..
Message-ID: <20021126152238.GA4408@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>,
	Manish Lachwani <manish@Zambeel.com>, linux-kernel@vger.kernel.org
References: <233C89823A37714D95B1A891DE3BCE5202AB1975@xch-a.win.zambeel.com> <3DDC7746.200ACDE2@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDC7746.200ACDE2@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 10:03:50PM -0800, Andrew Morton wrote:
> Manish Lachwani wrote:
> > 
> > I am seeing system hangs with 2.4.17 SMP kernel when doing mke2fs accros 12
> > drives in parallel. However, the hangs only occur when the I/O rate from
> > vmstat is high:
> > 
> 
> Quite possibly it has not hung.  You just need to wait half an
> hour or so.
> 
> The algorithm isn't very good.

[Catching up lkml mail after the IETF meeting....]

Try setting the environment variable "MKE2FS_SYNC" to a value such as
10.  This will cause mke2fs to force a sync after writing out every 10
block groups worth of inode tables.  

If this fixes the problem, then it means that the kernel isn't
handling write throttling correctly, and the system is thrashing
itself to death.  Write thottleing is one of these kernel bugs which
gets fixed and broken in the kernel multiple times.  I've considered
making MKE2FS_SYNC the default, but I haven't, mainly because current
behaviour is a great way of pointing out this write throttling bugs in
the VM.  (Stephen has fixed this bug multiple times over the years,
and he suggested that having a good test case for noticing when
someone has broken write throttling would be a Good Thing --- and it
seems to get broken fairly often, as people try to make improvements
to the VM layer.....)

						- Ted

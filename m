Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVCJFw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVCJFw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVCJFuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:50:52 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:53699 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S261710AbVCJFrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:47:41 -0500
Date: Thu, 10 Mar 2005 00:47:37 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: tridge@samba.org, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: make -j4 gets stuck w/ ccache over NFS - solved!
Message-ID: <20050310054737.GA27656@jupiter.solarsys.private>
References: <20041207022429.GA5295@jupiter.solarsys.private> <16822.44167.836780.288332@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16822.44167.836780.288332@samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tridge, Greg, et. al.:

I wrote, some months ago:
>  > I'm using ccache version 2.4 [1].  I just changed ~/.ccache to a symbolic
>  > link to a directory which is NFS mounted [2].  The kernel source itself is
>  > on a local FS.  With the ccache suitably primed, when I do a kernel compile
>  > using 'make -j4' it seems to get stuck for seconds at a time.  When it gets
>  > unstuck, it blows through a handful of files and then gets stuck again.

* tridge@samba.org <tridge@samba.org> [2004-12-08 18:25:59 +1100]:
> I'd suggest you first narrow down the problem to either being a
> locking problem or a file IO problem. To do that, change lock_fd() in
> util.c in ccache to just "return 0;". That will mean the ccache stats
> file could become corrupted, but if it runs fast then you know that it
> is a locking problem. I have noticed severe speed problem with NFS
> locking on Linux previosly, which is why I mention this as a
> possibility.
> 
> Note that removing this locking will not cause ccache to produce
> incorrect object files, it will just mean the stats printed with
> "ccache -s" may be inaccurate.

Thanks for the suggestions.  It wasn't very important to me so I didn't
make time to follow up on it.  I was just playing w/ ccache at the time.

Finally I noticed this patch from -mm1... and it solves the problem.

nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch

How I tested: I applied the first 12 patches in 2.6.11-mm1; the above
mentioned was last - couldn't reproduce the bug.  When I unapplied just
that one, I saw it again.

original bug report:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110238645132535&w=3

Greg: have you considered this one for 2.6.11.x?

Thanks,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbULHH1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbULHH1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbULHH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:27:09 -0500
Received: from dp.samba.org ([66.70.73.150]:25052 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262048AbULHH04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:26:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16822.44167.836780.288332@samba.org>
Date: Wed, 8 Dec 2004 18:25:59 +1100
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: make -j4 gets stuck w/ ccache over NFS
In-Reply-To: <20041207022429.GA5295@jupiter.solarsys.private>
References: <20041207022429.GA5295@jupiter.solarsys.private>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

 > I'm using ccache version 2.4 [1].  I just changed ~/.ccache to a symbolic
 > link to a directory which is NFS mounted [2].  The kernel source itself is
 > on a local FS.  With the ccache suitably primed, when I do a kernel compile
 > using 'make -j4' it seems to get stuck for seconds at a time.  When it gets
 > unstuck, it blows through a handful of files and then gets stuck again.

I'd suggest you first narrow down the problem to either being a
locking problem or a file IO problem. To do that, change lock_fd() in
util.c in ccache to just "return 0;". That will mean the ccache stats
file could become corrupted, but if it runs fast then you know that it
is a locking problem. I have noticed severe speed problem with NFS
locking on Linux previosly, which is why I mention this as a
possibility.

Note that removing this locking will not cause ccache to produce
incorrect object files, it will just mean the stats printed with
"ccache -s" may be inaccurate.

Cheers, Tridge

PS: I also wonder why you're not just using distcc. It's usually a lot
more appropriate in a distributed environment.


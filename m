Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbUKUXoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbUKUXoy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKUXoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:44:54 -0500
Received: from dp.samba.org ([66.70.73.150]:60085 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261847AbUKUXof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:44:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16801.10284.732681.619976@samba.org>
Date: Mon, 22 Nov 2004 10:43:40 +1100
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041121222123.GB704@frodo>
References: <1098383538.987.359.camel@new.localdomain>
	<16797.41728.984065.479474@samba.org>
	<20041121222123.GB704@frodo>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan,

 > I'm curious why you went to 2K inodes instead of 512 - I guess
 > because thats the largest inode size with a 4K blocksize?  If
 > the defaults were changed, I expect it would be to switch over
 > to 512 byte inodes - do you have numbers for that?

It was a fairly arbitrary choice. For the test I was running the
xattrs were small (44 bytes), so 512 would have been fine, but some
other tests I run use larger xattrs (for NT ACLs, streams, DOS EAs
etc). 

 > Ah great, thanks, I'll be keen to try that when its available.

It's now released. You can grab it at:

  http://samba.org/ftp/tridge/dbench/dbench-3.0.tar.gz

It should produce much more consistent results than previous versions
of dbench, plus it has a -x option to enable xattr support. Other
changes include:

 - the runs are now time limited, rather than being a fixed number of
   operations. This gives much more consisten results, especially for
   fast machines.

 - I've changed the mapping of the filesystem operations to be much
   closer to what Samba4 does, including the directory scans for case
   insensitivity, the stat() calls in name resolution and things like
   statfs() calls. The modelling could still be improved, but its
   much better than it was.

 - the load file is now compatible with the smbtorture NBENCH test
   again (the two diverged a while back).

 - the default load file has been updated to be based on NetBench
   7.0.3, running a enterprise disk mix.

 - the warmup/execute/cleanup phases are now better separated

Cheers, Tridge

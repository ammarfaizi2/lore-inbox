Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVLFS7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVLFS7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVLFS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:59:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:17283 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965015AbVLFS73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:59:29 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17301.60339.324559.226160@tut.ibm.com>
Date: Tue, 6 Dec 2005 13:51:15 -0600
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 2/12] relayfs: export relayfs_create_file() with fileops param
In-Reply-To: <20051206172910.GA24362@infradead.org>
References: <17268.51814.215178.281986@tut.ibm.com>
	<17268.51975.485344.880078@tut.ibm.com>
	<20051111193749.GA17018@infradead.org>
	<17268.62897.434122.165183@tut.ibm.com>
	<20051206172910.GA24362@infradead.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Fri, Nov 11, 2005 at 01:49:05PM -0600, Tom Zanussi wrote:
 > > Christoph Hellwig writes:
 > >  > On Fri, Nov 11, 2005 at 10:47:03AM -0600, Tom Zanussi wrote:
 > >  > > This patch adds a mandatory fileops param to relayfs_create_file() and
 > >  > > exports that function so that clients can use it to create files
 > >  > > defined by their own set of file operations, in relayfs.  The purpose
 > >  > > is to allow relayfs applications to create their own set of 'control'
 > >  > > files alongside their relay files in relayfs rather than having to
 > >  > > create them in /proc or debugfs for instance.  relayfs_create_file()
 > >  > > is also used by relay_open_buf() to create the relay files for a
 > >  > > channel.  In this case, a pointer to relayfs_file_operations is passed
 > >  > > in, along with a pointer to the buffer associated with the file.
 > >  > 
 > >  > Again, NACK,  control files don't belong into relayfs.
 > >  > 
 > > 
 > > Sure, applications could just as easily create these same files in
 > > /proc, /sys, or /debug, but since relayfs is a filesystem, too, it
 > > seems to me to make sense to take advantage of that and allow them to
 > > be created alongside the relay files they're associated with, in
 > > relayfs.
 > 
 > Didn't we have that discussion before?  If we want a mix-and-match fs
 > just redo relayfs into a library of file operations for debugfs
 > (or anything else that can use file_operations for that matter)
 > 

Yes, it did come up but never went anywhere; the sticking point at the
time was the perception that debugfs is only for kernel debugging and
therefore wouldn't be configured into most kernels (whereas relayfs
presumably would), leaving non-debugging relayfs applications high and
dry if the fs part of relayfs was removed.

Other than that, it doesn't really matter whether relay files live in
relayfs or debugfs.  At one point I even had a preliminary patch that
would convert fs/relayfs/* -> fs/relay_file.c.  I could resurrect that
patch if it makes sense - from a user standpoint, the only differences
would be be that userspace would open and read relay files in
/mnt/debug instead of /mnt/relay and the kernel side would use the
debugfs directory creation functions instead of the relayfs
counterparts.

Or just leave relayfs as is, except that in that case, I do still
think these patches make sense.

Tom



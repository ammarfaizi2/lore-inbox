Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbUCZQ1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 11:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbUCZQ1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 11:27:55 -0500
Received: from wren.rentec.com ([65.213.84.9]:3829 "EHLO wren.rentec.com")
	by vger.kernel.org with ESMTP id S263987AbUCZQ1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 11:27:53 -0500
From: Brian Childs <brian@rentec.com>
Date: Fri, 26 Mar 2004 11:27:48 -0500
To: linux-kernel@vger.kernel.org, suse-linux-e@suse.com
Subject: NFS client bug, (Stale NFS file handle)
Message-ID: <20040326162746.GB11274@rentec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We beleive we're hitting an NFS client bug:

 Disto: SuSE-9.0 (64 bit)
  Arch: x86_64 SMP
Kernel: 2.4.21 (SuSE k_smp-2.4.21-201)

We're getting stale file handle errors for files in a directory two
levels below the mountpoint.

For example:

hosta$ cd /mountpoint/a/b
hosta$ ls -l
ls: A-spotpr: Stale NFS file handle
ls: B-spotpr: Stale NFS file handle
ls: C-spotpr: Stale NFS file handle
ls: D-spotpr: Stale NFS file handle
ls: E-spotpr: Stale NFS file handle
<snip>
total 0
hosta$ 

HOWEVER...

otherhost$ cd /mountpoint/a/b
otherhost$ ls -l
total 2352
-rw-rw-r--    1 db       data        82896 Mar 25 17:02 A-spotpr
-rw-rw-r--    1 db       data        57840 Mar 25 17:10 B-spotpr
-rw-rw-r--    1 db       data        82896 Mar 25 17:02 C-spotpr
-rw-rw-r--    1 db       data       213840 Mar 25 17:10 D-spotpr
-rw-rw-r--    1 db       data        82896 Mar 25 17:02 E-spotpr
<snip>
otherhost$

Where hosta & otherhost are the same type of machine running the same
OS, and they mount the directories at the same time.

I've never seen this before.  I'm used to seeing system-wide stale
handles for a mountpoint, but never for a specific file under a
mountpoint.

/mountpoint/a works without a problem, as does all files under
/mountpoint/a/c

I can't reliably reproduce this, but I know it happens after the
contents of /mountpoint/a/b are updated with an rsync.

Any help in diagnosing or fixing this will be greatly appreciated.

Brian

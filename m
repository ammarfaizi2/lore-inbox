Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTDGOo4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTDGOo4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:44:56 -0400
Received: from pat.uio.no ([129.240.130.16]:34434 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263461AbTDGOox (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:44:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.37263.648356.201846@charged.uio.no>
Date: Mon, 7 Apr 2003 16:56:15 +0200
To: SteveD@RedHat.com
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] mmap corruption
In-Reply-To: <20030407140052.GA1471@RedHat.com>
References: <3E8DDB13.9020009@RedHat.com>
	<shsistt7wip.fsf@charged.uio.no>
	<20030405164741.GA6450@RedHat.com>
	<16016.7633.982870.860147@charged.uio.no>
	<20030407140052.GA1471@RedHat.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steve Dickson <SteveD@RedHat.com> writes:

     > OK, I understand your point.  And Yes, ndirty and ncommit
     > always seem to be zero when nfs_wb_all() returns. Only when
     > npages != 0 is when I get the corruption.

     > I didn't realize that npages != 0 meant there are only pending
     > reads *not* pending writes... Thanks for that clarification....

My mistake. npages counts only writes...

However, I still stand by my statement that nfs_wb_all() is supposed
to ensure that *all* pending writes have been cleared.
The only explanation for npages != 0 is if

  a) an error occurred with nfs_wb_all() (we should perhaps test the
     return value of nfs_wb_all() there). Under normal circumstances,
     an error should only occur if you're using soft mounts, though.

  b) somebody redirtied the page *after* nfs_wb_all() was done.

Cheers,
  Trond

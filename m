Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbUKPQfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUKPQfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUKPQdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:33:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39366 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262044AbUKPQdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:33:23 -0500
Date: Tue, 16 Nov 2004 10:32:24 -0600
From: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org, dev@sw.ru,
       wli@holomorphy.com, steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-ID: <20041116163224.GB5594@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com> <20041115145714.3f757012.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115145714.3f757012.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 02:57:14PM -0800, Andrew Morton wrote:
> Robin Holt <holt@sgi.com> wrote:
> >
> > One significant problem we are running into is autofs trying to umount the
> > file systems.  This results in the umount grabbing the BKL and inode_lock,
> > holding it while it scans through the inode_list and others looking for
> > inodes used by this super block and attempting to free them.
> 
> You'll need invalidate_inodes-speedup.patch and
> break-latency-in-invalidate_list.patch (or an equivalent).

With these patches and a new test where I periodically put on mild
but diminishing memory pressure, I have been able to get the number
of inodes up to 31 Million.  I would really like to find a way to
reduce limit the number of inodes or am I seeing a problem where
none exists?  After putting on constant mild memory pressure, I have
seen then number of inodes stabilize at 17-18 Million.

Robin

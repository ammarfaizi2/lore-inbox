Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUCVLKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 06:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUCVLKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 06:10:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18373 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261874AbUCVLKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 06:10:41 -0500
Date: Mon, 22 Mar 2004 12:10:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040322111039.GL1481@suse.de>
References: <20040319153554.GC2933@suse.de> <20040322030939.6243c1c2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322030939.6243c1c2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> >  A first release of a collected barrier patchset for 2.6.5-rc1-mm2.
> 
> The tagging of BIOs with set_buffer_ordered() or WRITE_BARRIER is a little
> awkward.
> 
> Take the case of an ext2 fsync() or even an ext3 fsync() which frequently
> will not trigger a commit.  If we must perform the barrier by tagging the
> final BIO, that will be tricky to implement.  I could set some new field in
> struct writeback_control and rework the mpage code, but working out "this
> is the final BIO for this operation" is a fairly hard thing to do. 
> sys_sync() would require even more VFS surgery.

Yeah, it's not very pretty if you have to track the last sumit. Chris
complained about that in 2.4 as well :-)

> Generally, it would be much preferable to use the blkdev_issue_flush()
> API.  What is the status of that?

It'll be fully supported.

-- 
Jens Axboe


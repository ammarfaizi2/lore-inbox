Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUCLUxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCLUOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:14:00 -0500
Received: from ns.suse.de ([195.135.220.2]:56470 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262345AbUCLUEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:04:04 -0500
Subject: Re: [PATCH] per-backing dev unplugging #2
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
In-Reply-To: <20040312120322.0108a437.akpm@osdl.org>
References: <20040311083619.GH6955@suse.de>
	 <1079121113.4181.189.camel@watt.suse.com>
	 <20040312120322.0108a437.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079121993.4186.204.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 15:06:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 15:03, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > During a mixed load test including fsx-linux and a bunch of procs
> > running cp/read/rm loops, I got a null pointer deref with the call
> > trace:
> > 
> > __lock_page->sync_page->block_sync_page
> > 
> > I don't see how we can trust page->mapping in this path, can't it
> > disappear?  If so, it would be a bug without Jens' patch too, just
> > harder to hit.
> 
> yup.  I wonder why you hit it now.

> This should be sufficient.  All callers of lock_page() should have a ref on
> the inode so ->mapping should be stable even if truncate whips the page off
> the inode.
> 
I thought the same thing, but blk_run_address_space does an if(mapping)
check already.  Looking deeper...

-chris





Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269697AbUICN5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269697AbUICN5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269703AbUICN5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:57:48 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:45841 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S269697AbUICN5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:57:30 -0400
Message-ID: <20040903175728.C1834@castle.nmd.msu.ru>
Date: Fri, 3 Sep 2004 17:57:28 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Chris Mason <mason@suse.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: EXT3: problem with copy_from_user inside a transaction
References: <20040903150521.B1834@castle.nmd.msu.ru> <20040903123541.GB8557@x30.random> <1094213179.16078.19.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <1094213179.16078.19.camel@watt.suse.com>; from "Chris Mason" on Fri, Sep 03, 2004 at 08:06:20AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 08:06:20AM -0400, Chris Mason wrote:
> On Fri, 2004-09-03 at 08:35, Andrea Arcangeli wrote:
> > On Fri, Sep 03, 2004 at 03:05:21PM +0400, Andrey Savochkin wrote:
> > > 
> > > filemap_copy_from_user() between prepare_write() and commit_write()
> > > appears to be a problem for ext3.
> > > 
> And reiserv3, and maybe the other journaled filesystems.
> 
> > yes, Chris is working on it for a few months.
> > 
> Working is a generous term, I've somewhat been waiting for a better
> solution to pop into my head.  In the end, I think all we can do is not
> allow filesystems to take locks (or implicit locks like starting a
> transaction) inside the prepare_write call.
> 
> This would mean that all the work is done during the commit_write
> stage.  The trick is that we would have to handle -ENOSPC since we might
> not know we've run out of room until after the data has been copied from
> userland.

What is the problem -ENOSPC?
Do you think about the problem of the page existing before this write, it's
content overwritten, but the filesystem being unable to commit that write
because it needs more space?

	Andrey

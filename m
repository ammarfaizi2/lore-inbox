Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbTA3VCz>; Thu, 30 Jan 2003 16:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbTA3VCz>; Thu, 30 Jan 2003 16:02:55 -0500
Received: from waste.org ([209.173.204.2]:37868 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267389AbTA3VCy>;
	Thu, 30 Jan 2003 16:02:54 -0500
Date: Thu, 30 Jan 2003 15:12:12 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Report write errors to applications
Message-ID: <20030130211212.GB4357@waste.org>
References: <20030129060916.GA3186@waste.org> <20030128232929.4f2b69a6.akpm@digeo.com> <20030129162411.GB3186@waste.org> <20030129134205.3e128777.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129134205.3e128777.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 01:42:05PM -0800, Andrew Morton wrote:
> Oliver Xymoron <oxymoron@waste.org> wrote:
> >
> > > - fsync_buffers_list() will handle them and will return errors to the fsync()
> > > caller.  We only need to handle those buffers which were stripped
> > > asynchronously by VM activity.
> > 
> > Are we guaranteed that we'll get a try_to_free_buffers after IO
> > completion and before sync? I haven't dug through this path much.
> 
> Think so.  That's the only place where buffers are detached.  Otherwise,
> fsync_buffers_list() looks at them all.

The other problem here is that by the time we're in
try_to_free_buffers we no longer know that we're looking at a harmless
stale page (readahead?) or a write error, which is why Linus had me
make the separate end_buffer functions. So I don't think this pans out
- thoughts?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

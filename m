Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTA3Vbh>; Thu, 30 Jan 2003 16:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTA3Vbh>; Thu, 30 Jan 2003 16:31:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:10423 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267640AbTA3Vbb>;
	Thu, 30 Jan 2003 16:31:31 -0500
Message-ID: <3E399B93.90B32D12@digeo.com>
Date: Thu, 30 Jan 2003 13:39:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Report write errors to applications
References: <20030129060916.GA3186@waste.org> <20030128232929.4f2b69a6.akpm@digeo.com> <20030129162411.GB3186@waste.org> <20030129134205.3e128777.akpm@digeo.com> <20030130211212.GB4357@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jan 2003 21:39:31.0860 (UTC) FILETIME=[12FFA540:01C2C8A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Wed, Jan 29, 2003 at 01:42:05PM -0800, Andrew Morton wrote:
> > Oliver Xymoron <oxymoron@waste.org> wrote:
> > >
> > > > - fsync_buffers_list() will handle them and will return errors to the fsync()
> > > > caller.  We only need to handle those buffers which were stripped
> > > > asynchronously by VM activity.
> > >
> > > Are we guaranteed that we'll get a try_to_free_buffers after IO
> > > completion and before sync? I haven't dug through this path much.
> >
> > Think so.  That's the only place where buffers are detached.  Otherwise,
> > fsync_buffers_list() looks at them all.
> 
> The other problem here is that by the time we're in
> try_to_free_buffers we no longer know that we're looking at a harmless
> stale page (readahead?) or a write error, which is why Linus had me
> make the separate end_buffer functions. So I don't think this pans out
> - thoughts?

If the buffer has buffer_req and !buffer_uptodate and !buffer_locked
we know that it was submitted for IO, that the IO has completed, and
that it failed.

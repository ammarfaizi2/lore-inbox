Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTAXLOr>; Fri, 24 Jan 2003 06:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTAXLOr>; Fri, 24 Jan 2003 06:14:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43426 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267636AbTAXLOq>;
	Fri, 24 Jan 2003 06:14:46 -0500
Date: Fri, 24 Jan 2003 12:23:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
Message-ID: <20030124112339.GN910@suse.de>
References: <20030123195044.47c51d39.akpm@digeo.com> <946253340.1043406208@[192.168.100.5]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946253340.1043406208@[192.168.100.5]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24 2003, Alex Bligh - linux-kernel wrote:
> 
> --On 23 January 2003 19:50 -0800 Andrew Morton <akpm@digeo.com> wrote:
> 
> >  So what anticipatory scheduling does is very simple: if an application
> >  has performed a read, do *nothing at all* for a few milliseconds.  Just
> >  return to userspace (or to the filesystem) in the expectation that the
> >  application or filesystem will quickly submit another read which is
> >  closeby.
> 
> I'm sure this is a really dumb question, as I've never played
> with this subsystem, in which case I apologize in advance.
> 
> Why not follow (by default) the old system where you put the reads
> effectively at the back of the queue. Then rather than doing nothing
> for a few milliseconds, you carry on with doing the writes. However,
> promote the reads to the front of the queue when you have a "good
> lump" of them. If you get further reads while you are processing
> a lump of them, put them behind the lump. Switch back to the putting
> reads at the end when we have done "a few lumps worth" of
> reads, or exhausted the reads at the start of the queue (or
> perhaps are short of memory).

The whole point of anticipatory disk scheduling is that the one process
that submits a read is not going to do anything before that reads
completes. However, maybe it will issue a _new_ read right after the
first one completes. The anticipation being that the same process will
submit a close read immediately.

-- 
Jens Axboe


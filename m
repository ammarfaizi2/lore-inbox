Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWHMObh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWHMObh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWHMObh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 10:31:37 -0400
Received: from brick.kernel.dk ([62.242.22.158]:57640 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751261AbWHMObh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 10:31:37 -0400
Date: Sun, 13 Aug 2006 16:31:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-ID: <20060813143135.GB3245@suse.de>
References: <20060810110627.GM11829@suse.de> <20060812162857.d85632b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060812162857.d85632b9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12 2006, Andrew Morton wrote:
> On Thu, 10 Aug 2006 13:06:27 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > Ok maybe that is a little too strong, but I am indeed seeing some very
> > sucky behaviour with softirqs here. The block layer uses it for doing
> > request completions
> 
> I wasn't even aware that this change had been made.  I don't recall (and I
> cannot locate) any mailing list discussion of it.
> 
> Maybe I missed the discussion.  But if not, this is yet another case of
> significant changes getting into mainline via a git merge and sneaking
> under everyone's radar.

It's not a significant change, it pretty much falls into a code
relocation issue. The softirq completion stuff was made generic, and
SCSI the primary user of it. The completion path didn't change for SCSI.

> It seems like a bad idea to me.  Any additional latency at all in disk
> completion adds directly onto process waiting time - we do a _lot_ of
> synchronous disk IO.

Doesn't seem like a good idea to me either, hence I'm investigating the
current possible problems with it...

> There is no mention in the changelog of any observed problems which this
> patch solves.  Can we revert it please?

As you should see now, it wont change anything. The problem would be
the same.

-- 
Jens Axboe


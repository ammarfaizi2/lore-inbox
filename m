Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbTCGMMF>; Fri, 7 Mar 2003 07:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbTCGMMF>; Fri, 7 Mar 2003 07:12:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39120 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261533AbTCGMME>;
	Fri, 7 Mar 2003 07:12:04 -0500
Date: Fri, 7 Mar 2003 14:20:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 and jiffies wrap
Message-ID: <20030307132048.GC903@suse.de>
References: <20030307130504.GA903@suse.de> <20030307041558.6112425c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307041558.6112425c.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Hi,
> > 
> > The patch doesn't look right, why is INITIAL_JIFFIES being cast to
> > unsigned int? This breaks x86_64 at least.
> > 
> > ...
> > -#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
> 
> This sets the initial jiffies value to 0x00000000fffb6c20, which can trigger
> 32-bit wraparound bugs: if some random jiffy counter wraps from
> 0x00000000ffffffff to 0x0000000000000000 then things fail.
> 
> davem was bitten by at least one such bug in the qlogicfc driver.  It would
> have caused 64-bit machines to fail after 49 days.
> 
> It turns out that it is more valuable to test for this than to test for
> 64-bit wraparound bugs.

Ok makes sense, I thought the point was just to test for jiffies wrap.
Anyways, the patch breaks boot on x86_64 here.

-- 
Jens Axboe


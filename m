Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbTCLKDp>; Wed, 12 Mar 2003 05:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263133AbTCLKDo>; Wed, 12 Mar 2003 05:03:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17089 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263132AbTCLKDh>;
	Wed, 12 Mar 2003 05:03:37 -0500
Date: Wed, 12 Mar 2003 11:14:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312101414.GB3950@suse.de>
References: <20030312090943.GA3298@suse.de> <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12 2003, Andre Hedrick wrote:
> 
> No that is wrong to force all other drives to under perform because on
> one.  If you are going to impose 255 then pushi it back to 128 were it is
> a single scatter list.  This issue has bugged me for years and now that we
> know the exact model we apply an exception rule to it.
> 
> This is one silly bug that I have heard about.

See that's the whole point, is there any performance issue with 248 vs
256 sectors? For a 248 sectors vs 256 command alone, I doubt it. The
only problem I see is for potential chop-ups of 248 - 8 - 248 - 8 - 248
- 8 - etc. But due to merging, only the last command should be smaller.

So I still think it's much better stick with the safe choice. Why do you
think it's only one drive that has this bug? It basically boils down to
whether That Other OS uses 256 sector commands or not. If it doesn't, I
wouldn't trust the drives one bit.

And finally, _I'm_ not imposing anything. The limit is driver tweakable,
always has been.

-- 
Jens Axboe


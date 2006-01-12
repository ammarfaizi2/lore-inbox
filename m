Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWALHd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWALHd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWALHd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:33:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52257 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750826AbWALHd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:33:27 -0500
Date: Thu, 12 Jan 2006 08:35:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
Message-ID: <20060112073502.GA17718@suse.de>
References: <17348.34472.105452.831193@cse.unsw.edu.au> <43C4947C.1040703@reub.net> <20060110213001.265a6153.akpm@osdl.org> <20060110213056.58f5e806.akpm@osdl.org> <43C4E2BE.6050800@reub.net> <20060111030529.0bc03e0a.akpm@osdl.org> <20060111111313.GD3389@suse.de> <43C4EEA4.3050502@reub.net> <20060111115616.GE3389@suse.de> <17349.31818.631247.842663@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17349.31818.631247.842663@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2006, Neil Brown wrote:
> On Wednesday January 11, axboe@suse.de wrote:
> > 
> > Then the barrier changes from git2 -> git3 should not have anything to
> > do with it. Strange... I guess you should try the git bisect method to
> > narrow it down.
> 
> Not true, though you seem to have already figured that out.
> 
> md uses barrier writes when writing the superblock.  This is partly
> because it seems like a good idea, but largely to test if barrier
> writes are going to work on the component devices.  If any device
> claims not to support barriers, then raid1 will claim not to support
> barriers.
> 
> And the strange hang happens while md is trying to update the
> superblock.

Yeah that's what I found out later on in the thread, indeed killing that
barrier write made the problem disappear.

-- 
Jens Axboe


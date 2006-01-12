Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWALOKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWALOKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWALOKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:10:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24105 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030400AbWALOKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:10:35 -0500
Date: Thu, 12 Jan 2006 15:10:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Ric Wheeler <ric@emc.com>,
       Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
Message-ID: <20060112141015.GL3945@suse.de>
References: <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org> <43C61598.7050004@reub.net> <20060112111846.GA19976@htj.dyndns.org> <43C645ED.40905@reub.net> <43C64C3B.5070704@emc.com> <43C64DF6.7060604@reub.net> <20060112135533.GA29675@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112135533.GA29675@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2006, Tejun Heo wrote:
> 4. a REQ_SPECIAL | REQ_BLOCK_PC | REQ_QUIET request gets queued at
>    the head of the queue.  (I have no idea where this comes from.  sd
>    driver doesn't even handle PC requests.  It will be just failed.
>    Some kind of hardware management stuff trying to probe MMC
>    devices?)

But it does, sd understands these just fine (see references to
blk_pc_request()).

It could be coming from someone doing a blkdev_issue_flush, that will
even cause sd to queue such a request internally. So it isn't
necessarily from user space (it would have to be through SG_IO at that
point), and Reubens boot log doesn't have any evidence of anything of
that nature being started. So I'm guessing it's the flush, raid1
propagates these flushes to the bottom devices when it sees one.

Your analysis looks correct though, Reuben looking forward to hearing
whether this fixes your boot hang!

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVAMI4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVAMI4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVAMI4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:56:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18835 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261311AbVAMI4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:56:36 -0500
Date: Thu, 13 Jan 2005 09:56:33 +0100
From: Jens Axboe <axboe@suse.de>
To: "Paul A. Sumner" <paul@zanfx.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High write latency, iowait, slow writes 2.6.9
Message-ID: <20050113085633.GE2815@suse.de>
References: <41E4BB99.90908@zanfx.com> <cs44ai$oet$1@news.cistron.nl> <41E61C68.10801@zanfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E61C68.10801@zanfx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12 2005, Paul A. Sumner wrote:
> Thanks... I've tried the as, deadline and cfq schedulers. Deadline is
> giving me the best results. I've also tried tweaking the stuff in
> /sys/block/sda/queue/iosched/.
> 
> For lack of a better way of describing it, it seems like something is
> thrashing.

I you have time, I would like you to try current BK with this patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.11-rc1/cfq-time-slices-20.gz

You should enable CONFIG_IOPRIO_WRITE, it is in the io scheduler config
section, if you do a make oldconfig it should pop up for you. Boot with
elevator=cfq to select cfq.

A simple profile of the bad period would also be nice, along with
vmstat 1 info from that period. If you boot with profile=2, do:

# readprofile -r
# run bad workload
# readprofile | sort -nr +2 > result_file

And send that along with the logged vmstat 1 from that same period.

Oh, and lastly, remember to CC people on lkml when you respond, thanks.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbTFCO3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTFCO3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:29:19 -0400
Received: from ns.suse.de ([213.95.15.193]:16134 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265027AbTFCO3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:29:18 -0400
Date: Tue, 3 Jun 2003 16:42:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Counter-kludge for 2.5.x hanging when writing to block device
Message-ID: <20030603144254.GE4853@suse.de>
References: <200306030848.h538mwE22282@freya.yggdrasil.com> <20030603091018.GI482@suse.de> <20030603030023.69d39d6e.akpm@digeo.com> <20030603100255.GJ482@suse.de> <20030603032034.20202091.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603032034.20202091.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> >  > b) it should check that there are still requests in flight after parking
> >  >    itself on the waitqueue rather than relying on the timeout.
> > 
> >  This is important, would be much nicer to pass in the backing dev. This
> >  is a big problem, imho. It's broken right now.
> 
> The throttling is not really a per-device concept.  It is a "global"
> concept.
> 
> If a process has written to a really slow device and has encountered
> throttling due to exceeded dirty memory limits, we _do_ want to wake that
> process up (to reevaluate the system state) if a bunch of writes terminate
> against a fast device.
> 
> There is a fixed amount of system memory which the administrator has
> dedicated to buffering of dirty-and-writeback data and I believe that not
> discriminating between different bandwidth devices will give the overall
> lowest latency.  This may be wrong, and maybe we do want to throttle tasks
> which write to slow devices more heavily.
> 
> Or place the device's nominal bandwidth in the backing_dev_info, account
> for dirty memory on a per-queue basis and limit the permissible amount of
> dirty memory against slower devices.  That's probably not too hard to do
> but I'm not sure that the combination of slow and fast devices both under
> heavy writeout at the same time is common enough to justify it.

Per process slow vs fast device is probably not common enough to justify
any changes, as long as we deal correctly with fast vs slow globally.

But your mail explains it nicely, thanks.

-- 
Jens Axboe


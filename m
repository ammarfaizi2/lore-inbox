Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbULCJj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbULCJj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbULCJj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:39:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38102 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262121AbULCJjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:39:35 -0500
Date: Fri, 3 Dec 2004 10:39:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041203093903.GE10492@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203012645.21377669.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2004, Andrew Morton wrote:
> "Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
> >
> > > Can you try with the patch that is in the parent of this thread? The
> >  > above doesn't look that bad, although read performance could be better
> >  > of course. But try with the patch please, I'm sure it should help you
> >  > quite a lot.
> >  > 
> > 
> >  It actually got worse: Though the read rate seems accepteble, it is not, as 
> >  interactivity is dead while writing.
> 
> Is this a parallel IDE system?  SATA?  SCSI?  If the latter, what driver
> and what is the TCQ depth?

Yeah, that would be interesting to know. Or of the device is on dm or
raid. And what filesystem is being used?

TCQ depth doesn't matter with cfq really, as you can fully control how
big you go with the drive (default is 4) with max_depth.

Running buffer reads and writes here with new cfq, I get about ~7MiB/sec
read and ~14MiB/sec write aggregate performance with 4 clients (2 of
each) with the default settings. If I up idle period to 6ms and slice
period to 150ms, I get ~13MiB/sec read and ~11MiB/sec write aggregate
for the same run.

So Prakash, please try the same test with those settings:

# cd /sys/block/<dev>/queue/iosched
# echo 6 > idle
# echo 150 > slice

These are the first I tried, there may be better settings. If you have
your filesystem on dm/raid, you probably want to do the above for each
device the dm/raid is composed of.


-- 
Jens Axboe


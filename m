Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVJGHW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVJGHW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVJGHW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:22:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49168 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750802AbVJGHW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:22:56 -0400
Date: Fri, 7 Oct 2005 09:23:33 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add sysfs to dynamically control blk request tag maintenance
Message-ID: <20051007072328.GO2889@suse.de>
References: <200510070246.j972kig22629@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510070246.j972kig22629@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06 2005, Chen, Kenneth W wrote:
> blk_queue_start_tag and blk_queue_end_tag are called for tagging
> I/O to scsi device that is capable of tcq. blk_queue_find_tag is
> a function that utilizes the tag information built up on every I/O.
> 
> However, there aren't many consumers for blk_queue_find_tag, except
> NCR53c700 and tekram-dc390.  Vast majority of scsi drivers don't
> use these tag currently.  So why bother build them at the beginning
> of an I/O and then tear it all down at the end, all doing hard work
> but no other functions in the kernel appears to care.
> 
> Is there another big scheme in the works to use these tags?  If not,
> I'd like to propose we add a sysfs attribute to dynamically control
> whether kernel maintains blk request tag or not.  This has performance
> advantage that we don't needlessly waste CPU cycle on things we throw
> away without using them. Would the following patch be acceptable?
> Comments?

I don't understand the need for this patch - the generic tagging is only
used if the SCSI LLD indicated it wanted it by issuing a
scsi_activate_tcq(). So blk_queue_start_tag() is only called if the LLD
already did a scsi_activate_tcq(), and blk_queue_end_tag() is only
called if the rq is block layer tagged. blk_queue_find_tag() is only
used with direct use of scsi_find_tag(), a function that should (and is)
only usable by users of the generic tagging already.

So please, a description of what problem you are trying to solve would
be appreciated :-)

-- 
Jens Axboe


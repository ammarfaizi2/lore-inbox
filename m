Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWBHPuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWBHPuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWBHPuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:50:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34119 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030361AbWBHPuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:50:20 -0500
Date: Wed, 8 Feb 2006 16:52:43 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [SCSI] fix wrong context bugs in SCSI
Message-ID: <20060208155242.GO4338@suse.de>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com> <1139342922.6065.12.camel@mulgrave.il.steeleye.com> <20060208085629.GE4338@suse.de> <1139412662.3003.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139412662.3003.5.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08 2006, James Bottomley wrote:
> On Wed, 2006-02-08 at 09:56 +0100, Jens Axboe wrote:
> > Hmm, this (and further up) could fail, yet you don't check.
> 
> By and large, you have process context, so this isn't going to be a
> problem.
> 
> > I don't think this API is very nice to be honest, there's no good way to
> > handle failures - you can't just sleep and loop retry the execute if you
> > are in_interrupt(). I'd prefer passing in a work_queue_work (with a
> > better name :-) that has been allocated at a reliable time during
> > initialization.
> 
> Yes, I agree ... however, the failure is less prevalent in the new code
> than the old.  The problem is that we may need to execute multiple puts
> for a single target from irq contex, so under this scheme you need a wqw
> (potentially) for every get.
> 
> I could solve this by binding the API more tightly into the device
> model, so the generic device contains the wqw and it is told that the
> release function of the final put must be called in process context, but
> that's an awful lot of code changes.

Yeah it does get a lot more complicated. I guess I'm fine with the
current change, but please just keep it in SCSI then. It's not the sort
of thing you'd want to advertise as an exported API.

-- 
Jens Axboe


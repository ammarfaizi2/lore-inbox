Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWHNHdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWHNHdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWHNHdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:33:11 -0400
Received: from brick.kernel.dk ([62.242.22.158]:42256 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751916AbWHNHdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:33:10 -0400
Date: Mon, 14 Aug 2006 09:34:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-ID: <20060814073448.GI4231@suse.de>
References: <20060810110627.GM11829@suse.de> <20060812162857.d85632b9.akpm@osdl.org> <20060812.174324.77324010.davem@davemloft.net> <20060812174549.9a8f8aeb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060812174549.9a8f8aeb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12 2006, Andrew Morton wrote:
> On Sat, 12 Aug 2006 17:43:24 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Andrew Morton <akpm@osdl.org>
> > Date: Sat, 12 Aug 2006 16:28:57 -0700
> > 
> > > Maybe I missed the discussion.  But if not, this is yet another case of
> > > significant changes getting into mainline via a git merge and sneaking
> > > under everyone's radar.
> > 
> > Scsi has been doing command completions via a per-cpu softirq handler
> > for as long as we've had an SMP more advanced than lock_kernel() :-)
> 
> Is that also adding 150 usecs to each IO operation?

It is, it's the identical mechanism. SCSI used to do completions via
tasklets, it was converted to softirqs a long time ago but I don't think
anyone ever did timings on it to my knowledge... From the few timings I
showed, 150 usec is a _best_ case time on my hardware. 10 msecs was seen
as well, which is just bad beyond describing.

My suggestion (I'll code this up) is that we scrap the softirq
completion and just do it from the irq event. The typical completion
doesn't even need to grab any locks.

-- 
Jens Axboe


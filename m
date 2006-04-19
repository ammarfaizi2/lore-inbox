Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWDSVxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWDSVxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWDSVxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:53:08 -0400
Received: from waste.org ([64.81.244.121]:15596 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751259AbWDSVxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:53:07 -0400
Date: Wed, 19 Apr 2006 16:49:59 -0500
From: Matt Mackall <mpm@selenic.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
Message-ID: <20060419214959.GR15445@waste.org>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 05:13:27PM +0100, Hugh Dickins wrote:
> On Wed, 19 Apr 2006, Jeff Chua wrote:
> > 
> > Any change of getting suspend/resume to work on my IBM X60s notebook.
> > 
> > Disk model is ...
> > 
> > 	MODEL="ATA HTS541060G9SA00"
> > 	FW_REV="MB3I"
> > 
> > Linux 2.6.17-rc2.
> > 
> > System suspends ok. Resume ok. but no disk access after that.
> 
> Not the same disk model, but I've been having similar trouble on a T43p.
> 
> I was delighted to see the MSI suspend/resume fix go into 2.6.17-rc2,
> but then disappointed.  A bisection found that Matt Mackall's sensible
> rc1 patch, to speed up get_cmos_time, has removed what often used to be
> a 2 second delay in resuming: things work well when I reinstate that
> delay (1 second has proved not enough).  Below is the patch I'm using -
> where I've failed to resist mucking around to avoid those double calls
> to get_cmos_time, sorry: really it's just mdelay(2000) needed somewhere
> (until someone who knows puts in something more scientific).

That's interesting.

Just to be clear, with my changes we should never fire timers early.
Is the problem that we have a timer that didn't get deleted at suspend
time?

-- 
Mathematics is the supreme nostalgia of our time.

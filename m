Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbULCKtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbULCKtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbULCKtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:49:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60550 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262150AbULCKtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:49:19 -0500
Date: Fri, 3 Dec 2004 11:48:28 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041203104828.GJ10492@suse.de>
References: <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org> <20041203093903.GE10492@suse.de> <41B03722.5090001@gmx.de> <20041203103130.GH10492@suse.de> <20041203103828.GI10492@suse.de> <41B043AF.3070503@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B043AF.3070503@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
> Jens Axboe schrieb:
> >On Fri, Dec 03 2004, Jens Axboe wrote:
> >
> >>Funky. It looks like another case of the io scheduler being at the wrong
> >>place - if raid sends dependent reads to different drives, it screws up
> >>the io scheduling. The right way to fix that would be to io scheduler
> >>before raid (reverse of what we do now), but that is a lot of work. A
> >>hack would be to try and tie processes to one md component for periods
> >>of time, sort of like cfq slicing.
> >
> >
> >It makes sense to split the slice period for sync and async requests,
> >since async requests usually get a lot of requests queued in a short
> >period of time. Might even make sense to introduce a slice_rq value as
> >well, limiting the number of requests queued in a given slice.
> >
> >But at least this patch lets you set slice_sync and slice_async
> >seperately, if you want to experiement.
> 
> An idea, which values I should try?

Just see if the default ones work (or how they work :-)

> In generell I rather have the impression the problem I am experiencing 
> is not the problem of the io scheduler alone or why do all show the same 
> problem?

It is not, but some io schedulers perform better than others.

> BTW, I just did my little test on the ide drive and it shows the same 
> problem, so it is not sata / libata related.

Single read/writer case works fine here for me, about half the bandwidth
for each. Please show some vmstats for this case, too. Right now I'm not
terribly interested in problems with raid alone, as I can poke holes in
that. If the single drive case is correct, then we can focus on raid.

-- 
Jens Axboe


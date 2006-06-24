Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752199AbWFXLIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbWFXLIo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 07:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbWFXLIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 07:08:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49433 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751559AbWFXLIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 07:08:43 -0400
Date: Sat, 24 Jun 2006 13:10:00 +0200
From: Jens Axboe <axboe@suse.de>
To: James <iphitus@gmail.com>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] fcache: a remapping boot cache
Message-ID: <20060624110959.GQ4083@suse.de>
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de> <20060516074628.GA16317@suse.de> <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com> <20060531061234.GC29535@suse.de> <1e1a7e1b0606232044x11136be5p332716b757ecd537@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1a7e1b0606232044x11136be5p332716b757ecd537@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24 2006, James wrote:
> Set this up on my laptop yesterday with some awesome results. I'm
> using 2.6.17-ck1 which has v2.1.
> 
> Heres some bootcharts, before, after, and a prime run.
> 
> http://archlinux.org/~james/normal.png
> http://archlinux.org/~james/fs-fcache.png
> http://archlinux.org/~james/fs-fcache-prime.png
> 
> Repeated boots show about the same 6 second improvement, 32 down to 26
> seconds. Looking at the slowdowns in the fs-fcache run, most are due
> to cpu load, waiting on network or, modprobe, and not disk access. X
> now starts nearly instantaneously.
> 
> As an experiment, I primed my cache right through to logging into my
> desktop environment. It was so effective, that now when I login, the
> GNOME splash screen only flickers onto the screen briefly, and the
> panels appear almost instantly. This is a big improvment over without
> fcache, where you'd see each component of GNOME being loaded on the
> splash screen, nautilus, metacity, and the panels would take quite a
> bit of time to render and load all their applets.
> 
> Impressive work, I hope to see it broadened to other filesystems,
> improved and merged to vanilla soon because it has clear improvements.

Thanks for giving it a spin! I have plans to implement some improvements
on monday that will speed it up even more, I hope I can talk you into
retesting it then. Basically it make sure we always get full speed out
of the drive by extending the 4kb reads with a sliding window cache.
That will help both drive efficiency, and also speed up the cases where
sub sequent boots differ just a little bit from the primed boot (often
the case with parallel init scripts). It should win you a few seconds
more in total, would be my guess.

I hope to be able to extend it to xfs and reiser in the very near future
as well, should not be hard to do.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUGZU42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUGZU42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUGZUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:55:56 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:62361 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265978AbUGZUmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:42:33 -0400
Date: Mon, 26 Jul 2004 22:42:28 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: no luck with max_sectors_kb (Re: voluntary-preempt-2.6.8-rc2-J4)
Message-ID: <20040726204228.GA1231@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040726101536.GA29408@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726101536.GA29408@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Changes since -J3:
> > 
> >  - make block device max_sectors sysfs tunable. There's a new entry
> >    /sys/block/*/queue/max_sectors_kb which stores the current max 
> >    request size in KB. You can write it to change the size.
> > 
> > [...]
>
> i've refined the patch (new version attached below): drivers use
> blk_queue_max_sectors() to set the maximum # of sectors that the driver
> or hw can handle.
> 
> so i've introduced a new queue entry called max_hw_sectors, and the new
> /sys entry listens to this maximum and only updates max_sectors. This
> entry is also exported to /sys as a readonly entry. (so that users can
> see the maximum the driver supports.)

Hi there.

I do not seem to have success with tuning the max_sectors_kb value.

After setting it to 32 (the hw max is 128), userland programs fail with I/O
errors. Setting it back to 128 gets it back to working, sort of. The errors
probably get bufferred somewhere.

During the "bad" setting (32), messages like this one show up in kernel log.

bio too big device hda3 (104 > 64)

I am using J7 voluntary_preemption patch (set at 2:1), cfq io scheduler,
via82cxxx IDE driver. I will gladly provide further details.

Rudo.

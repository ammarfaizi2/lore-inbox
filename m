Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbULNNhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbULNNhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbULNNhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:37:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14979 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261507AbULNNh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:37:27 -0500
Date: Tue, 14 Dec 2004 14:37:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced cfq with basic io priorities
Message-ID: <20041214133725.GG3157@suse.de>
References: <20041213125046.GG3033@suse.de> <20041213130926.GH3033@suse.de> <20041213175721.GA2721@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213175721.GA2721@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version -12 has been uploaded. Changes:

- Small optimization to choose next request logic

- An idle queue that exited would waste time for the next process

- Request allocation changes. Should get a smooth stream for writes now,
  not as bursty as before. Also simplified the may_queue/check_waiters
  logic, rely more on the regular block rq allocation congestion and
  don't waste sys time doing multiple wakeups.

- Fix compilation on x86_64

No io priority specific fixes, the above are all to improve the cfq time
slicing.

For 2.6.10-rc3-mm1:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-12-2.6.10-rc3-mm1.gz

For 2.6-BK:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-12.gz

-- 
Jens Axboe


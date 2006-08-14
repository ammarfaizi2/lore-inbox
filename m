Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751938AbWHNIov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbWHNIov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWHNIov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:44:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30665
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751938AbWHNIou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:44:50 -0400
Date: Mon, 14 Aug 2006 01:44:48 -0700 (PDT)
Message-Id: <20060814.014448.30183193.davem@davemloft.net>
To: axboe@suse.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060814073724.GJ4231@suse.de>
References: <20060812.180944.51301787.davem@davemloft.net>
	<20060812182234.605b4fb4.akpm@osdl.org>
	<20060814073724.GJ4231@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
Date: Mon, 14 Aug 2006 09:37:25 +0200

> Hopefully you often end up doing > 1 request for a busy IO sub system,
> otherwise the softirq stuff is pointless. But it's still pretty bad for
> single requests.

Note that the per-cpu softirq completion of I/O events means
that the queue can be processed lockless.

I'm not saying this justifies softirq I/O completion, I'm just
mentioning it as one benefit of the scheme.  This is also why
networking uses softirqs for the core irq events instead of
tasklets.

It appears the scsi code uses hw IRQ locking for all of it's
locking so that should be fine.

However there might be some scsi exception handling dependencies
on the completions being run in software irq context, but this is
just a guess.

iSCSI would need to be checked out too.


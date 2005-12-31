Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVLaKet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLaKet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 05:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLaKes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 05:34:48 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:30658 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932125AbVLaKes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 05:34:48 -0500
Date: Sat, 31 Dec 2005 11:34:46 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051231113446.3ad19dbc@localhost>
In-Reply-To: <43B5E78C.9000509@bigpond.net.au>
References: <20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<20051230145221.301faa40@localhost>
	<43B5E78C.9000509@bigpond.net.au>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 13:06:04 +1100
Peter Williams <pwil3058@bigpond.net.au> wrote:

> Attached is a testing version of a patch for modifying scheduler bonus 
> calculations that I'm working on.  Although these changes aren't 
> targetted at the problem you are experiencing I believe that they may 
> help.  My testing shows that sched_fooler instances don't get any 
> bonuses but I would appreciate it if you could try it out.
> 
> It is a patch against the 2.6.15-rc7 kernel and includes some other 
> scheduling patches from the -mm kernels.

Yes, this fixes both my test-case (transcode & little program), they
get priority 25 instead of ~16.

But the priority of DD is now ~23 and so it still suffers a bit:

paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
128+0 records in
128+0 records out

real    0m8.549s	(instead of 4s)
user    0m0.000s
sys     0m0.209s

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-lial on x86_64

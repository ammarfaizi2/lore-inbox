Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTE2QgC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTE2QgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:36:02 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51635
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262367AbTE2Qf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:35:58 -0400
Date: Thu, 29 May 2003 18:49:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy TARREAU <willy@w.ods.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529164940.GS1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local> <200305291607.33211.m.c.p@wolk-project.de> <20030529160604.GA4985@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529160604.GA4985@pcw.home.local>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 06:06:04PM +0200, Willy TARREAU wrote:
> I also confirm it does ; it takes 122 seconds to write this file in -rc6, and
> 142 seconds in -aa. But I don't think that desktop people would notice anyway.

btw, were you running parallel reads or writes at the same time? (i.e.
launching xterms or ps etc.. in parallel?) I ask because if xterm
startups quick is because the write workload is getting more seeks in
its way.

I'd be very interested if you can measure a bonnie performance change in
contigous reads and writes on a otherwise completely idle machine, the
size of the queue has to be big enough to keep the I/O pipeline full
during contigous writes at full speed.  saying that throughput decrease
alone is not enough to evaluate the reason of this drop.

you can also try with:

	echo 20 500 0 0 500 3000 30 10 >/proc/sys/vm/bdflush

just in case.

Andrea

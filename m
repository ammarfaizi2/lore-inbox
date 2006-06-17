Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWFQHA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWFQHA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 03:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWFQHA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 03:00:56 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:24915 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932387AbWFQHAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 03:00:55 -0400
Message-ID: <4493A8A2.9040505@tls.msk.ru>
Date: Sat, 17 Jun 2006 11:00:50 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Wu Fengguang <wfg@mail.ustc.edu.cn>, Ingo Oeser <ioe-lkml@rameria.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
References: <20060609080801.741901069@localhost.localdomain> <349840680.03819@ustc.edu.cn> <200606102033.46844.ioe-lkml@rameria.de> <448B221D.3080907@tls.msk.ru> <350074764.23563@ustc.edu.cn> <448D4AC7.4040009@tls.msk.ru> <4493A354.4020602@tls.msk.ru>
In-Reply-To: <4493A354.4020602@tls.msk.ru>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Michael Tokarev wrote:
[]
> .....alot of similar errors skipped, with consequtive block numbers.
>    At this point (10:18), I hit Ctrl+C on the xterm where dd was running...
[]
> And finally here we go: the new logic triggered.  And the dd command
> unfroze as well (reacted to the interrupt).
[]
> So finally.. it looks like the whole thing is somewhere else still.
> The last batch of messages shows exactly the previous behaviour
> (numerous attempts to read quite alot of failing sectors, which
> takes quite some time too - depending on the CD-ROM drive alot),
> BEFORE the new RA-reducing logic gets triggered.

I forgot to add: when turning RA off for the device before reading
the disk, read errors are propagated to the application quickly,
without those long delays and attempts to read all the bad blocks.
Ofcourse (with conv=noerror), dd will request next blocks anyway,
but it stays responsive still, and reports each error quickly.

The patch helps still: after first batch of attempts to read,
RA gets reduced, when follows next (much smaller) batch, and
finally RA is set to 0, and the above 'quick route' (as if
RA was turned off initially) takes effect.

/mjt

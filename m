Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTE3X0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbTE3X0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:26:11 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:64460 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264061AbTE3X0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:26:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Neil Schemenauer <nas@python.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Date: Sat, 31 May 2003 09:40:41 +1000
User-Agent: KMail/1.5.1
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Matt <matt@lpbproductions.com>
References: <20030530220923.GA404@glacier.arctrix.com>
In-Reply-To: <20030530220923.GA404@glacier.arctrix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305310940.41780.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 08:09, Neil Schemenauer wrote:
> The major benefit of this patch is that read latency is much lower while
> lots of writes are occuring.  On my machine, running:
>
>  while :; do dd if=/dev/zero of=foo bs=1M count=1000 conv=notrunc; done
>
> makes 2.4.20 unusable.  With this patch the "write bomb" causes no
> particular problems.
>
> With this version of the patch I've improved the bulk read performance
> of the elevator.  The bonnie++ results are now:
>
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
>                Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
> 2.4.20           1G 13001  97 34939  18 13034   7 12175  92 34112  14
> 2.4.20-nas       1G 12923  98 36471  17 13340   8 10809  83 35569  13
>
> Note that the "rewrite" and "per-char read" stats are slightly bogus for
> 2.4.20-nas.  Reads get a boost in priority over writes.  When the
> "per-char read" test has started there is still some writing happening
> from the rewrite test.  I think the net effect is that the "rewrite"
> number is too high and the "per-char read" number is too low.
>
> I would be very pleased if someone could run some tests on using bonnie,
> contest, or their other favorite benchmarks and post the results.

Nice to see 2.4 getting some attention. I'll try and get around to contesting 
it.

How does this compare to akpm's read-latency2 patch that he posed some time 
ago? That seems to make a massive difference but was knocked back for style 
or approach.

Con

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbTFFInr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 04:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTFFInr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 04:43:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60817 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265135AbTFFInq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 04:43:46 -0400
Date: Fri, 6 Jun 2003 10:56:15 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: __check_region in ide code?
In-Reply-To: <20030606080454.89EC12C018@lists.samba.org>
Message-ID: <Pine.SOL.4.30.0306061053040.15859-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Jun 2003, Rusty Russell wrote:

> Hi Bart,

Hi Rusty,

> 	I notice that drivers/ide/ide-probe.c's hwif_check_region()
> still uses check_region().  If it really does want to use it to probe
> and not reserve, I think we should stop it warning there.
>
> 	There's nothing inherently *wrong* with check_region, it's
> just deprecated to trap the old (now racy) idiom of "if
> (check_region(xx)) reserve_region(xx)".  There's no reason not to
> introduce a probe_region if IDE really wants it.

And ide-probe.c does exactly this racy stuff.

I did patch to convert it to request_region() some time ago,
I just need to double check it and submit.

Thanks,
--
Bartlomiej

> Of course, some people will start "fixing" drivers by
> s/check_region/probe_region/ when we do this, but that's the risk we
> take.
>
> It should also allow us to easily get rid of that stupid warning in
> ksyms.c...
>
> Thoughts?
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.



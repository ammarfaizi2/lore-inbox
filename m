Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTJ1VSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTJ1VSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:18:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:65170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261552AbTJ1VSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:18:14 -0500
Date: Tue, 28 Oct 2003 13:18:44 -0800
From: Dave Olien <dmo@osdl.org>
To: cliff white <cliffw@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, mhf@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
Message-ID: <20031028211844.GA8285@osdl.org>
References: <200310261201.14719.mhf@linuxmail.org> <20031027145531.2eb01017.cliffw@osdl.org> <3F9DAF2C.8010308@cyberone.com.au> <20031028092612.68d1c80d.cliffw@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028092612.68d1c80d.cliffw@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, it seems Nick's latest patch from 10/27, has helped reaim
considerably.

The dbt2 workload still has a problem though.  Mary ran this patch today,
with deadline and with as-iosched:

2.6.0-test9, elevator=deadline			1644 NOTPM 
2.6.0-test9, unpatched as-iosched		 977 NOTPM
2.6.0-test9, as-iosched with as-fix.patch	 980 NOTPM

Higher NOTPM numbers are better.

On Tue, Oct 28, 2003 at 09:26:12AM -0800, cliff white wrote:
> > cliff white wrote:
> 
> So far, looks quite good. ( i know 2.4.18 is wierd for some, but they were
> hot off the stp, so i used 'em )
> 
> 4-cpu
> STP id Kernel Name         MaxJPM      Change  Options
> 282391 linux-2.4.18        5250.23     0.00	
> 282413 Nick's patch	   5484.95     4.27   elevator=deadline
> 282413 Nick's patch        5416.51     3.06
> 
> 282395 linux-2.4.18        6581.17     0.0
> 282415 Nick's patch        8293.95     20.6
> 282415 Nick's patch        8484.95     22.43 elevator=deadline
> 
> And, the graph is nice and flat!
> http://khack.osdl.org/stp/282416/results/jpm.png
> 
> Full results: http://developer.osdl.org/cliffw/reaim/index.html
> 
> Any test detail: http://khack.osdl.org/stp/<STP id>
> 
> cliffw
> 
> > 
> 
> 
> -- 
> The church is near, but the road is icy.
> The bar is far, but i will walk carefully. - Russian proverb
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

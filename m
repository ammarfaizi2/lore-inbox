Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267004AbTGOJpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267020AbTGOJpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:45:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40147
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267004AbTGOJpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:45:01 -0400
Date: Tue, 15 Jul 2003 11:59:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715095930.GH30537@dualathlon.random>
References: <20030714224528.GU16313@dualathlon.random> <1058229360.13317.364.camel@tiny.suse.com> <20030714175238.3eaddd9a.akpm@osdl.org> <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de> <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de> <20030715070314.GD30537@dualathlon.random> <20030715082850.GH833@suse.de> <1058260347.4012.11.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058260347.4012.11.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 05:12:28AM -0400, Chris Mason wrote:
> On Tue, 2003-07-15 at 04:28, Jens Axboe wrote:
> 
> > Definitely, because prepare to be a bit disappointed. Here are scores
> > that include 2.4.21 as well:
> 
> > io_load:
> > Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.21                 3        543     49.7    100.4   19.0    4.08
> > 2.4.22-pre5            3        637     42.5    120.2   18.5    4.75
> > 2.4.22-pre5-axboe      3        540     50.0    103.0   18.1    4.06
> 
> Huh, this is completely different than io_load on my box (2P scsi, ext3,
> data=writeback)
> 
> io_load:
> Kernel      [runs]      Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21           3      520     52.5    27.8    15.2    3.80
> 2.4.22-pre5      3      394     69.0    21.5    15.4    2.90
> 2.4.22-sync      3      321     84.7    16.2    15.8    2.36

this is what I remeber from Con's results too when he benchmarked my
first trees where I introduced the lowlatency elevator. I thought it was
the 4M queue that screwed stuff but clearly 4M is still way better than
2.4.21 stock. it's an exponential thing, I remeber very well, the huge
degradation from 2M to 4M, or at 1M for example the responsiveness is
istant an order of magnitude better than 2M. It's not a linear response.
So I thought the 4M thing hidden the benefits after reading Jens's
number, but it was quite surprising anyways since in 2.4.21 the queue is
way bigger than 4M anyways that puts all reads at the end with an huge
delay compared to pre5.

> Where 2.4.22-sync was the variant I posted yesterday.  I don't really
> see how 2.4.21 can get numbers as good as 2.4.22-pre5 on the io_load
> test, the read starvation with a big streaming io is horrible.

Agreed, something looked strange. Maybe it's some scsi/ide variable that
makes the difference, dunno. I tested this stuff on scsi IIRC though
(not that it should make any huge difference either ways though).

> BTW, the contest run times vary pretty wildy.  My 3 compiles with
> io_load running on 2.4.21 were 603s, 443s and 515s.  This doesn't make
> the average of the 3 numbers invalid, but we need a more stable metric.

we definitely need many many more runs if the variance is so huge. And
it's not surprising it's so huge, the variable block allocation as well
plays a significant role.

Andrea

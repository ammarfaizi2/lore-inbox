Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTGOI7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbTGOI7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:59:06 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:39379 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S265591AbTGOI7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:59:01 -0400
Subject: Re: RFC on io-stalls patch
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20030715082850.GH833@suse.de>
References: <20030714202434.GS16313@dualathlon.random>
	 <1058214881.13313.291.camel@tiny.suse.com>
	 <20030714224528.GU16313@dualathlon.random>
	 <1058229360.13317.364.camel@tiny.suse.com>
	 <20030714175238.3eaddd9a.akpm@osdl.org>
	 <20030715020706.GC16313@dualathlon.random> <20030715054551.GD833@suse.de>
	 <20030715060101.GB30537@dualathlon.random> <20030715060857.GG833@suse.de>
	 <20030715070314.GD30537@dualathlon.random>  <20030715082850.GH833@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1058260347.4012.11.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Jul 2003 05:12:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 04:28, Jens Axboe wrote:

> Definitely, because prepare to be a bit disappointed. Here are scores
> that include 2.4.21 as well:

> io_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.21                 3        543     49.7    100.4   19.0    4.08
> 2.4.22-pre5            3        637     42.5    120.2   18.5    4.75
> 2.4.22-pre5-axboe      3        540     50.0    103.0   18.1    4.06

Huh, this is completely different than io_load on my box (2P scsi, ext3,
data=writeback)

io_load:
Kernel      [runs]      Time    CPU%    Loads   LCPU%   Ratio
2.4.21           3      520     52.5    27.8    15.2    3.80
2.4.22-pre5      3      394     69.0    21.5    15.4    2.90
2.4.22-sync      3      321     84.7    16.2    15.8    2.36

Where 2.4.22-sync was the variant I posted yesterday.  I don't really
see how 2.4.21 can get numbers as good as 2.4.22-pre5 on the io_load
test, the read starvation with a big streaming io is horrible.

The data=writeback is changing the workload significantly, I used it
because I didn't want the data=ordered code to flush all dirty buffers
every 5 seconds.  I would expect ext3 data=ordered to be pretty
starvation prone in 2.4.21 as well though.

BTW, the contest run times vary pretty wildy.  My 3 compiles with
io_load running on 2.4.21 were 603s, 443s and 515s.  This doesn't make
the average of the 3 numbers invalid, but we need a more stable metric.

-chris



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUEDXSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUEDXSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUEDXSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:18:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:60141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbUEDXSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:18:14 -0400
Date: Tue, 4 May 2004 16:20:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Kopytov <alexeyk@mysql.com>
Cc: linuxram@us.ibm.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040504162037.6deccda4.akpm@osdl.org>
In-Reply-To: <200405050301.32355.alexeyk@mysql.com>
References: <200405022357.59415.alexeyk@mysql.com>
	<1083683034.13688.7.camel@localhost.localdomain>
	<1083699554.13688.64.camel@localhost.localdomain>
	<200405050301.32355.alexeyk@mysql.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kopytov <alexeyk@mysql.com> wrote:
>
> Without the patch (but with Ram's patch applied):
> ------------------
> Time spent for test: 125.4429s
> 
> no of times window reset because of hits: 0
> no of times window reset because of misses: 127
> no of times window was shrunk because of hits: 1153
> no of times the page request was non-contiguous: 3968
> no of times the page request was contiguous : 10686
> 
> With the patch:
> ---------------
> Time spent for test:  86.5459s
> 
> no of times window reset because of hits: 0
> no of times window reset because of misses: 0
> no of times window was shrunk because of hits: 1066
> no of times the page request was non-contiguous: 5860
> no of times the page request was contiguous : 18099
> 

The patch brought my test box to the same speed as 2.4.  With the deadline
scheduler it was a bit faster than 2.4.  I didn't do a lot of testing
though.  I was using ext2.  Please try deadline.

> I wonder if there are some plans to further improve 2.6 behavior on this 
> workload to match that of 2.4?

Of course...

Tuning work is being done on the anticipatory scheduler which we hope will
bring it up to deadline throughput for this sort of workload.

> Is the remaing regression a result of the 
> different readahead handling, or it might be caused by IDE driver or I/O 
> scheduler tuning?

Don't know yet.  On 2.6 the test actually does about 5% fewer reads than
under 2.4, so the VM page replacement is working a bit better in this case.
 And 2.6 does about 40% fewer context switches for some reason.  So we
should be a little bit faster - it's a matter of finding where the
additional seeks or idle time are coming from.

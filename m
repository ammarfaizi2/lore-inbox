Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbTHLP3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270724AbTHLP3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:29:33 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38418 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270681AbTHLP3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:29:30 -0400
Message-ID: <3F390B36.5050709@techsource.com>
Date: Tue, 12 Aug 2003 11:43:50 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add an -Os config option
References: <20030811211145.GA569@fs.tum.de> <20030812080634.A19427@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig wrote:
> On Mon, Aug 11, 2003 at 11:11:45PM +0200, Adrian Bunk wrote:
> 
>>The patch below adds an option OPTIMIZE_FOR_SIZE (depending on EMBEDDED) 
>>that changes the optimization from -O2 to -Os.
> 
> 
> Please dropt the if EMBEDDED - this makes perfecty sense for lots of
> todays hardware..
> 
> In fact we should probably rather do some some benchmarking whether it
> would be a good idea to make -Os the default.


Interesting thought...  In reality, we want the system to spend as 
little time in the kernel as possible.  If we've done that job right, 
then optimizing for size shouldn't matter as much.  We're still spending 
most of our time in user space.

Furthermore, it may be that we could benefit from compiling some source 
files with -Os and others with -O2, depending on how critical they are 
and how much they are ACTUALLY affected.

So... we need profiling to determine what is used and how much.  And we 
need benchmarking to determine what is affected and by how much.  Over 
the next couple of years, it might be good for Linus and others to adopt 
a policy where the default optimization for individual files is 
determined based on experience and need.

If only 5% of the source files are compiled with -O2, that's not going 
to bloat the kernel much, we'll get an optimal balance of performance 
and size, and everyone will be happy.

We may find it valuable to divide up the sources differently.  There may 
be source files with both critical and noncritical functions that needed 
to be separated out so they can be compiled differently.

And while we're at it, if there is ever any benefit to -O3, that could 
be used on a per-file basis as well.

Comments?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUDWSLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUDWSLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 14:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUDWSLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 14:11:31 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:50442 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264902AbUDWSL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 14:11:26 -0400
Message-ID: <40895CFF.6010307@techsource.com>
Date: Fri, 23 Apr 2004 14:14:23 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <408951CE.3080908@techsource.com> <c6bjrd$pms$1@news.cistron.nl> <20040423174146.GB5977@thunk.org>
In-Reply-To: <20040423174146.GB5977@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Theodore Ts'o wrote:
> On Fri, Apr 23, 2004 at 05:30:21PM +0000, Miquel van Smoorenburg wrote:
> 
>>In article <408951CE.3080908@techsource.com>,
>>Timothy Miller  <miller@techsource.com> wrote:
>>
>>>Well, why not do the compression at the highest layer?
>>>[...] doing it transparently and for all files.
>>
>>http://e2compr.sourceforge.net/
> 
> 
> It's been done (see the above URL), but given how cheap disk space has
> gotten, and how the speed of CPU has gotten faster much more quickly
> than disk access has, many/most people have not be interested in
> trading off performance for space.  As a result, there are race
> conditions in e2compr (which is why it never got merged into
> mainline), and there hasn't been sufficient interest to either (a)
> forward port e2compr to more recent kernels revisions, or (b) find and
> fix the race conditions.

Well, performance has been my only interest.  Aside from the embedded 
space (which already uses cramfs or something, right?), the only real 
benefit to FS compression is the fact that it would reduce the amount of 
data that you have to read from disk.  If your IDE drive gives you 
50MB/sec, and your file compresses by 50%, then you get 100MB/sec 
reading that file.

In a private email, one gentleman (who can credit himself if he likes) 
pointed out that compression doesn't reduce the number of seeks, and 
since seek times dominate, the benefit of compression would diminish.

SO... in addition to the brilliance of AS, is there anything else that 
can be done (using compression or something else) which could aid in 
reducing seek time?

Nutty idea:  Interleave files on the disk.  So, any given file will have 
its blocks allocated at, say, intervals of every 17 blocks.  Make up for 
the sequential performance hit with compression or something, but to get 
to the beginning of groups of files, seek time is reduced.  Maybe. 
Probably not, but hey.  :)

Another idea is to actively fragment the disk based on access patterns. 
  The most frequently accessed blocks are grouped together so as to 
maximize over-all throughput.  The problem with this is that, well, say 
boot time is critical -- booting wouldn't happen enough to get enough 
attention so that its blocks get optimized (they would get dispersed as 
a result of more common activities); but database access could benefit 
in the long-term.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUC1AQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUC1AQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:16:56 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:3996 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262006AbUC1APa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:15:30 -0500
Message-ID: <4066191E.4040702@yahoo.com.au>
Date: Sun, 28 Mar 2004 10:15:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com>
In-Reply-To: <406616EE.80301@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Jeff Garzik wrote:
> 
>> It's up to the sysadmin to choose a disk scheduling policy they like, 
>> which implies that a _scheduler_, not each individual driver, should 
>> place policy limitations on max_sectors.
> 
> 
> 
> <tangent>
> 
> The block layer / scheduler guys should also think about a general (not 
> SCSI specific) way to tune TCQ tag depth.  That's IMO another policy 
> decision.
> 
> I'm about to add a raft of SATA-2 hardware, all of which are queued. The 
> standard depth is 32, but one board supports a whopping depth of 256.
> 
> Given past discussion on the topic, you probably don't want to queue 256 
> requests at a time to hardware :)  But the sysadmin should be allowed 
> to, if they wish...

I think you could limit the number of in-flight requests quite
easily, even for drivers that do not use the block layer's
queueing functions.

Aside, you should make 2 or 4 tags the default though: that
still gives you the pipelining without sacrificing latency
and usibility.

The only area (I think) where large queues outperform the IO
scheduler are lots of parallel, scattered reads. I think this
is because the drive can immediately return cached data even
though it looks like a large seek to the IO scheduler.
(This is from testing on my single, old SCSI disk though.)

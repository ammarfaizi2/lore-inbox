Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWJXW2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWJXW2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbWJXW2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:28:00 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:44833 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161289AbWJXW17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:27:59 -0400
Message-ID: <453E9368.9070405@de.ibm.com>
Date: Wed, 25 Oct 2006 00:27:52 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E79D1.6070703@cfl.rr.com>
In-Reply-To: <453E79D1.6070703@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> This discussion seems to involve two different solutions to two 
> different problems.  If it is a simple counter you want to be able to 
> poll, then sysfs/debugfs is an appropriate place to make the count 
> available.  If it is a detailed log of IO requests that you are after, 
> then blktrace is appropriate.

It's about counters ... well, sometimes a buch of counters called
histogram.

> I did not read the patch to see, so I must ask: does it merely keep 
> statistics or does it log events?  If it is just statistics you are 
> after, then clearly blktrace is not the appropriate tool to use.

If matters were as simple as that, sigh.

Statistics feed on data reported through events.
"Oh, this request has completed - time to update I/O counters."

The tricky question is: is event processing, that is, statistics data
aggregation, better done later (in user space), or immediately
(in the kernel). Both approaches exist: blktrace/btt vs.
gendisk statistics used by iostat, for example.

My feeling was that the in-kernel counters approach of my patch
was fine with regard to the purpose of these statistics. But blktrace
exists, undeniably, and deserves a closer look.

Martin


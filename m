Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUIMUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUIMUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUIMUW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:22:56 -0400
Received: from mail.tmr.com ([216.238.38.203]:24215 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S268928AbUIMUWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:22:19 -0400
Message-ID: <41460283.3020909@tmr.com>
Date: Mon, 13 Sep 2004 16:26:43 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@novell.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <20040910153421.GD24434@devserv.devel.redhat.com><593560000.1094826651@[10.10.2.4]> <1095016687.1306.667.camel@krustophenia.net>
In-Reply-To: <1095016687.1306.667.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2004-09-10 at 11:34, Arjan van de Ven wrote:
> 
>>On Fri, Sep 10, 2004 at 05:28:52PM +0200, Andrea Arcangeli wrote:
>>
>>>On Fri, Sep 10, 2004 at 05:15:38PM +0200, Arjan van de Ven wrote: 
>>>
>>>>What we should consider regardless is disable the nesting of irqs for
>>>>performance reasons but that's an independent matter
>>>
>>>disabling nesting completely sounds a bit too aggressive, but limiting
>>>the nesting is probably a good idea.
>>
>>disabling is actually not a bad idea; hard irq handlers run for a very short
>>time
> 
> 
> The glaring exception is the IDE io completion, which can run for 2000+
> usec even with a modern chipset and drive.  Here's a 600 usec trace:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7#/var/www/2.6.8-rc4-bk3-O7/ide_irq_latency_trace.txt
> 
> The timer, RTC, and soundcard interrupts (among others) will not like
> being delayed this long.  Ingo mentioned that this was not always done
> in hardirq context; presumaby the I/O completion was done in a softirq
> like SCSI.  What was the motivation for moving such a long code path
> into the hard irq handler?

Certainly if you run ppp the serial port won't like being ignored that 
long, and if you pull down data on a parallel port that really won't 
like it. The soundcard is probably only a problem if you're recording 
input, in spite of some posts here about skipping, the world doesn't end 
if you get a skip, although 2ms shouldn't cause that anyway.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbUKTH3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUKTH3w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUKTH3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:29:50 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:62614 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262926AbUKTH3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:29:35 -0500
Message-ID: <419EF257.8010103@yahoo.com.au>
Date: Sat, 20 Nov 2004 18:29:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au> <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au> <20041120071514.GO2714@holomorphy.com>
In-Reply-To: <20041120071514.GO2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>touch_nmi_watchdog() is only "protection" against local interrupt
>>>disablement triggering the NMI oopser because alert_counter[]
>>>increments are not atomic. Yet even supposing they were made so, the
> 
> 
> On Sat, Nov 20, 2004 at 05:49:53PM +1100, Nick Piggin wrote:
> 
>>That would be a bug in touch_nmi_watchdog then, because you're
>>racy against your own NMI too.
>>So I'm actually not very very wrong at all. I'm technically wrong
>>because touch_nmi_watchdog has a theoretical 'bug'. In practice,
>>multiple races with the non atomic increments to the same counter,
>>and in an unbroken sequence would be about as likely as hardware
>>failure.
>>Anyway, this touch nmi thing is going off topic, sorry list.
> 
> 
> No, it's on-topic.
> (1) The issue is not theoretical. e.g. sysrq t does trigger NMI oopses,
> 	merely not every time, and not on every system. It is not
> 	associated with hardware failure. It is, however, tolerable
> 	because sysrq's require privilege to trigger and are primarly
> 	used when the box is dying anyway.

OK then put a touch_nmi_watchdog in there if you must.

> (2) NMI's don't nest. There is no possibility of NMI's racing against
> 	themselves while the data is per-cpu.
> 

Your point was that touch_nmi_watchdog() which resets alert_counter,
is racy when resetting the counter of other CPUs. Yes it is racy.
It is also racy against the NMI on the _current_ CPU.

This has nothing whatsoever to do with NMIs racing against themselves,
I don't know how you got that idea when you were the one to bring up
this race anyway.

[ snip back-and-forth that is going nowhere ]

I'll bow out of the argument here. I grant you raise valid concens
WRT the /proc issues, of course.

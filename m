Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269678AbUJADKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269678AbUJADKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 23:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269668AbUJADKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 23:10:06 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:42367 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269678AbUJADJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 23:09:28 -0400
Message-ID: <415CCA61.5060209@yahoo.com.au>
Date: Fri, 01 Oct 2004 13:09:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: jmerkey@galt.devicelogics.com
CC: "Jeff V. Merkey" <jmerkey@drdos.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Robert Love <rml@novell.com>, Ankit Jain <ankitjain1580@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: processor affinity
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com> <41596F7F.1000905@drdos.com> <1096387088.4911.4.camel@betsy.boston.ximian.com> <41598B23.50702@drdos.com> <1096408318.13983.47.camel@localhost.localdomain> <415AE953.3070105@drdos.com> <415B71D0.3020100@yahoo.com.au> <20040930124708.GA2520@galt.devicelogics.com>
In-Reply-To: <20040930124708.GA2520@galt.devicelogics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@galt.devicelogics.com wrote:
> On Thu, Sep 30, 2004 at 12:39:12PM +1000, Nick Piggin wrote:

>>Of course, I don't really have any idea how to interpret patents...

    ^^^
keeping that in mind

> 
> The implementation in NetWare and the Implementation in Linux are 
> similiar but not identical, but they are close enough.  CPU bitmasks were 
> used.  The best apporach would be for someone to locate prior art in the 
> field and challenge the patent in the event any claims were ever brought
> or avoid the same methods.

It seems that the actual patent describes the implementation of the
scheduler that achieves this. And in it, the method used is a locked
global queue and unlocked local queues. But anyway.

> I was able to achieve greater than 
> 100% scaling per processor due to Intel's quirky cache behavior.

And probably most cache behaviours. If you have a set of tasks with
a working set larger than the cache of 1 processor but that can be
divided to fit into the cache of 2, then you're laughing.

More than 1 CPU can dramatically lower task switch (and mm switch)
rates in ideal situations, too.

> If 
> you can get a small subset of code in the cache controllers for 
> processes through hueristics (i.e. guessing) additive processor 
> scaling can be increased dramatically due to taking advantage
> of the L1 and L2 proceesor caches.  Linux is somewhat crude
> from an SMP perspective even today, although it has an impressive
> array of hardware support for SMP systems and architectures, but 
> based on the small number of processes than run on average (< 100)
> this technique would work on Linux.
> 

Well it has pretty strong  CPU affinity, and roughly distributes
load evenly over CPUs. What more do you want? :)

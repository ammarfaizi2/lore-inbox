Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWINPPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWINPPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWINPPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:15:14 -0400
Received: from dvhart.com ([64.146.134.43]:38369 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750755AbWINPPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:15:11 -0400
Message-ID: <450971CB.6030601@mbligh.org>
Date: Thu, 14 Sep 2006 08:14:19 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
In-Reply-To: <20060914112718.GA7065@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
>> Following an advice Christoph gave me this summer, submitting a 
>> smaller, easier to review patch should make everybody happier. Here is 
>> a stripped down version of LTTng : I removed everything that would 
>> make the code review reluctant (especially kernel instrumentation and 
>> kernel state dump module). I plan to release this "core" version every 
>> few LTTng releases and post it to LKML.
>>
>> Comments and reviews are very welcome.
> 
> i have one very fundamental question: why should we do this 
> source-intrusive method of adding tracepoints instead of the dynamic, 
> unintrusive (and thus zero-overhead) KProbes+SystemTap method?

Because:

1. Kprobes are more overhead when they *are* being used.
2. You can get zero overhead by CONFIG'ing things out.
3. (most importantly) it's a bitch to maintain tracepoints out
    of-tree on a rapidly moving kernel
4. I believe kprobes still doesn't have full access to local variables.


Now (3) is possibly solvable by putting the points in as no-ops (either
insert a few nops or just a marker entry in the symbol table?), but full
dynamic just isn't sustainable. What would be really nice is one trace
infrastructure, that allowed both static and dynamic tracepoints without
all the awk-style language crap that seems to come with systemtap.

M.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWIZAQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWIZAQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWIZAQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:16:19 -0400
Received: from gw.goop.org ([64.81.55.164]:19116 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751845AbWIZAQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:16:18 -0400
Message-ID: <45187146.8040302@goop.org>
Date: Mon, 25 Sep 2006 17:16:06 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal>
In-Reply-To: <20060925235617.GA3147@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Just as a precision :
>
> The following sequence (please refer to the code below for local symbols
> 1 and 2) :
>
> 1:
> preempt_disable()
> call (*__mark_call_##name)(format, ## args);
> preempt_enable_no_resched()
> 2:
>
> is insured because :
>
> 1 is part of an inline assembly with rw dependency on __marker_sequencer
> the call is surrounded by memory barriers.
> 2 is part of an inline assembly with rw dependency on __marker_sequencer
>   

What do you mean the call is surrounded by memory barriers?  Do you mean 
a call has an implicit barrier, or something else?

Either way, this doesn't prevent some otherwise unrelated 
non-memory-using code from being scheduled in there, which would not be 
executed.  The gcc manual really strongly discourages jumping between 
inline asms, because they have basically unpredictable results.

    J

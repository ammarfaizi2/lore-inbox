Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWIOObb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWIOObb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWIOObb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:31:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6019 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751528AbWIOOba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:31:30 -0400
Message-ID: <450AB90C.9000403@sgi.com>
Date: Fri, 15 Sep 2006 16:30:36 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <450A9D4B.1030901@sgi.com> <450AB408.8020904@opersys.com>
In-Reply-To: <450AB408.8020904@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Jes Sorensen wrote:
> There is in my view, and this is what this whole debate is really
> about, a clear difference in between the type of instrumentation
> being added. Clearly in the view of others there just isn't. But
> bare with me. I submit to you that there are 3 classes of trace
> points:
> 
> - OS-class: These are trace points which will be found in a given
>   kernel regardless of how it is implemented if it belongs to a
>   certain family of OSes. Linux being made to mimic Unix, it will
>   always have key events. And if you look closely at the initial
>   set of points added by ltt, these would be found in any Unix.
>   It's not for nothing that my paper on ltt was accepted at Usenix
>   2000 - and in fact during the question period somebody asked how
>   easy it would be to port it to BSD, and the answer: trivial.

There very few tracepoints in this category, the only things you can
claim are more or less generic are syscalls, and tracing syscall
handling is tricky.

> - Subsystem-class: These are trace points which are specific to
>   a given implementation. Say block tracing, scsi tracing, etc. as
>   they are implemented in Linux. The purpose of these is to allow
>   a user of these given subsystems to get more in-depth understanding
>   of what's happening inside the box.

This is grossly over simplifying things and why the whole things doesn't
hold water. There is no such thing as 'the place' to put a specific
tracepoint.

Especially when we start talking about things like tracepoints in the
scheduler.

Note that I haven't been referring to debug tracepoints at any point in
this debate.

>> It will be a drag because next week someone else wants a tracepoint
>> 5 lines further down the code! Again, I have seen people try and do
>> that on top of the old LTT patchsets, so maybe *you* didn't want the
>> tracepoint somewhere else, but some people did! Next?
> 
> Not if you understand the distinction I am making above.

Your distinction above doesn't hold water, but I did understand it
very well ....

You seem to think that it's fine to add instrumentation in the syscall
path as an example as long as it's compiled out. Well on some
architectures, the syscall path is very sensitive to alignment and there
may be restrictions on how large the stub of code is allowed to be, like
a few hundred bytes. Just because things work one way on x86, doesn't
mean they work like that everywhere.

Jes

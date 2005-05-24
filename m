Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVEXQJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVEXQJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVEXQIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:08:39 -0400
Received: from opersys.com ([64.40.108.71]:29962 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262134AbVEXQGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:06:50 -0400
Message-ID: <42935389.5030309@opersys.com>
Date: Tue, 24 May 2005 12:17:13 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Esben Nielsen <simlo@phys.au.dk>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com, Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk> <42933D71.8060706@opersys.com> <20050524152351.GA10489@elte.hu>
In-Reply-To: <20050524152351.GA10489@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> just to make sure, by "much more complicated" are you referring to the 
> PREEMPT_RT feature? Right now PREEMPT_RT consists of 8000 new lines of 
> code (of which 2000 is debugging code) and 2000 lines of modified kernel 
> code. One of the primary goals i had was to keep it simple and robust.

I'm refering to the complexity of the behavior. Turning interrupts to
threads and spinlocks to mutexes makes vanilla Linux's behavior much
more complicated than it already is. But before a bunch of mouth-foaming
rugby players tackle me to the ground, please keep in mind that this is
my appreciation of things. Others have claimed that they are perfectly
fine with this ...

> That's more than 3 times smaller than UML and it's almost an order of
> magnitude smaller than a nanokernel codebase i just checked, and it
> boots/works on just about everything where the stock Linux kernel boots.
> I challenge you to write a nanokernel/hypervisor with a comparable
> feature-set in that many lines of code.

No challenge needed, I'm not refering to codebase. No to mention that I'm
not even going to get near claiming knowing the kernel's guts anywhere
as much as you do :)

Here's running the risk of comparing apples to oranges:
$ ll adeos-linux-2.6.11-i386-r10c3.patch realtime-preempt-2.6.12-rc4-V0.7.47-07
-rw-rw-r--    1 karim    karim      195105 May 24 10:19 adeos-linux-2.6.11-i386-r10c3.patch
-rw-rw-r--    1 karim    karim      610509 May 24 00:14 realtime-preempt-2.6.12-rc4-V0.7.47-07

> anyway, as always, the devil is in the details. I certainly dont suggest 
> that nanokernels/hypervisors are not nice (to the contrary!), or that 
> all component technologies of the -RT patchset will be accepted into 
> Linux. PREEMPT_RT started out as an experiment to reduce scheduling 
> latencies within the constraints of the Linux kernel. It is not an 
> all-or-nothing feature, it's more of a collection of incremental 
> patches. It is one, nonexclusive way of doing things.

Here's from a previous posting back in october:
> development pace. Let's face it, no self-respecting effort that has
> ever labeled itself as wanting to provide "hard real-time Linux"
> has been active on the LKML on the same level as Ingo (though many
> have concentrated a lot of effort and talent on other lists.)

Clearly I recognize the work you have accomplished, and you are correct
in stating that the approach is nonexclusive. If the patch does indeed
make it into the kernel, then so be it. It's worth considering though
that there are other methods which can provide hard-rt without increasing
the kernel's complexity even when enabled; the most basic of which would
be turning the interrupt-handling/disable to function pointers. At the
next level, you could have something like the interrupt pipeline from
adeos on top (possibly as a loadable module), and at a third level you
could have something like RTAI/fusion (as additional loadable modules) ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

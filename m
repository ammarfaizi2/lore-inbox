Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUGBXzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUGBXzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUGBXzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:55:15 -0400
Received: from opersys.com ([64.40.108.71]:32523 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265107AbUGBXzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:55:01 -0400
Message-ID: <40E5EE80.8080307@opersys.com>
Date: Fri, 02 Jul 2004 19:23:44 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: peterm@redhat.com, faith@redhat.com, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com, trz@us.ibm.com, richardj_moore@uk.ibm.com,
       bob@watson.ibm.com, michel.dagenais@polymtl.ca
Subject: LTT kernel inclusion (was Re: [PATCH] IA64 audit support)
References: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>	<20040701124644.5e301ca0.akpm@osdl.org>	<40E4B20F.8010503@opersys.com>	<20040701182954.43351d36.akpm@osdl.org>	<40E4D4AD.2020302@opersys.com> <20040701231844.0aed5201.akpm@osdl.org>
In-Reply-To: <20040701231844.0aed5201.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> Note I said "developer", not "kernel developer".  If the audience for a
> feature is kernel developers, userspace developers and perhaps the most
> sophisticated sysadmins then that's a small audience.  It's certainly an
> _important_ audience, but the feature is not as important as those
> codepaths which Uncle Tillie needs to run his applications.
...
> To me, an "end user" is one who is capable of identifying the power switch
> and the ANY key, not an application programmer!

I must admit that I'm confused. In the context of how this thread started, I
have to ask what use Uncle Tillie has for kernel auditing. For that matter,
what does Uncle Tillie and the evil horde of ANY key worshipers have to do
with all the features that were added for power users and application
developers while LTT was still waiting in line?

If features such as UML, oprofile, audit, security hooks, vserver, etc.,
that are targeted at the same category of users that LTT is targeted at
can make it in the kernel, then I have a hard time understanding how
there could be any justification for refusing LTT's inclusion simply on
the basis that it doesn't benefit the least computer-literate of Linux
users.

If the inclusion algorithm is based on the following three priorities:
1- Uncle tillie and the evil horde of ANY key worshippers
2- Carnivorous pepsi-can super-users
3- Beaver on steroids kernel developers
with features in category N being more important than those of N+1,
shouldn't all features useful for category N be considered based on an
equal footing? I mean, there is a total and complete absence of any tool
to category 2 users that even closely resembles LTT and addresses the
needs I outlined in my earlier email, and yet features that are useful to
an even narrower group than LTT are routinely included in the kernel.

Given that there is a regular set of patches that are being included in
the kernel to cater for the same audience LTT is meant for, given the
importance of having such a tool for the purposes I outlined earlier,
and given that you've agreed that there is no issue with maintenance,
what else remains for us (the LTT development team) to do in order to
get LTT in the kernel? Should we just send you an updated set of patches
for review and inclusion?

>>On the topic of maintenance cost, I fail to see how one-liners such as the
>>above can be of any burden to any kernel developer, they have remained
>>virtually unchanged for the past 5 years and any look throughout the LTT
>>archives or the kernel mailing list archive for LTT patches will readily
>>show this.
> 
> Fair enough.

Great. Glad to see you agree. At least this one is crossed out.

> Nope, kprobes allows a kernel module to patch hooks into the running
> binary.  That's all it does, really.   See
> http://www-124.ibm.com/linux/projects/kprobes/

I've double-checked what I already knew about kprobes and have looked again
at the site and the patch, and unless there's some feature of kprobes I don't
know about that allows using something else than the debug interrupt to add
hooks, you're wrong about this. In order to do what you describe, kprobes has
to hook itself onto the debug interrupt. Don't take my word for it, here's
what their web site says:
> With each probe, a corresponding probe event handler address is specified.
> Probe event handlers run as extensions to the system breakpoint interrupt
> handler ...
Generating new interrupts is simply unacceptable for LTT's functionality.
Not to mention that it breaks LTT because tracing something will generate
events of its own, which will generating tracing events of their own ...
recursion.

We have, however, contemplated using kernel hooks, which BTW could be used
by the auditing code and quite a few other things too:
http://oss.software.ibm.com/linux/projects/kernelhooks/

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


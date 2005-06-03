Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVFCQfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVFCQfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVFCQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:35:10 -0400
Received: from one.firstfloor.org ([213.235.205.2]:64407 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261379AbVFCQfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:35:02 -0400
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>, ashok.raj@intel.com
Subject: Re: [patch 0/5] x86_64 CPU hotplug patch series.
References: <20050602125754.993470000@araj-em64t>
	<Pine.LNX.4.61.0506021421130.3157@montezuma.fsmlabs.com>
From: Andi Kleen <ak@muc.de>
Date: Fri, 03 Jun 2005 18:35:01 +0200
In-Reply-To: <Pine.LNX.4.61.0506021421130.3157@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Thu, 2 Jun 2005 14:25:04 -0600 (MDT)")
Message-ID: <m1zmu7v1oq.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

> On Thu, 2 Jun 2005, Ashok Raj wrote:
>
>> Andrew: Could you help test staging in -mm so we can get some wider testing
>> from those interested.
>> 
>> *Sore Point*: Andi doesnt agree with one patch that removes ipi-broadcast 
>> and uses only online map cpus receive IPI's. This is much simpler approach to 
>> handle instead of trying to remove the ill effects of IPI broadcast to CPUs in 
>> offline state.
>> 
>> Initial concern from Andi was IPI performance, but some primitive test with a 
>> good number of samples doesnt seem to indicate any degration at all, infact the
>> results seem identical. (Barring any operator errors :-( ).
>> 
>> It would be nice to hear other opinions as well, hopefuly we can close on
>> what what the right approach in this case. Link to an earlier discussion
>> on the topic.
>
> I don't think it's worth the extra boot time complexity to use the boot 
> workaround and i'm not convinced the extra mask against cpu_online_map 
> slows down that path enough to show up compared to waiting for remote 
> processor IPI handling to commence/complete.

What boot slowdown? 

I assume any practical CPU hotplug will have a way to detect it 
at boot - e.g. ACPI will probably need to tell you about spare
CPUs that could be started or there is a command line option.

My request was basically to set a flag when "CPU hotplug possible"
is detected and then only use the slow fast path method when
CPU hotplug is possible.

Actually that was only the second best solution, better would
be to just fix the relatively obscure race in the CPU hotplug bootup
path, but Ashok for some reason seems to be very adverse to that
option.

-Andi

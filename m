Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTKMMEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTKMMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:04:05 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:36493 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261731AbTKMMEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 07:04:01 -0500
Message-ID: <3FB3732A.4060604@cyberone.com.au>
Date: Thu, 13 Nov 2003 23:03:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Catalin BOIE <util@deuroconsult.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 + 2 * P IV Xeon 2.4GHz with HT + SATA + RAID1 = scheduler
 problems
References: <Pine.LNX.4.58.0311131303500.4183@hosting.rdsbv.ro> <3FB36E18.2030105@cyberone.com.au> <Pine.LNX.4.58.0311131345140.4183@hosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.58.0311131345140.4183@hosting.rdsbv.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Catalin BOIE wrote:

>>Hi,
>>
>Hi!
>
>
>>Please capture a Ctrl + Scroll Lock dump when you get processes stuck in
>>D state.
>>
>I will.
>
>
>>>Also I suspect that scheduler doesn't pay special attention to virtual
>>>(HT) processors. Is this true?
>>>
>>>
>>This is correct. Are you seeing any problems with HT? I think Linus
>>
>
>Do you think that disabling HT (how I do it? noht?) will make things works
>better? I suspect that a process is scheduled on a virtual processor that
>doesn't get much chances to execute something. I don't know.
>

I can't see an option to just disable HT with a quick grep. acpi=off
should do it though.

The virtual processors should get a roughly even amount of work done
AFAIK. I don't think the P4 allows any sort of control over priorities.

>
>>was hoping the NUMA / SMP scheduler could be generalised a bit more
>>so that HT would just fall into place. This might not happen before
>>2.7, so the shared runqueue approach might be the next best thing
>>(I like it).
>>
>
>The problem with HT is the one that I describe here. From time to time a
>process (mc, bash) is stuck for 2-6 seconds and then comes back. In test8
>this was more visible.
>
>Thank you very much, Nick!
>

Oh, so it is not any sort of disk IO work that is getting stuck? Then
don't worry about getting the Ctrl Scroll Lock trace...

OK, well yes turn HT off and see if that helps. One other thing which
springs to mind is that there is some CPU scheduler code that increases
timeslice grainularity as the CPU count increases. It seems a bit unlikely
that this is your problem though.



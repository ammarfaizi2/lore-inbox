Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWGGVWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWGGVWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWGGVWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:22:08 -0400
Received: from relay00.pair.com ([209.68.5.9]:54033 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932303AbWGGVWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:22:07 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 7 Jul 2006 16:21:54 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "Abu M. Muttalib" <abum@aftek.com>
cc: kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMAEBKDCAA.abum@aftek.com>
Message-ID: <Pine.LNX.4.64.0607071616540.23767@turbotaz.ourhouse>
References: <BKEKJNIHLJDCFGDBOHGMAEBKDCAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Abu M. Muttalib wrote:

> Hi,
>
> I am getting the Out of memory.
>
> To circumvent the problem, I have commented the call to "out_of_memory(),
> and replaced "goto restart" with "goto nopage".
>
> At "nopage:" lable I have added a call to "schedule()" and then "return
> NULL" after "schedule()".

I wouldn't recommend gutting the oom killer...

> I tried the modified kernel with a test application, the test application is
> mallocing memory in a loop. Unlike as expected the process gets killed. On
> second run of the same application I am getting the page allocation failure
> as expected but subsequently the system hangs.
>
> I am attaching the test application and the log herewith.
>
> I am getting this exception with kernel 2.6.13. With kernel
> 2.4.19-rmka7-pxa1 there was no problem.
>
> Why its so? What can I do to alleviate the OOM problem?

First you should know what is causing them. Is an application leaking 
memory, or is the kernel leaking memory? "ps" can help you answer the 
first question, while "watch cat /proc/meminfo" can help you answer the 
second.

If kernel memory usage seems to be rising steadily over time, report it as 
a bug. Otherwise, fix the broken application.

The reason for the "OOM killer" is because Linux does "VM overcommit". 
Please read "Documentation/vm/overcommit-accounting" for more information, 
including what you'll need if you want to disable "VM overcommit" to 
hopefully stop the OOM killer from coming around.

(When using VM overcommit, the OOM killer is very necessary for a healthy 
system... sometimes the kernel _needs_ memory, and you can't tell it NO. 
In those cases, the OOM killer is invoked to find something to 
sacrifice...)

> Thanks in anticipation and regards,
> Abu.
>

Thanks,
Chase

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVKQRci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVKQRci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVKQRci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:32:38 -0500
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:17062 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S932451AbVKQRch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:32:37 -0500
Message-ID: <437CBEAF.5000101@lifl.fr>
Date: Thu, 17 Nov 2005 18:32:31 +0100
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.7-3mdk (X11/20051015)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org
Subject: Re: nanosleep with small value
References: <20051117163047.30293.qmail@dag.newtech.fi> <Pine.LNX.4.61.0511171146310.9422@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511171146310.9422@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11/17/2005 05:55 PM, linux-os (Dick Johnson) wrote/a écrit:
> On Thu, 17 Nov 2005, Dag Nygren wrote:
:
>>
>>real    0m8.000s
>>user    0m0.000s
>>sys     0m0.000s
> 
> 
> On an unprivilged account, I get this with
> version 2.6.13.4
> 
> Script started on Thu 17 Nov 2005 11:44:47 AM EST
> LINUX> time ./xxx
> sched_setscheduler returned: -1
> Operation not permitted
> 
> real	0m2.000s
> user	0m0.000s
> sys	0m0.001s
> LINUX> uname -r
> 2.6.13.4
> LINUX> exit
> Script done on Thu 17 Nov 2005 11:45:07 AM EST
> 
>>From the root account where the scheduler could be set:
> 
> Script started on Thu 17 Nov 2005 11:45:29 AM EST
> [root@chaos root]# time /tmp/xxx
> 
> real	0m2.001s
> user	0m0.000s
> sys	0m0.001s
> [root@chaos root]# exit
> 
> Script done on Thu 17 Nov 2005 11:45:53 AM EST
> 
> ... essentially the same thing. And 2 seconds, not 8.
> 
> The HZ value for my kernel is 1000. It you are at 100 HZ,
> that might explain it.
No, it means he is at 250 HZ.


> 
> Note that nanosleep() doesn't claim to be able to sleep
> less than the resolution of some kernel timer. It just takes
> parameters in seconds and nanoseconds.
> 
In general small nanosleep() returns between 1/HZ and 2/HZ. In this 
code, the sleep is (indirectly) synchronised on a tick so it's always 
2/HZ, the worse!

1000 small nanosleeps take therefore 1000 * 2/HZ s = 8s :-)

Eric

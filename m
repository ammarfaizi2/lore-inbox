Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268003AbTB1Psg>; Fri, 28 Feb 2003 10:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbTB1Psg>; Fri, 28 Feb 2003 10:48:36 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:56028 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S268003AbTB1Psd>; Fri, 28 Feb 2003 10:48:33 -0500
Message-ID: <3E5F8985.60606@kegel.com>
Date: Fri, 28 Feb 2003 08:08:37 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Protecting processes from the OOM killer
References: <3E5EB9A8.3010807@kegel.com> <1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 2003-02-28 at 01:21, Dan Kegel wrote:
> 
>>For a while now, I've been trying to figure out how
>>to make the oom killer not kill important processes.
> 
> 
> How about by not allowing your system to excessively overcommit.

(I'm using 2.4.18; is
http://www.kernel.org/pub/linux/kernel/people/rml/vm/strict-overcommit/v2.4/vm-strict-overcommit-rml-2.4.18-1.patch
still the approprate patch for that?)

> Everything else is armwaving "works half the time" stuff. By the time
> the OOM kicks in the game is already over.

Even with overcommit disallowed, the OOM killer is going to run
when my users try to run too big a job, so I would still like
the OOM killer to behave "well".

> The rlimit one doesnt deal
> with things like fork explosions where you have lots of processes
> all under 1/4 of the rlimit range who cumulatively overcommit. In
> fact you now pick harder on other tasks...

We do not see fork explosions in our workload, but if we did,
we could abuse the RSS limit for now by setting it to zero except for
the processes we wanted to protect from the OOM killer.
If that works in practice the same idea could be done without the abuse;
the RSS limit is just a handy knob.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


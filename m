Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbTCSBKT>; Tue, 18 Mar 2003 20:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTCSBKT>; Tue, 18 Mar 2003 20:10:19 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:63216 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262862AbTCSBKS>;
	Tue, 18 Mar 2003 20:10:18 -0500
Message-ID: <3E77C5F5.5010407@mvista.com>
Date: Tue, 18 Mar 2003 17:20:53 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ravikumar.chakaravarthy@amd.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Kgdb: breakpoint in start_kernel
References: <99F2150714F93F448942F9A9F112634CA54B23@txexmtae.amd.com>
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B23@txexmtae.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ravikumar.chakaravarthy@amd.com wrote:
> How do I set the kernel breakpoint at 1st line in start_kernel() (init/main.c) using kgdb??
> 
> -Ravi
> 
First you need the KGDB that Andrew Morton has on his patch pages. 
Then you put these line where ever you want to break:

#include <asm/kgdb.h>
breakpoint();

Of course you only need the include once and can put it in the usual 
place, but also in line, what ever you like.

Note that at this early stage some of the memory mapping and page 
table stuff is not set up so don't try to access memory that may not 
be there.  You should be able to look around at most variables, single 
step, set breakpoints, etc.  But backtrace usually depends on traping 
on bad memory addresses to stop and that may not work this early in 
the bring up.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


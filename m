Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWGIMBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWGIMBx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWGIMBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:01:53 -0400
Received: from 1wt.eu ([62.212.114.60]:63241 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1030460AbWGIMBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:01:52 -0400
Date: Sun, 9 Jul 2006 14:01:38 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>,
       chase.venters@clientec.com, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
Message-ID: <20060709120138.GC2037@1wt.eu>
References: <1152446107.27368.45.camel@localhost.localdomain> <BKEKJNIHLJDCFGDBOHGMAEFDDCAA.abum@aftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMAEFDDCAA.abum@aftek.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 05:18:06PM +0530, Abu M. Muttalib wrote:
> >It will refuse to load the program if that would use enough memory that
> >the system cannot be sure it will not run out of memory having done so.
> >You probably need a lot more swap.
> 
> thanks for ur reply..
> 
> but I am running the application on an embedded device and have no swap..
> 
> what do I need to do in this case??

Then try to increase the overcommit_ratio in /proc/sys/vm. Maybe the default
is not enough for your application. My web server has 32 MB and was regularly
crashing when too many apache processes were sollicitated, so I have set the
overcommit_memory to 2 and overcommit_ratio to 95 (huge but stable in this
particular workload). Now it works reasonably well.

Also, you should be aware of the side effects of overcommit. When you're
close to the limits, the system will refuse to fork processes, and various
applications might suddenly get NULL pointers in return from malloc(). And
I can tell you that this behaviour has become rare for so long a time that
rare are the programs which do not segfault when malloc() returns NULL !

If you develop all your programs, you should preallocate memory as much as
possible in order to ensure that once started, they will always work. Also
be careful about libc's function which allocate memory upon first call.
I've had problems with localtime() in the past.

> Regards,
> Abu.

Regards,
Willy


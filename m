Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSILUeA>; Thu, 12 Sep 2002 16:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSILUeA>; Thu, 12 Sep 2002 16:34:00 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:14553 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317253AbSILUd6>; Thu, 12 Sep 2002 16:33:58 -0400
Date: Thu, 12 Sep 2002 17:38:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Rick Lindsley <ricklind@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
In-Reply-To: <3D80EE1D.34AF4FF2@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209121734190.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Andrew Morton wrote:

> Looks like we can take the disk stats out of kernel_stat, move all
> the vm-related things out of kernel_stat into struct page_state and
> what's left of kernel_stat?
>
>         unsigned int per_cpu_user[NR_CPUS],
>                      per_cpu_nice[NR_CPUS],
>                      per_cpu_system[NR_CPUS];

[ insert idle and iowait stats here ;) ]

>         unsigned int irqs[NR_CPUS][NR_IRQS];
>
> And that's good, because "kernel statistics" was clearly too
> broad a concept.  The above is just one concept: interrupts and
> scheduler things.

Absolutely agreed, this makes things much more manageable.

Btw, how about accounting for the number of syscalls made,
like some other Unix systems do ? ;)

> I'm not sure that I want to add 14 more fields to /proc/meminfo.
> So a new /proc/vmstat may appear.  We would then have:
>
> /proc/stat		scheduler things
> /proc/diskstat		disk things
> /proc/vmstat		vm things

Sounds fair, current procps doesn't support the new /proc/stat
fields anyway. Let me know what stuff will look like and I'll
get procps into gear.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTEOK5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 06:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263964AbTEOK5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 06:57:38 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:17127 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263962AbTEOK5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 06:57:36 -0400
Message-ID: <3EC375C0.B8D2C624@earthlink.net>
Date: Thu, 15 May 2003 05:10:56 -0600
From: mcompengr@earthlink.net
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.17-4 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: debian-alpha@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: alpha kernel memory leak
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please correct me where I'm wrong.)

Generally, a memory leak is where an often called piece of code
dynamically allocates itself some memory for temporary usage, and
then fails to release that memory before being called again.

This situation might be indicated by running out of swap space, at
which point the machine should grind to a halt (all processes), but
the memory usage reflected by the "top" or "free" commands won't show
it.  Swap space should be twice the size of physical memory.

> ...top reports 505MB used, 5MB free, ...
>
Such memory usage is normal and desirable, and is not an Alpha or
a Debian or even a Linux thing.  That's what the memory is for: to
be used to the max for minimum paging/swaping.  Since no process can
run until it is loaded into memory, processes are unloaded only when
it's time for some other process to run, and if that new process does
not already reside in memory.  Only a portion of a process's code is
loaded as needed, so even if no new processes are started after booting,
the memory usage will increase to approach the max, as needed portions
are loaded and un-needed blocks are left as is until there is no more
memory available (then swaping commences apace).

-Martin


Bob McElrath wrote:
> 
> I have noticed that my alphas seems to have a gigantic memory leak.  I
> have two machines, one with 2GB memory and one with 512MB memory.  When
> I first boot up the machines run fine, but over time the amount of
> memory available decreases steadily to zero.
> 
> At first I thought it was just poor VM code in linux that caused it, but
> I ran for a couple of days with the swap turned off, and the results are
> the same.
> 
> 'ps' does not correctly report memory information anymore (latest debian
> unstable -- why?), but using top and summing the VIRT, I get 202MB on
> the 512MB machine, and top reports 505MB used, 5MB free, and 25MB
> cached. Clearly something is horribly wrong.  The 2GB machine is
> reporting that almost all memory is full (free + buffers + cached is
> only different from the sum of VIRT by 150 MB).  But it is not used as
> heavily so presumably it is leaking slower.  uptime is 4 days on the
> 512MB machine, 9 days on the 2GB machine.
> 
> The kernels on these two machines are 2.4.21-pre7 (2GB) and
> 2.4.21-rc1-ac1 (512MB), but this is something that I have noticed for
> more than a year accross many kernels.
> 
> I have plotted the memory usage every 60 seconds over the last 3 days on
> the 512MB machine (swap was turned off).  On first bootup I can run many
> xterms, galeon, and xmms with no problem.  After 4 days both were killed
> with OOM, but notice in the plots that the amount of memory available
> hasn't changed, despite the fact that these (and X) are the largest
> memory consuming processes running.  It is here:
>     http://mcelrath.org/mem.log.ps.gz
> 
> Cheers,
> Bob McElrath [Univ. of Wisconsin at Madison, Department of Physics]
> 
>     "You measure democracy by the freedom it gives its dissidents, not the
>     freedom it gives its assimilated conformists." -- Abbie Hoffman
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSJRQoZ>; Fri, 18 Oct 2002 12:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265233AbSJRQoZ>; Fri, 18 Oct 2002 12:44:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:53959 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265230AbSJRQoX>;
	Fri, 18 Oct 2002 12:44:23 -0400
Message-ID: <3DB03BC9.F2986C53@digeo.com>
Date: Fri, 18 Oct 2002 09:50:17 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 and lowmemory boxens
References: <E182V29-000Pfa-00@f15.mail.ru> <m37kggyo7r.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2002 16:50:17.0842 (UTC) FILETIME=[703CA520:01C276C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> "Samium Gromoff" <_deepfire@mail.ru> writes:
> 
> >    first: i`ve successfully ran 2.5.43 on a 386sx20/4M ram notebook.
> >
> >  the one problem was the ppp over serial not working, but i suspect
> >  that it just needs to be recompiled with 2.5 headers (am i right?).
> >
> >  the other was, well, the fact that ultra-stripped 2.5.43
> >  still used 200k more memory than 2.4.19, and thats despite it was
> >  compiled with -Os instead of -O2.
> >  actually it was 2000k free with 2.4 vs 1800k  free with 2.5
> >
> >  i know Rik had plans of some ultra bloody embedded/lowmem
> >  changes for such cases. i`d like to hear about things in the area :)
> 
> I would start with clamping down all the hash tables.

Well here's some low-hanging fruit:

mnm:/usr/src/25> size kernel/pid.o
   text    data     bss     dec     hex filename
   1677    1088  131104  133869   20aed kernel/pid.o

(I have a trollpatch to fix this)

And the radix_tree_node mempool is 140k; I plan to do away with
that altogether.

timer.c and sched.c have significant NR_CPUS bloat problems on SMP.
Working on that.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317567AbSG2SWO>; Mon, 29 Jul 2002 14:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSG2SWO>; Mon, 29 Jul 2002 14:22:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317567AbSG2SWO>;
	Mon, 29 Jul 2002 14:22:14 -0400
Message-ID: <3D45880A.8C87A8E7@zip.com.au>
Date: Mon, 29 Jul 2002 11:23:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
References: <20020726204033.D18570@in.ibm.com> <3D41990A.EDC1A530@zip.com.au> <20020729162730.A2393@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> ...
> 
> > General comment:  we need to clean up the kernel_stat stuff.  We
> > cannot just make it per-cpu because it is 32k in size already.  I
> > would suggest that we should break out the disk accounting and
> > make the rest of kernel_stat per CPU.
> >
> > That would be a great application of your interface, and a good
> > way to get your interface merged ;)  Is that something which you
> > have time to do?
> 
> Sure,... anything to get these interfaces merged :)

Well Rusty's point about just using the percpu API seemed
reasonable - that's basically equivalent to statically defining
the data.  In what situation is dynamic allocation needed?

Well, in modules for one.  Unless we work out a way to make the
percpu API work with storage which is defined within modules.

> Are you looking at something on the lines as the diff below?

Looks nice.

> What about /proc/stat ? Is it a good idea to have separate /proc files
> for disk stats and cpu usage stats? (It'll be good for statctrs that way,
> applications monitoring disk_stats only don't cause statctr_reads on
> cpu_usage stats then)

Stick with the existing format, I'd say.   Numerous applications
would break otherwise.

-

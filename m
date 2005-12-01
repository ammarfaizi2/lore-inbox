Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVLASPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVLASPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVLASPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:15:52 -0500
Received: from hera.kernel.org ([140.211.167.34]:14212 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932385AbVLASPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:15:52 -0500
Date: Thu, 1 Dec 2005 16:15:25 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Better pagecache statistics ?
Message-ID: <20051201181525.GB17169@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain> <20051201152029.GA14499@dmt.cnet> <1133452790.27824.117.camel@localhost.localdomain> <20051201171938.GB16235@dmt.cnet> <1133458309.21429.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133458309.21429.36.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I thought that it would be easy to use SystemTap for a such
> > a purpose?
> > 
> > The sys_read/sys_write example at 
> > http://www.redhat.com/magazine/011sep05/features/systemtap/ sounds
> > interesting.
> > 
> > What I'm I missing?
> 
> Well, Few things:
> 
> 1) We have to have those probes present in the system all the time
> collecting the information when read/write happens, maintaining it
> and spitting it out. Since its kernel probe, all this data will be
> in the kernel. 

Yeah, there is some overhead.

> 2) If we want to do this accounting (and you don't have those probes
> installed already) - we can't capture what happened earlier. 

I suppose that the vast majority of situations where such information is 
needed are special anyway? 

Why do you need it around all the time?

> 3) probing sys_read/sys_write() are going to tell you how much
> a data a process did read or wrote - but its not going to tell you
> how much is in the cache (now or 10 minutes later). 

Sure, that was just an example - need to insert probes
on the correct places.

> > > My final goal is to get stats like ..
> > > 
> > > Out of "Cached" value - to get details like
> > > 
> > > 	<mmap> - xxx KB
> > > 	<shared mem> - xxx KB
> > > 	<text, data, bss, malloc, heap, stacks> - xxx KB
> > > 	<filecache pages total> -- xxx KB
> > > 		(filename1 or <dev>, <ino>) -- #of pages
> > > 		(filename2 or <dev>, <ino>) -- #of pages
> > > 		
> > > This would be really powerful on understanding system better.
> > > 
> > > Don't you think ?
> > 
> > Yep... /proc/<pid>/smaps provides that information on a per-process
> > basis already.
> 
> /proc/pid/smaps will give me information about text,data,shared libs,
> malloc etc. Not the filecache information about files process opened,
> pages read/wrote currently in the pagecache. Isn't it ?

Right. 


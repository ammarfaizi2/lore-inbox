Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbTDRRLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTDRRLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:11:11 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:49642 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263209AbTDRRLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:11:09 -0400
Date: Fri, 18 Apr 2003 19:35:11 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: cow-ahead N pages for fault clustering
Message-ID: <20030418173511.GC27055@wind.cocodriloo.com>
References: <12790000.1050334744@[10.10.2.4]> <20030414155748.GD14552@wind.cocodriloo.com> <14860000.1050337484@[10.10.2.4]> <20030414164321.GE14552@wind.cocodriloo.com> <15700000.1050338226@[10.10.2.4]> <20030414171419.GG14552@wind.cocodriloo.com> <16700000.1050340965@[10.10.2.4]> <20030414183251.GH14552@wind.cocodriloo.com> <20030414184715.GI14552@wind.cocodriloo.com> <20890000.1050385742@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20890000.1050385742@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 10:49:03PM -0700, Martin J. Bligh wrote:
> >> > >> Ah, you probably don't want to do that ... it's very expensive.
> >> > >> Moreover, if you exec 2ns later, all the effort will be wasted ...
> >> > >> and it's very hard to deterministically predict whether you'll exec
> >> > >> or not (stupid UNIX  semantics). Doing it lazily is probably best,
> >> > >> and as to "nodes would not  have to reference the memory from
> >> > >> others" - you're still doing that, you're just batching it on the
> >> > >> front end.
> >> > > 
> >> > > True... What about a vma-level COW-ahead just like we have a
> >> > > file-level read-ahead, then? I mean batching the COW at
> >> > > unCOW-because-of-write time.
> >> > 
> >> > That'd be interesting ... and you can test that on a UP box, is not
> >> > just NUMA. Depends on the workload quite heavily, I suspect.
> >> >  
> >> > > btw, COW-ahead sound really silly :)
> >> > 
> >> > Yeah. So be sure to call it that if it works out ... we need more
> >> > things like that ;-) Moooooo.
> >> 
> >> What about the attached one? I'm compiling it right now to test in UML :)
> >> 
> >> [ snip fake-NUMA-on-SMP discussion ]
> >> 
> > 
> > OK, too quick for me... this next one applies, compiles and boots on
> > 2.5.66 + uml. Now I wonder how can I test if this is useful... ideas?
> 
> Well, benchmark it ;-) My favourite trick is to just 
> "/usr/bin/time make bzImage" on some fixed kernel version & config,
> but aim7 / aim9 is pretty easy to set up too, and might be interesting.
> 
> M.

I've benchmarked my patch with a 2-pages-per-fault loop:

make allnoconfig
date >>aaa
make bzImage
date >>aaa

and then checked manually the time difference

Took the same time both on vanilla 2.5.66 and my 2.5.66+cowahead.

Perhaps it's better for other workloads...

ps. my posted patch had a little bug: it did the cow loop only 1 time,
    so it only cow'ed 1 page... be sure to change the end test if
    you want to benchmark it futher.

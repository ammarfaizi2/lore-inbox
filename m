Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWIOWAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWIOWAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWIOWAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:00:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31452 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932310AbWIOWAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:00:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=bYFmuZkP85DRypgBYeujJ/u3OQKq423Z+JopNK08a7b4NCDiygYaBzigM6bGe5CVc
	hBGnvDonR8lxOWA6dz05A==
Subject: Re: [Devel] Re: [ckrm-tech] [PATCH] BC:	resource	beancounters	(v4)
	(added	user memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com, sekharan@us.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <450B1958.3020309@openvz.org>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <20060912104410.GA28444@in.ibm.com>
	 <1158081752.20211.12.camel@galaxy.corp.google.com>
	 <1158105732.4800.26.camel@linuxchandra>
	 <1158108203.20211.52.camel@galaxy.corp.google.com>
	 <1158109991.4800.43.camel@linuxchandra>
	 <1158111218.20211.69.camel@galaxy.corp.google.com>
	 <1158186247.18927.11.camel@linuxchandra>  <450A71B1.8020009@sw.ru>
	 <1158339160.12311.35.camel@galaxy.corp.google.com>
	 <450B1958.3020309@openvz.org>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 15 Sep 2006 14:58:53 -0700
Message-Id: <1158357533.12311.110.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 01:21 +0400, Kir Kolyshkin wrote:
> Rohit Seth wrote:
> > On Fri, 2006-09-15 at 13:26 +0400, Kirill Korotaev wrote:
> >   
> > <...skipped...>
> >   
> >> for VMware which can reserve required amount of RAM for VM.
> >>     
> >
> > It is much easier to provide guarantees in complete virtual
> > environments.  But then you pay the cost in terms of performance.
> >   
> "Complete virtual environments" vs. "contaners" is not [only] about
> performance! In the end, given a proper set of dirty and no-so-dirty
> hacks in software and hardware, their performance will be close to native.
> 

I don't think there is current generation of Virtualization HW/SW that
can live with o-2% performance loss for all workloads (like the way
containers do).

> Containers vs. other virtualization types is more about utilization,
> density, scalability, portability.
> 

I agree with most of it (except portability as using latest HW
technologies you can run unmodified guests in virtualized environment).

> Speaking of guarantees, yes, guarantees is easy, you just reserve such
> amount of RAM for your VM and that is all. But the fact is usually some
> part of that RAM will not be utilized by this particular VM. But since
> it is reserved, it can not be utilized by other VMs -- and we end up
> just wasting some resources. Containers, given a proper resource
> management and configuration, can have some guarantees and still be able
> to utilize all the RAM available in the system. This difference can be
> metaphorically expressed as a house divided into rooms. Dividing walls
> can either be hard or flexible. With flexible walls, room (container)
> owner have a guarantee of minimal space in your room, but if a few
> guests come for a moment, the walls can move to make more space (up to
> the limit). So the flexibility is measured as the delta between a
> guarantee and a limit.
> 
> This flexibility leads to higher utilization, and this flexibility is
> one of the reasons for better density (a few times higher than that of a
> paravirtualization solution).
> 

I guess as far as memory is concerned, virtualized solutions can also
techniques like ballooning to oversubscribe memory.  But I agree that we
will almost always be able to pack things tighter in container
environment.

> I will not touch scalability and portability topics here to make things
> simpler.
> > I think we should punt on hard guarantees and fractions for the first
> > draft.  Keep the implementation simple.
> >   
> Do I understand it right that with hard guarantees we loose the
> flexibility I have just described? If this is the case, I do not like it.

With hard guarantees, you will also end up making hooks in generic part
of kernel which could be considered invasive.  And yes, if you are
making a hard guarantee then you will some how make sure that amount of
resource is available all the time for that container.  As you mentioned
this is not the most optimal use of resources.  And that is why I don't
want to incorporate that in at least the first draft.  Please look at
the container kernel patches that I sent out yesterday.  They allow the
containers to go over board with memory as long as there is no pressure.
But the moment there is any pressure on memory, pages belonging to over
the limit containers get freed or swapped first.

-rohit


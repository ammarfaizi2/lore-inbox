Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUD3WDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUD3WDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUD3WDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:03:55 -0400
Received: from [12.177.129.25] ([12.177.129.25]:21699 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261479AbUD3WDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:03:52 -0400
Message-Id: <200404302243.i3UMheml004667@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Rik van Riel <riel@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release 
In-Reply-To: Your message of "Fri, 30 Apr 2004 15:17:10 EDT."
             <4092A636.7050304@watson.ibm.com> 
References: <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com>  <4092A636.7050304@watson.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Apr 2004 18:43:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nagar@watson.ibm.com said:
> In overhead, I presume you're including the overhead of running as
> many uml instances as expected number of classes. Not just the
> slowdown of applications because they're running under a uml instance
> (instead of running native) ? 

My next major UML project is going to be porting it back into the kernel.  By
this, I mean calling the internal system calls rather than the libc wrappers.
Doing this will give you an object that can be built directly into the kernel,
or insmodded, and when it's started, will be an in-kernel UML instance.

People look at this as an overhead reduction thing.  It will do that, and open
up more opportunities for reducing overhead later, but I'm doing it to make
UML something of a virtualization toolkit.  I'm envisioning that an in-kernel
UML can be stripped down to just the VM system, and processes inside it will
be confined to using a maximum amount of memory in total, but unrestricted in
every other way.  Or it could be a VM system plus scheduler, in which case
their access to CPU would be controlled as well as memory.  Basically, my
long-term goal is to allow UML to allow containment of any combination of
resources.

Longer-term than that, I would like the in-kernel vs userspace containment
choice to be independent of everything else, so you'd be able to decide how
you want to confine your processes, and then decide whether the container
should be in userspace or inside the kernel.

riel@redhat.com said:
> > ....and provided the groups of processes that are sought to be 
> > regulated as a unit are relatively static.
>
> Good point, I hadn't thought of that one. 

I'm starting to.  With the in-kernel UML stuff I describe above, it doesn't
seem too hard to move a process from the host scheduler to a UML scheduler,
for example.  Moving a process into a confined memory pool looks harder, but
I can see how it might be done.  The UML would trade pages with the host, 
getting the process's memory in exchange for giving up free pages.  So, it
looks possible that you could migrate processes around between containers.

nagar@watson.ibm.com said:
> Also, will the 2.6 VM improvements continue to work as designed if
> multiple UML instances are running, each replicating a large memory
> user (like say a JVM or a database server) ? Taking the application
> server serving a number of different customers. If we have to
> replicate the app server for each customer class (one on each UML
> instance), the app server's memory needs would get added to the
> equation n times and the benefits of 2.6 VM tuning might be lost. 

Well, you get to share text, and data is split n ways instead of being n
chunks in one server, so to a first approximation, it looks like a wash
to me.

If the different customer classes are using the same data, then you might
get some duplication, although it might be possible to eliminate it.

				Jeff


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVC3HqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVC3HqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVC3HqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:46:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13483 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261807AbVC3HqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:46:14 -0500
To: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Cc: fastboot@lists.osdl.org,
       Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	<1111552017.3604.78.camel@localhost.localdomain>
	<m1d5tqrvp9.fsf@ebiederm.dsl.xmission.com>
	<200503300258.34239.mark.williamson@cl.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Mar 2005 00:42:32 -0700
In-Reply-To: <200503300258.34239.mark.williamson@cl.cam.ac.uk>
Message-ID: <m1zmwllguv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Williamson <mark.williamson@cl.cam.ac.uk> writes:

> > The Xen guys idea of memory hotplug is another matter it sounds
> > like the want to page an OS with memory hotplug which is just
> > plain silly, and also unimplemented so I will cross that bridge
> > when I come to it.
> 
> The idea isn't to page the OS per se.  The guest OS is responsible for the 
> fine-grain paging of its applications in the usually way to fit within its 
> physical memory allocation.
> 
> In order to allow coarse-grained changes in physical memory allocation (e.g. I 
> want to shrink a domain by 128MB so I can run another one), XenLinux uses a 
> "balloon driver", which basically allocates a load of memory and gives it 
> back to Xen to be used elsewhere.
> 
> This is currently invoked by the administrator, although we've talked about a 
> daemon that will automatically shift memory allocations around between 
> domains based on their requirements.
> 
> A memory hotplug interface would clean up the ballooning interface somewhat 
> (rather than using pretend allocations) but would still only be activated 
> relatively infrequently.

And what I am really objecting to is xen doing memory allocation in 4KiB
chunks.  Pushing the chunk size up to 2MiB or 4MiB, or even doing
plain extents of memory like the old protected mode OS's did before
paging sounds more reasonable.  Without allowing the OS access to
large contiguous chunks of physical memory you are asking the OS to
give up significant performance tuning opportunities.

Plus with by giving the OS large pages much of the mess of needing a
virtual, logical and physical address is unnecessary and the OS can
simply have virtual and physical addresses as they do not.

In addition large chunks of memory are going to work better with
whatever memory hotplug infrastructure is implemented, than 4KiB
chunks.  As memory hotplug is either going to be memory controller
hotplug (in numa systems) or possible DIMM hotplug is extremely fault
tolerant servers.

So please simply everyone's lives and code and use large pages
in Xen.

Eric

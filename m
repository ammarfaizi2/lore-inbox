Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUG2BPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUG2BPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUG2BPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:15:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63416 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267399AbUG2BOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:14:36 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
	<200407281106.17626.jbarnes@engr.sgi.com>
	<20040728124405.1a934bec.akpm@osdl.org>
	<m1pt6f681y.fsf@ebiederm.dsl.xmission.com>
	<1091055192.31923.1.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 19:12:14 -0600
In-Reply-To: <1091055192.31923.1.camel@localhost.localdomain>
Message-ID: <m14qnr62hd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Iau, 2004-07-29 at 00:11, Eric W. Biederman wrote:
> > If we can ensure the addresses where the new kernel will run will never
> > have DMA pointed at them I actually don't think so.  This is why last
> > year I recommended building a kernel that runs at a non-default address
> > and finding a way to simply preload it there.
> 
> We DMA into arbitary allocated pages anywhere in the memory space, so
> you never know where is safe other than areas preallocated during the
> old kernel run.

Alan I just reread what you said and it appears we are in violent agreement
about the facts.

Different methods but...

> Since you can just clear the master bit on each PCI device it isnt a big
> deal to protect against. (except a couple of devices that forget
> to honour it)

Or those devices that hang the machine when you clear it.
Or the ioapics which loose the ability to generate interrupts
when you clear the master bit, and with the i82559 timer behind
them you can't get your new kernel to boot.

Plus there are all of the non-pci devices.  

And there is the fact that the pci configuration access methods
are frequently BIOS calls.

So I do see just clearing the master bit on each PCI devices to
as dangerous as calling the shutdown methods.

Eric




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWAYIAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWAYIAj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAYIAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:00:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750826AbWAYIAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:00:38 -0500
Date: Wed, 25 Jan 2006 00:00:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: fernando@intellilink.co.jp, ebiederm@xmission.com, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 3/5] stack overflow safe kdump (2.6.16-rc1-i386) - fault
Message-Id: <20060125000017.545c8bf8.akpm@osdl.org>
In-Reply-To: <200601250856.44687.ak@suse.de>
References: <1138172000.2370.68.camel@localhost.localdomain>
	<20060124231510.35eabe15.akpm@osdl.org>
	<200601250856.44687.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Wednesday 25 January 2006 08:15, Andrew Morton wrote:
> > Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> wrote:
> > > When we have a bloated stack it is likely that it ends up making an
> > > invalid memory access that in turn causes a page fault. Take this case
> > > into account in the page fault code.
> > >
> > > +	if (!virt_addr_valid(tsk)) {
> >
> > Is virt_addr_valid() a sufficiently strong test here?  One could probe the
> > address to see if it generates a fault, like the __get_user() in
> > kmem_cache_create().
> 
> Recursive page faults are always risky because if things go bad they
> can lead to unbounded recursion.   I think the scheduler knows anyways
> which process currently executes on a CPU so it might be better to get
> the information from there.
> 

It might be nmi-in-interrupt.

But then, the interrupt code knows what CPU it's running on too.

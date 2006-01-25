Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWAYH4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWAYH4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWAYH4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:56:55 -0500
Received: from mx1.suse.de ([195.135.220.2]:37085 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750812AbWAYH4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:56:54 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/5] stack overflow safe kdump (2.6.16-rc1-i386) - fault
Date: Wed, 25 Jan 2006 08:56:44 +0100
User-Agent: KMail/1.8
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       ebiederm@xmission.com, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
References: <1138172000.2370.68.camel@localhost.localdomain> <20060124231510.35eabe15.akpm@osdl.org>
In-Reply-To: <20060124231510.35eabe15.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601250856.44687.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 January 2006 08:15, Andrew Morton wrote:
> Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> wrote:
> > When we have a bloated stack it is likely that it ends up making an
> > invalid memory access that in turn causes a page fault. Take this case
> > into account in the page fault code.
> >
> > +	if (!virt_addr_valid(tsk)) {
>
> Is virt_addr_valid() a sufficiently strong test here?  One could probe the
> address to see if it generates a fault, like the __get_user() in
> kmem_cache_create().

Recursive page faults are always risky because if things go bad they
can lead to unbounded recursion.   I think the scheduler knows anyways
which process currently executes on a CPU so it might be better to get
the information from there.

-Andi


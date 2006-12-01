Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966999AbWLAH7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966999AbWLAH7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967124AbWLAH7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:59:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966999AbWLAH7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:59:39 -0500
Date: Thu, 30 Nov 2006 23:59:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061130235936.cd979ba5.akpm@osdl.org>
In-Reply-To: <20061130235117.018c3c70.pj@sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<20061103172605.e646352a.pj@sgi.com>
	<20061103174206.53f2c49e.akpm@osdl.org>
	<20061104025128.ca3c9859.pj@sgi.com>
	<Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
	<20061130235117.018c3c70.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 23:51:17 -0800
Paul Jackson <pj@sgi.com> wrote:

> A month ago, Christoph replied to pj:
> >
> > On Sat, 4 Nov 2006, Paul Jackson wrote:
> > 
> > >   Do you know of any existing counters that we could use like this?
> > > 
> > > Adding a system wide count of pages allocated or scanned, just for
> > > these fullnode hint caches, bothers me.
> > 
> > There are already such counters. PGALLOC_* and PGSCAN_*. See 
> > include/linux/vmstat.h
> 
> These counters depend on CONFIG_VM_EVENT_COUNTERS.
> 
> The Kconfig comment for CONFIG_VM_EVENT_COUNTERS states:
> 
>           VM event counters are only needed to for event counts to be
>           shown. They have no function for the kernel itself. This
>           option allows the disabling of the VM event counters.
>           /proc/vmstat will only show page counts.
> 
> (By the way - note the "needed to for event" phrasing error.)
> 
> The header file, include/linux/vmstat.h, for these counters states:
> 
> 	/*
> 	 * Light weight per cpu counter implementation.
> 	 *
> 	 * Counters should only be incremented and no critical kernel component
> 	 * should rely on the counter values.
> 
> Both these clearly state that I should not use these counters for real
> kernel functions.
> 
> If that is so, I should find some other "time base" for the zonelist
> caching.
> 
> If that is not so, then these comments need updating.
> 
> Anybody have any idea which is the case?

You need to set EMBEDDED to disable VM_EVENT_COUNTERS.

Things like procps (vmstat, top, etc) now use /proc/vmstat and would likely
break.

I don't know how much space it saves, but I doubt if the world would end if
we removed CONFIG_VM_EVENT_COUNTERS.


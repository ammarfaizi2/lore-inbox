Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVLLKNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVLLKNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVLLKNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:13:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751208AbVLLKNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:13:52 -0500
Date: Mon, 12 Dec 2005 02:12:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051212021247.388385da.akpm@osdl.org>
In-Reply-To: <20051212020211.1394bc17.pj@sgi.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > Please do use __read_mostly for new kmem_cache :
> > 
> > static kmem_cache_t *cpuset_cache __read_mostly;
> 
> Is there any downside to this?  I ask because accesses through
> this 'cpuset_cache' pointer are rather infrequent - only when
> the sysadmin or the batch scheduler is creating or removing
> cpusets, which for the purposes of 'back of the envelope'
> estimates, might be once a minute or less.  Further, it is
> not at all a performance critical path.
> 
> So I really don't give a dang if it takes a few milliseconds
> to pick up this pointer, at least so far as cpusets matters.

There's no downside, really.  It just places the storage into a different
section.  There's a small downside to having __read_mostly at all: up to a
page more memory used.  But once it's there, adding to it is just moving
things around in memory.

__read_mostly is simply a new (page-aligned) section into we put things
which are considered to not be written to very often.

> That said, would you still advise marking this __read_mostly?

Not at this stage - it'd be better if someone did a big sweep and changed
all kmem_cache_t's in one hit.


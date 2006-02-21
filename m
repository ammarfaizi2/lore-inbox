Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWBUAY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWBUAY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWBUAY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:24:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161228AbWBUAY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:24:58 -0500
Date: Mon, 20 Feb 2006 16:23:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-Id: <20060220162317.5c7b9778.akpm@osdl.org>
In-Reply-To: <20060221000924.GD3594@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain>
	<20060220153320.793b6a7d.akpm@osdl.org>
	<20060220153419.5ea8dd89.akpm@osdl.org>
	<20060221000924.GD3594@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Mon, Feb 20, 2006 at 03:34:19PM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > > @@ -100,9 +100,10 @@ struct futex_q {
> > > >  struct futex_hash_bucket {
> > > >         spinlock_t              lock;
> > > >         struct list_head       chain;
> > > > -};
> > > > +} ____cacheline_internodealigned_in_smp;
> > > >  
> > > > -static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
> > > > +static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS] 
> > > > +				__cacheline_aligned_in_smp;
> > > >  
> > > 
> > > How much memory does that thing end up consuming?
> > 
> > I think a megabyte?
> 
> On most machines it would be 256 * 128 = 32k. or 16k on arches with 64B 
> cachelines.  This looked like a simpler solution for spinlocks falling on
> the same cacheline.  So is 16/32k unreasonable?
> 

CONFIG_X86_VSMP enables 4096-byte padding for
____cacheline_internodealigned_in_smp.    It's a megabyte.

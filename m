Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVCJFfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVCJFfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVCJFfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:35:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19152 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262546AbVCIXDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:03:48 -0500
Date: Wed, 9 Mar 2005 15:02:54 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page Fault Scalability patch V19 [4/4]: Drop use of page_table_lock
 in do_anonymous_page
In-Reply-To: <m13bv4whrl.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0503091500040.30604@schroedinger.engr.sgi.com>
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
 <20050309201344.29721.26698.sendpatchset@schroedinger.engr.sgi.com>
 <m13bv4whrl.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Andi Kleen wrote:

> I still think it's a bad idea to add arbitary process size limits like this:

The limit is pretty high: 2^31*PAGE_SIZE bytes. For the standard 4k
pagesize this will be >8TB.

> >
> > +#ifdef CONFIG_ATOMIC_TABLE_OPS
> > +/*
> > + * Atomic page table operations require that the counters are also
> > + * incremented atomically
> > +*/
> > +#define set_mm_counter(mm, member, value) atomic_set(&(mm)->member, value)
> > +#define get_mm_counter(mm, member) ((unsigned long)atomic_read(&(mm)->member))
> > +#define update_mm_counter(mm, member, value) atomic_add(value, &(mm)->member)
> > +#define MM_COUNTER_T atomic_t
>
> Can you use atomic64_t on 64bit systems at least?

If atomic64_t is available on all 64 bit systems then its no problem.

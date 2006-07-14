Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbWGNCzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWGNCzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWGNCzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:55:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161183AbWGNCzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:55:14 -0400
Date: Thu, 13 Jul 2006 19:54:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
Message-Id: <20060713195419.a955b6dd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra>
	<20060713071221.GA31349@elte.hu>
	<20060713002803.cd206d91.akpm@osdl.org>
	<20060713072635.GA907@elte.hu>
	<20060713004445.cf7d1d96.akpm@osdl.org>
	<20060713124603.GB18936@elte.hu>
	<84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
	<Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
	<1152818472.3024.75.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
	<20060713161620.f61d2ac0.akpm@osdl.org>
	<Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 19:29:52 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 13 Jul 2006, Andrew Morton wrote:
> 
> > > Whew! We drop the list lock before calling slab_destroy.
> > 
> > Well we did, up until about ten minutes ago.
> > 
> > free_block()'s droppage of l3->list_lock around the slab_destroy() call was
> > just reverted, due to Shailabh confirming that it caused corruption.
> 
> How would this slab become corrupted if it is no longer on the lists?

It's a bad sign that this question is flowing in the you->me direction ;)

I don't see anywhere under slab_destroy() where *cachep state gets altered.

The change did cause
free_block->slab_destroy->__cache_free->cache_free_alien to no longer be
called under this slab's l3->list_lock.  Maybe that locking is
(accidentally?) protecting something?

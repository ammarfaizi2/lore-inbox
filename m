Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWHHSts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWHHSts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWHHSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:49:48 -0400
Received: from h155.mvista.com ([63.81.120.158]:8069 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S965033AbWHHSts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:49:48 -0400
Subject: Re: lockdep spew
From: Daniel Walker <dwalker@mvista.com>
To: Dave Jones <davej@redhat.com>
Cc: kiran@scalex86.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060808183856.GA4880@redhat.com>
References: <20060808183856.GA4880@redhat.com>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 11:49:42 -0700
Message-Id: <1155062983.16818.15.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 14:38 -0400, Dave Jones wrote:
> I don't think I've seen this one reported yet.
> This kernel was a 2.6.18rc3-gitSomething, but I don't think
> anything has changed recently that would explain this?
> 
> 		Dave
> 

I think something similar to this was reported by Thomas Gleixner on a
NUMA machine. The subject was "[BUG] Lockdep recursive locking in
kmem_cache_free" , there was a patch provided by Ravikiran G Thirumalai
that remove the warnings.

Daniel


> > #######
> > checking if image is initramfs...
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > ---------------------------------------------
> > swapper/1 is trying to acquire lock:
> >  (&nc->lock){....}, at: [<ffffffff8020782c>] kmem_cache_free+0x1a1/0x26c
> > 
> > but task is already holding lock:
> >  (&nc->lock){....}, at: [<ffffffff8020b47e>] kfree+0x1b3/0x27e
> > 
> > other info that might help us debug this:
> > 2 locks held by swapper/1:
> >  #0:  (&nc->lock){....}, at: [<ffffffff8020b47e>] kfree+0x1b3/0x27e
> >  #1:  (&parent->list_lock){....}, at: [<ffffffff802dae22>]
> > __drain_alien_cache+0x37/0
> > x77



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292585AbSCDR2L>; Mon, 4 Mar 2002 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292549AbSCDR1S>; Mon, 4 Mar 2002 12:27:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:23458 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292581AbSCDR06>; Mon, 4 Mar 2002 12:26:58 -0500
Date: Mon, 4 Mar 2002 10:41:38 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
Message-ID: <20020304104138.B31523@vger.timpanogas.org>
In-Reply-To: <20020304001223.A29448@vger.timpanogas.org.suse.lists.linux.kernel> <p731yf03ffe.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p731yf03ffe.fsf@oldwotan.suse.de>; from ak@suse.de on Mon, Mar 04, 2002 at 09:28:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 09:28:21AM +0100, Andi Kleen wrote:
> "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> writes:
> 
> > /usr/src/linux/net/core/skbuff.c
> > 
> > //int sysctl_hot_list_len = 128;
> > int sysctl_hot_list_len = 1024;  // bump this value up
> > 
> 
> The plan was to actually to get rid of the skb hot list. It was just 
> a stop gap solution to get CPU local smp allocation before Linux had
> cpu local slab caches. The slab cache has been fixed and runs 
> cpu local now too, so there should be no need for it anymore as 
> the slab cache does essentially the same thing as the private hot list
> cache (maintaining linked lists of objects and unlinking them quickly
> on allocation and linking them again on free, all in O(1)) 
> 
> 
> > alloc_skb_frame with fixed 1514 + fragment list allocations, 
> > sysctl_hot_list_len = 1024.  
> 
> Something is bogus with your profile data. Increasing sysctl_hot_list_len
> never changes the frequency with which kmalloc/kfree are called. All
> it does is to produce less calls to kmem_cache_alloc() for the skb head,
> but the skb data portion is always allocated using kmalloc().  Your 
> new profile doesn't show kmalloc so you changed something else.
> 
> 
> -andi

Agree.  What's making the numbers get better is the fact I have 
removed calls to kmalloc/kfree in alloc_akb.  This extra code path
increases latency in these high speed adapters.  Reread the post.  I 
said changing the hot list eliminated a lot of packet overruns, not
calls to kmalloc/kfree.  The data is correct.

Jeff



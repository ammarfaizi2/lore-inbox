Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWHJE7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWHJE7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 00:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWHJE7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 00:59:50 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40852 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161023AbWHJE7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 00:59:50 -0400
Date: Thu, 10 Aug 2006 14:01:53 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: mpm@selenic.com, npiggin@suse.de, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta
 information
Message-Id: <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Aug 2006 17:52:00 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> struct page overloading:
> 
> - _mapcout	=> Used to count the objects in use in a slab
> - mapping	=> Reference to the slab structure
> - index		=> Pointer to the first free element in a slab
> - lru		=> Used for list management.
> 
it seems it's time that the page struct should have more unions ;)


> There is no freelist for slabs. slabs are immediately returned to the page
> allocator.  The page allocator has its own per cpu page queues that should provide
> enough caching.
> 

I think that the advantage of Slab allocator is 
- object is already initizalized at setup, so you don't have to initialize it again at
  allocation.
- object is initialized only once when slab is created.

If a slab page is returned to page allocator ASAP, # of object initilization may
increase. 

-Kame


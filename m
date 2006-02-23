Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWBWMja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWBWMja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWBWMja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:39:30 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:3789 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751140AbWBWMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:39:29 -0500
Subject: Re: [Patch 1/3] prefetch the mmap_sem in the fault path
From: Arjan van de Ven <arjan@linux.intel.com>
To: Jes Sorensen <jes@sgi.com>
Cc: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <yq0zmkigsxf.fsf@jaguar.mkp.net>
References: <1140686152.2972.25.camel@laptopd505.fenrus.org>
	 <1140687007.4672.6.camel@laptopd505.fenrus.org>
	 <yq0zmkigsxf.fsf@jaguar.mkp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 13:39:16 +0100
Message-Id: <1140698357.4672.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 07:29 -0500, Jes Sorensen wrote:
> >>>>> "Arjan" == Arjan van de Ven <arjan@intel.linux.com> writes:
> 
> Arjan> In a micro-benchmark that stresses the pagefault path, the
> Arjan> down_read_trylock on the mmap_sem showed up quite high on the
> Arjan> profile. Turns out this lock is bouncing between cpus quite a
> Arjan> bit and thus is cache-cold a lot. This patch prefetches the
> Arjan> lock (for write) as early as possible (and before some other
> Arjan> somewhat expensive operations). With this patch, the
> Arjan> down_read_trylock basically fell out of the top of profile.
> 
> Out of curiousity, how big was the box used for testing? It might be
> worth investigating if anything can be done to reduce the number of
> times that lock is taken in the first place.
> 
> After all, what's a pain on a 4-way tends to be an utter nightmare on
> a 16-way ;(

most of it was done on a 2 way, but some tests were done on a 4-way.

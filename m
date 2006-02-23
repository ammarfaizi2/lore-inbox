Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWBWKPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWBWKPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWBWKPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:15:42 -0500
Received: from ns.suse.de ([195.135.220.2]:61323 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751706AbWBWKPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:15:41 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@intel.linux.com>
Subject: Re: [Patch 1/3] prefetch the mmap_sem in the fault path
Date: Thu, 23 Feb 2006 11:14:52 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140686152.2972.25.camel@laptopd505.fenrus.org> <200602231039.36338.ak@suse.de> <1140688058.4672.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1140688058.4672.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231114.52786.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 10:47, Arjan van de Ven wrote:
> On Thu, 2006-02-23 at 10:39 +0100, Andi Kleen wrote:
> > On Thursday 23 February 2006 10:30, Arjan van de Ven wrote:
> > > In a micro-benchmark that stresses the pagefault path, the down_read_trylock
> > > on the mmap_sem showed up quite high on the profile. Turns out this lock is
> > > bouncing between cpus quite a bit and thus is cache-cold a lot. This patch
> > > prefetches the lock (for write) as early as possible (and before some other
> > > somewhat expensive operations). With this patch, the down_read_trylock
> > > basically fell out of the top of profile.
> > 
> > It is hard to believe because you effectively didn't do the prefetch
> > very early
> 
> all you need is a few dozen cycles though; there's a cr2 move and the
> entire notifier inbetween.... neither of those is really cheap.

Ok. I added that patch.

-Andi

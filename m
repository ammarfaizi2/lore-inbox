Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWBXSwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWBXSwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBXSwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:52:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43423 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932393AbWBXSwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:52:34 -0500
Date: Fri, 24 Feb 2006 18:52:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@intel.linux.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 2/3] fast VMA recycling
Message-ID: <20060224185231.GB5816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@intel.linux.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140687029.4672.8.camel@laptopd505.fenrus.org> <200602231042.53696.ak@suse.de> <1140688131.4672.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140688131.4672.21.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 10:48:50AM +0100, Arjan van de Ven wrote:
> On Thu, 2006-02-23 at 10:42 +0100, Andi Kleen wrote:
> > On Thursday 23 February 2006 10:30, Arjan van de Ven wrote:
> > > This patch adds a per task-struct cache of a free vma. 
> > > 
> > > In normal operation, it is a really common action during userspace mmap 
> > > or malloc to first allocate a vma, and then find out that it can be merged,
> > > and thus free it again. In fact this is the case roughly 95% of the time.
> > > 
> > > In addition, this patch allows code to "prepopulate" the cache, and
> > > this is done as example for the x86_64 mmap codepath. The advantage of this
> > > prepopulation is that the memory allocation (which is a sleeping operation
> > > due to the GFP_KERNEL flag, potentially causing either a direct sleep or a 
> > > voluntary preempt sleep) will happen before the mmap_sem is taken, and thus 
> > > reduces lock hold time (and thus the contention potential)
> > 
> > The slab fast path doesn't sleep. 
> 
> it does via might_sleep()

so turn of the voluntary preempt bullshit. 


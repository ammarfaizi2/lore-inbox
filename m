Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUGNSRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUGNSRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267498AbUGNSRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:17:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10984 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267497AbUGNSRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:17:33 -0400
Date: Wed, 14 Jul 2004 23:47:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714181713.GB3935@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714085758.GA4165@obelix.in.ibm.com> <20040714170800.GC4636@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714170800.GC4636@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:08:00AM -0700, Greg KH wrote:
> On Wed, Jul 14, 2004 at 02:27:58PM +0530, Ravikiran G Thirumalai wrote:
> > might be a bit yucky to assume atomic_t internals, but it is just one header
> > file :) <ducks>
> 
> I still think you need to fix this, manipulating atomic_t variables by
> hand is not always guaranteed to work on all arches, from what I
> remember.

AFAICS, the hash-locked refcounting grabs a spin lock for all
operations on the atomic_t. Any reason why that should not be safe ?
Of course, I can't see why we can't have two versions of the
reference counter depending on __HAVE_ARCH_CMPXCHG. Kiran ?

> 
> And what arches do not support cmpxchg?  How does this change affect the
> performance of them?

mips64, smp arm ?? ;-)

With a hashed lock, it should not be all that bad in low-end SMPs.
Besides we already use such a thing in gettimeofday implementation
with a global lock. However this is a valid issue and performance #s
from those arch users would be useful.

Thanks
Dipankar

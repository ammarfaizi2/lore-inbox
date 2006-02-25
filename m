Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWBYVuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWBYVuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWBYVuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:50:19 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16293 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750914AbWBYVuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:50:18 -0500
Subject: Re: [PATCH] slab: Don't scan cache_cache
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clameter@sgi.com,
       manfred@colorfullife.com, mark.fasheh@oracle.com,
       alok.kataria@calsoftinc.com, kiran@scalex86.org
In-Reply-To: <Pine.LNX.4.64.0602240815010.20760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0602240950050.16521@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0602240815010.20760@schroedinger.engr.sgi.com>
Date: Sat, 25 Feb 2006 23:50:13 +0200
Message-Id: <1140904214.11182.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Pekka J Enberg wrote:
> > From: Pekka Enberg <penberg@cs.helsinki.fi>
> > 
> > The cache_cache object cache is used for bootstrapping, but the cache is
> > essentially static. It is unlikely that we ever have more than one page
> > allocated for it. As SLAB_NO_REAP is gone now, fix a regression by skipping
> > cache_cache explicitly in cache_reap().

On Fri, 2006-02-24 at 08:16 -0800, Christoph Lameter wrote:
> There are other essentially static caches as well. Could we have something 
> more general?
> 
> Are you really seeing any measurable regression?

I haven't measured it but it seems obvious enough that especially for
low end boxes. I don't think something more general is required because
other static caches should use kmalloc() instead.

			Pekka


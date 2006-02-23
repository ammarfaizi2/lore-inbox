Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWBWSsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWBWSsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWBWSsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:48:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4741 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751316AbWBWSsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:48:09 -0500
Date: Thu, 23 Feb 2006 10:47:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Christoph Lameter <clameter@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Alok Kataria <alok.kataria@calsoftinc.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
In-Reply-To: <1140719812.11455.1.camel@localhost>
Message-ID: <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain> 
 <20060223020957.478d4cc1.akpm@osdl.org>  <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
  <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com>
 <1140719812.11455.1.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Pekka Enberg wrote:

> Look at the loop, it is redundant work (like acquiring/releasing a
> spinlock). The cache_cache is practically static, which is why it makes
> sense to leave it alone.

There is a loop but its broken by

			p = l3->slabs_free.next;
                        if (p == &(l3->slabs_free))
                                break;

One cache_reap() may scan the free list but once its free the code is 
skipped.

There are potentially large amounts of other caches around that are also 
basically static and which also would need any bypass that we may 
implement.


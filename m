Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWBGAVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWBGAVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBGAVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:21:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19868 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932389AbWBGAVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:21:47 -0500
Date: Mon, 6 Feb 2006 16:21:12 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch 2/3] NUMA slab locking fixes - move irq disabling from
 cahep->spinlock to l3 lock
In-Reply-To: <20060206153008.361202e1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602061610530.19350@schroedinger.engr.sgi.com>
References: <20060203205341.GC3653@localhost.localdomain>
 <20060203140748.082c11ee.akpm@osdl.org> <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
 <20060204010857.GG3653@localhost.localdomain> <20060204012800.GI3653@localhost.localdomain>
 <20060204014828.44792327.akpm@osdl.org> <20060206225117.GB3578@localhost.localdomain>
 <20060206153008.361202e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andrew Morton wrote:

> > Actually, it does not protect much anymore.  Here's a cleanup+comments
> > patch (against current mainline).
> 
> This is getting scary.  Manfred, Christoph, Pekka: have you guys taken a
> close look at what's going on in here?

I looked at his patch and he seems to be right. Most of the kmem_cache 
structure is established at slab creation. Updates are to the debug 
counters and to nodelists[] during node online/offline and to array[] 
during cpu online/offline. The chain mutex is used to protect the 
setting of the tuning parameters. I still need to have a look at the 
details though.



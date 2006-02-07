Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWBGHg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWBGHg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWBGHg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:36:56 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:37298 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964993AbWBGHgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:36:55 -0500
Date: Tue, 7 Feb 2006 09:36:40 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       shai@scalex86.org, alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 2/3] NUMA slab locking fixes - move irq disabling from
 cahep->spinlock to l3 lock
In-Reply-To: <Pine.LNX.4.62.0602061610530.19350@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0602070925180.25555@sbz-30.cs.Helsinki.FI>
References: <20060203205341.GC3653@localhost.localdomain>
 <20060203140748.082c11ee.akpm@osdl.org> <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
 <20060204010857.GG3653@localhost.localdomain> <20060204012800.GI3653@localhost.localdomain>
 <20060204014828.44792327.akpm@osdl.org> <20060206225117.GB3578@localhost.localdomain>
 <20060206153008.361202e1.akpm@osdl.org> <Pine.LNX.4.62.0602061610530.19350@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andrew Morton wrote:
> > This is getting scary.  Manfred, Christoph, Pekka: have you guys taken a
> > close look at what's going on in here?

On Mon, 6 Feb 2006, Christoph Lameter wrote:
> I looked at his patch and he seems to be right. Most of the kmem_cache 
> structure is established at slab creation. Updates are to the debug 
> counters and to nodelists[] during node online/offline and to array[] 
> during cpu online/offline. The chain mutex is used to protect the 
> setting of the tuning parameters. I still need to have a look at the 
> details though.

The patch looks correct but I am wondering if we should keep the spinlock 
around for clarity? The chain mutex doesn't really have anything to do 
with the tunables, it's there to protect the cache chain. I am worried 
that this patch makes code restructuring harder. Hmm?

				Pekka

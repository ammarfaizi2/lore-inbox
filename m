Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbVLMWaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVLMWaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVLMWaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:30:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35563 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030284AbVLMWaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:30:08 -0500
Date: Tue, 13 Dec 2005 14:29:56 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
In-Reply-To: <20051213142346.ccd3081a.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0512131428460.24002@schroedinger.engr.sgi.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
 <439D39A8.1020806@cosmosbay.com> <20051212020211.1394bc17.pj@sgi.com>
 <20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com>
 <439EF75D.50206@cosmosbay.com> <Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
 <439F0B43.4080500@cosmosbay.com> <20051213130350.464a3054.pj@sgi.com>
 <439F3F6E.6010701@cosmosbay.com> <20051213142346.ccd3081a.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Paul Jackson wrote:

> Eric wrote:
> > struct kmem_cache  itself will be about 512*8 + some bytes
> > then for each cpu a 'struct array_cache' will be allocated (count 128 bytes 
> 
> Hmmm ... 'struct array_cache' looks to be about 6 integer words,
> so if that is the main per-CPU cost, the minimal cost of a slab
> cache (once created, before use) is about 24 bytes per cpu.
> 
> But whether its 24 or 128 bytes per cpu, that's a heavier weight
> hammer than is needed here.

The main per node costs is struct kmem_list3 on top of the array_cache.


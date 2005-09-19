Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVISTJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVISTJA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVISTJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:09:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:13244 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932545AbVISTI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:08:59 -0400
Date: Mon, 19 Sep 2005 12:08:48 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alokk@calsoftinc.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <432F09DA.7050408@vc.cvut.cz>
Message-ID: <Pine.LNX.4.62.0509191206280.26247@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org>
 <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org>
 <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org>
 <432F09DA.7050408@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Petr Vandrovec wrote:

> I've thought that this is problem, but as far as I can tell while this is
> problem it does not happen here.  Just free_block() finds that pointer it
> got from caller belongs to the slab that belongs to the CPU#1/node#1
> while caller obtained lock on CPU#0/node#0 structures.  Which suggests
> that drain_array_locked() was issued with node #0 while array_cache->entry
> it got contains blocks which belong to node #1.  Which I cannot explain.

That can happen if node 0 runs out of memory and the page_allocator falls 
back to take memory from node 1 for node 0 requests.

Maybe we have a problem here.


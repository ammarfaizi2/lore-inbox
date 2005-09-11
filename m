Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVIKDBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVIKDBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 23:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVIKDBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 23:01:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:33980 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932328AbVIKDBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 23:01:23 -0400
Date: Sat, 10 Sep 2005 20:01:17 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG at mm/slab.c:662 - current 2.6.13-git (commit 87fc...)
 crashes on x86-64
In-Reply-To: <43232E65.4000504@vc.cvut.cz>
Message-ID: <Pine.LNX.4.62.0509101948230.20145@schroedinger.engr.sgi.com>
References: <4322DF10.9080204@vc.cvut.cz> <Pine.LNX.4.62.0509101023120.18771@schroedinger.engr.sgi.com>
 <43232E65.4000504@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Petr Vandrovec wrote:

> Christoph Lameter wrote:
> > Actually the kernel configuration you mentioned (SMP with K8 NUMA support
> > booted on single processor) was the primary development platform for the
> > patch. 
> > CONFIG_DEBUG_SLAB=y
> 
> Strange...  I had to apply patch below - after doing that everything seems to
> be happy and running.  Though it is not right fix, it seems to work fine
> here...

Hmmm. That is strange indeed and would mean that one of the initial caches 
has not correctly been initialized or we are using a smaller cache size 
than the management caches. With your patch the system fell 
back to a larger size slab (which seems to be present). Weird.

What is your setting for L1_CACHE_BYTES?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVBQA6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVBQA6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVBQA6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:58:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:65173 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262001AbVBQA6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:58:01 -0500
Date: Wed, 16 Feb 2005 16:57:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: page fault scalability patchsets update: prezeroing, prefaulting
 and atomic operations
In-Reply-To: <1107304296.5131.13.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.58.0502161646490.11394@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au>  <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
  <41E5BC60.3090309@yahoo.com.au>  <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
  <20050113031807.GA97340@muc.de>  <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
  <20050113180205.GA17600@muc.de>  <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
  <20050114043944.GB41559@muc.de>  <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
  <20050114170140.GB4634@muc.de>  <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
  <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com> 
 <41FF00CE.8060904@yahoo.com.au>  <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
 <1107304296.5131.13.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I save myself the constant crossposting of large amounts of
patches. Patches, documentation, test results etc are available at

http://oss.sgi.com/projects/page_fault_performance/

Changes:
- Performance tests for all patchsets (i386 single processor,
  Altix 8 processors and Altix 128 processors)
- Archives of patches so far
- Some docs (still needs work)
- Patches against 2.6.11-rc4-bk4

Patch specific:

atomic operations for page faults (V17)

- Avoid incrementing page count for page in do_wp_page (see discussion
  with Nick Piggin on last patchset)

prezeroing (V7)

- set /proc/sys/vm/scrub_load to 1 by default to avoid slight performance
  loss during kernel compile on i386
- Scrubd needs to be configured in kernel configuration as an experimental
  feature.
- Patch still follows kswapd's method to bind node specific scrubd daemons
  to each NUMA node. Cannot find any new infrastructure to assign tasks to
  certain nodes. kthread_bind() binds to single cpu and not to a NUMA
  node. Guess other API work would have to be first done to realize
  Andrews proposed approach.

prefaulting (V5)

- Set default for /proc/sys/vm/max_prealloc_order to 1 to avoid
  overallocating pages which led to a performance loss in some
  situations.

This is pretty complex thing to manage so please tell me if I missed
anything ...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754607AbWKHRkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbWKHRkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbWKHRkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:40:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29888 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1754607AbWKHRkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:40:24 -0500
Date: Wed, 8 Nov 2006 09:40:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061108092106.1d3a2971.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0611080934220.14111@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <20061103172605.e646352a.pj@sgi.com>
 <20061103174206.53f2c49e.akpm@osdl.org> <20061104025128.ca3c9859.pj@sgi.com>
 <Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
 <20061108022136.3b9b0748.pj@sgi.com> <1162999085.14238.17.camel@twins>
 <20061108090644.f23d37de.pj@sgi.com> <1163005750.14238.19.camel@twins>
 <20061108092106.1d3a2971.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The event counters we are considering are per cpu and you can ask the vm 
statistics subsystem to give you per cpu or global counts. The global 
counts are calculated by summing up all per processor counts.

We also have other counters (ZVC) that are per zone (they are updated per 
cpu per zone.. and are extremely scalable as well). Values can be obtained 
for those by zone, node or global. The global counters and the per zone 
counters do *not* have to be summed up (unlike event counters) but are 
kept current (within a certain delta).

If you need global counters and want to avoid summing up over all 
processors then I would suggest that you use a ZVC or look at the existing 
ZVCs and see if any of those are usable for you.

For ZVCs see include/linux/mmzone.h

For event counters see include/linux/vmstat.h
